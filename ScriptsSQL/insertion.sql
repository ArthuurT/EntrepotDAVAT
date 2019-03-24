DELETE FROM facture_resto;
DELETE FROM facture_hotel;
DELETE FROM dimension_date;
DELETE FROM dimension_mode_paiement;
DELETE FROM dimension_meteo;
DELETE FROM dimension_produit;
DELETE FROM dimension_client;

INSERT INTO dimension_date 
SELECT index_date, date, annee, mois, jour, semaine, vacances_scolaires
FROM dates_csv;

INSERT INTO dimension_mode_paiement
SELECT index_mode_reglement, mode_reglement
FROM modes_reglement_csv;

INSERT INTO dimension_meteo
SELECT index_meteo, temperature_min, temperature_max, vitesse_vent, precipitation_journee, couverture_nuagueuse
FROM meteo_csv;

INSERT INTO dimension_produit
SELECT index_produit, libelle_produit, point_de_vente, code_famille_vente, libelle_famille_vente, code_mc, taux_tva
FROM produits_csv;

INSERT INTO dimension_client
SELECT index_client, nom, prenom, titre, telephone, adr_internet, pays, region, adresse, nationalite, code_postal
FROM clients_csv;

INSERT INTO facture_hotel (id_produit, id_client, id_mode_paiement, id_meteo, id_date, numero_note, quantite, prix_unitaire, date_arrivee, date_depart, nb_nuitees, nb_adultes, nb_enfants)
SELECT index_produit, index_client, index_mode_reglement, index_meteo, index_date, index_note, quantite, prix_unitaire, date_arrivee, date_depart, nuitees, nb_adultes, nb_enfants
FROM factures_hotel_csv;

INSERT INTO facture_resto (id_produit, id_client, id_mode_paiement, id_meteo, id_date, numero_note, quantite, prix_unitaire, nb_couverts)
SELECT index_produit, index_client, index_mode_reglement, index_meteo, index_date, index_note, quantite, prix_unitaire, nb_couverts
FROM factures_restaurant_csv;