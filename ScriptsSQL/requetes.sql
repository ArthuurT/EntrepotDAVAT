
-- Vues:

DROP VIEW IF EXISTS facture;
CREATE OR REPLACE VIEW facture AS (
(
	SELECT hotel.numero_note, hotel.id_date, hotel.id_produit, (hotel.prix_unitaire * hotel.quantite) AS montant
	FROM facture_hotel AS hotel
)
UNION ALL
(
	SELECT resto.numero_note, resto.id_date, resto.id_produit, (resto.prix_unitaire * resto.quantite) AS montant
	FROM facture_resto AS resto
))

-- Requête 1:

SELECT dimension_produit.point_de_vente, dimension_date.annee, dimension_date.mois, SUM(facture.montant) AS TTC, SUM(facture.montant/(1 + dimension_produit.taux_tva/100)) AS HT
FROM facture
INNER JOIN dimension_date ON dimension_date.id_date = facture.id_date
INNER JOIN dimension_produit ON dimension_produit.id_produit = facture.id_produit																							  
GROUP BY GROUPING SETS ((dimension_produit.point_de_vente, dimension_date.annee, dimension_date.mois), (dimension_produit.point_de_vente, dimension_date.annee), (dimension_produit.point_de_vente), (dimension_date.annee, dimension_date.mois), (dimension_date.annee))
ORDER BY dimension_produit.point_de_vente, dimension_date.annee, dimension_date.mois

-- Requête 2:

SELECT *
FROM (
	SELECT date.annee, date.mois, produit.libelle, rank() OVER (PARTITION BY (date.annee, date.mois) ORDER BY COUNT(resto.quantite) DESC) AS classement
	FROM facture_resto AS resto
	INNER JOIN dimension_date AS date ON date.id_date = resto.id_date
	INNER JOIN dimension_produit AS produit ON produit.id_produit = resto.id_produit
	WHERE produit.point_de_vente = 'RESTAURANT'
	GROUP BY date.annee, date.mois, produit.libelle) AS classementProduit
WHERE classementProduit.classement <= 10

-- Requête 3:

SELECT date.annee, date.semaine, SUM(hotel.quantite) / 7 AS moyenne_pdj
FROM facture_hotel AS hotel
INNER JOIN dimension_produit AS produit ON produit.id_produit = hotel.id_produit
INNER JOIN dimension_date AS date ON date.id_date = hotel.id_date
WHERE produit.code_famille_vente = 'PDJ'
GROUP BY date.annee, date.semaine
ORDER BY date.semaine

-- Requête 4:

SELECT depart.date, depart.nb_depart, arrivee.nb_arrivee
FROM (
	SELECT hotel.date_depart AS date, COUNT(DISTINCT hotel.numero_note) AS nb_depart
	FROM facture_hotel AS hotel
	GROUP BY hotel.date_depart
) AS depart
INNER JOIN (
	SELECT hotel.date_arrivee AS date, COUNT(DISTINCT hotel.numero_note) AS nb_arrivee
	FROM facture_hotel AS hotel
	GROUP BY hotel.date_arrivee
) AS arrivee ON depart.date = arrivee.date

-- Requête 5:

SELECT notes_client.id_client, SUM(notes_client.prix) / COUNT(DISTINCT notes_client.numero_note) AS montant_moyen_par_visite
FROM (
	SELECT hotel.id_client, hotel.numero_note, (hotel.prix_unitaire * hotel.quantite) AS prix
	FROM facture_hotel AS hotel
	UNION
	SELECT resto.id_client, resto.numero_note, (resto.prix_unitaire * resto.quantite) AS prix
	FROM facture_resto AS resto) AS notes_client
GROUP BY notes_client.id_client 
ORDER BY montant_moyen_par_visite DESC
LIMIT 100

-- Requête 6:

SELECT duree_sejour.annee, duree_sejour.mois, AVG(duree_sejour.nb_nuitees) AS duree_moyenne_sejour
FROM (
	SELECT DISTINCT hotel.numero_note, EXTRACT(YEAR FROM hotel.date_arrivee) AS annee, EXTRACT(MONTH FROM hotel.date_arrivee) AS mois, hotel.nb_nuitees
	FROM facture_hotel AS hotel
) AS duree_sejour
GROUP BY duree_sejour.annee, duree_sejour.mois
ORDER BY duree_sejour.annee, duree_sejour.mois

-- Requête 7:

SELECT DISTINCT EXTRACT(YEAR FROM hotel.date_arrivee) AS annee, EXTRACT(MONTH FROM hotel.date_arrivee) AS mois, ((SUM(CASE WHEN client.nationalite != 'FRANCAISE' THEN 1 ELSE 0 END)::numeric / COUNT(*)::numeric) * 100)::numeric(2)
FROM facture_hotel AS hotel
INNER JOIN dimension_client AS client ON client.id_client = hotel.id_client
GROUP BY ROLLUP (annee, mois)

-- Requête 8 (montant des ventes et nb de personnes par semaine en fonction des vacances scolaire):

SELECT dimension_date.annee, dimension_date.semaine, dimension_date.vacances_scolaire, SUM(facture.montant) AS montant_ventes
FROM facture
INNER JOIN dimension_date ON dimension_date.id_date = facture.id_date
GROUP BY dimension_date.annee, dimension_date.semaine, dimension_date.vacances_scolaire
ORDER BY dimension_date.annee, dimension_date.semaine

SELECT annee, semaine, vacances_scolaire, SUM(nb_adultes + nb_enfants) AS nb_personnes
FROM (
	SELECT DISTINCT numero_note, dimension_date.annee, dimension_date.semaine, dimension_date.vacances_scolaire, nb_adultes, nb_enfants
	FROM facture_hotel
	INNER JOIN dimension_date ON dimension_date.id_date = facture_hotel.id_date
	WHERE dimension_date.date = facture_hotel.date_arrivee
) AS notes_hotel
GROUP BY annee, semaine, vacances_scolaire
ORDER BY annee, semaine

-- Requête 9:

SELECT facture.annee, facture.semaine, SUM(facture.montant) AS montant_ventes, AVG(facture.couverture_nuageuse_moyenne) AS couverture_nuageuse, AVG(facture.precipitation_max) AS precipitation
FROM (
	SELECT date.annee, date.semaine, (resto.prix_unitaire * resto.quantite) AS montant, meteo.couverture_nuageuse_moyenne, meteo.precipitation_max
	FROM facture_resto AS resto
	INNER JOIN dimension_date AS date ON date.id_date = resto.id_date
	INNER JOIN dimension_meteo AS meteo ON meteo.id_meteo = resto.id_meteo
) AS facture
GROUP BY facture.annee, facture.semaine
ORDER BY facture.annee, facture.semaine

-- Requête 10 (classement des vins les plus commandés en fonction du plat):

SELECT libelle_plat, libelle_vin, rank() OVER (PARTITION BY (libelle_plat) ORDER BY COUNT(libelle_vin) DESC) AS classement
FROM (
	SELECT plat.numero_note, libelle_plat, libelle_vin
	FROM (
		SELECT numero_note, produit.libelle AS libelle_plat
		FROM facture_resto AS resto
		INNER JOIN dimension_produit AS produit ON produit.id_produit = resto.id_produit
		WHERE produit.code_famille_vente = 'PV' OR produit.code_famille_vente = 'PO' OR produit.code_famille_vente = 'SP'
		AND numero_note NOT IN (
			SELECT numero_note
			FROM facture_resto
			INNER JOIN dimension_produit ON dimension_produit.id_produit = facture_resto.id_produit
			WHERE produit.code_famille_vente = 'EN' OR produit.code_famille_vente = 'TP')
	) AS plat
	INNER JOIN (
		SELECT numero_note, produit.libelle AS libelle_vin
		FROM facture_resto AS resto
		INNER JOIN dimension_produit AS produit ON produit.id_produit = resto.id_produit
		WHERE produit.code_famille_vente LIKE 'V%'
	) AS vin ON plat.numero_note = vin.numero_note
) AS notes
GROUP BY libelle_plat,libelle_vin
