CREATE EXTENSION IF NOT EXISTS file_fdw;

CREATE SERVER IF NOT EXISTS my_csv_accessor FOREIGN DATA WRAPPER file_fdw;

DROP FOREIGN TABLE IF EXISTS clients_csv;
DROP FOREIGN TABLE IF EXISTS dates_csv;
DROP FOREIGN TABLE IF EXISTS meteo_csv;
DROP FOREIGN TABLE IF EXISTS produits_csv;
DROP FOREIGN TABLE IF EXISTS modes_reglement_csv;
DROP FOREIGN TABLE IF EXISTS factures_hotel_csv;
DROP FOREIGN TABLE IF EXISTS factures_restaurant_csv;

CREATE FOREIGN TABLE IF NOT EXISTS clients_csv(
	index_client INT,
	nom VARCHAR(20),
	prenom VARCHAR(20),
	telephone VARCHAR(15),
	adresse VARCHAR(50),
	adr_internet VARCHAR(50),
	titre type_titre,
	pays VARCHAR(20),
	nationalite VARCHAR(20),
	code_pays VARCHAR(5),
	region VARCHAR(20),
	code_postal VARCHAR(5)
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Client\clients_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS dates_csv(
	index_date INT,
	annee SMALLINT,
	mois SMALLINT,
	jour SMALLINT,
	date DATE,
	vacances_scolaires BOOLEAN
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Dates\dates_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS meteo_csv(
	DATE DATE,
	temperature_max SMALLINT,
	temperature_min SMALLINT,
	vitesse_vent SMALLINT,
	temperature_matin SMALLINT,
	temperature_aprem SMALLINT,
	temperature_soir SMALLINT,
	precipitation_journee float8,
	humidite_max_pourcentage SMALLINT,
	visibilite_moyenne float8,
	pression_max SMALLINT,
	couverture_nuagueuse float8,
	indice_chaleur_max SMALLINT,
	alerte_chaleur_max SMALLINT,
	temperature_vent_max SMALLINT,
	code_meteo_matin SMALLINT,
	code_meteo_aprem SMALLINT,
	code_meteo_soir SMALLINT,
	opinion VARCHAR(100),
	index_meteo INT
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Meteo\meteoAixLesBains_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS produits_csv(
	index_produit INT,
	code_produit VARCHAR(20),
	libelle_produit VARCHAR(50),
	code_famille_vente VARCHAR(5),
	libelle_famille_vente VARCHAR(50),
	taux_tva float8,
	code_mc VARCHAR(20),
	code_statistique VARCHAR(20),
	point_de_vente type_point_de_vente
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Produits\produits_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS modes_reglement_csv(
	index_mode_reglement INT,
	code_mode_reglement VARCHAR(3),
	mode_reglement VARCHAR(20)
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Reglement\modesReglement.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS factures_hotel_csv(
	index_note INT,
	index_client INT,
	nb_couverts SMALLINT,
	date_depart DATE,
	date_arrivee DATE,
	nb_adultes SMALLINT,
	nb_enfants SMALLINT,
	nuitees SMALLINT,
	index_mode_reglement INT,
	date_prestation DATE,
	prix_unitaire float8,
	quantite SMALLINT,
	index_produit INT,
	code_statistique VARCHAR(20),
	libelle_statistique VARCHAR(200),
	index_date INT,
	index_meteo INT
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Factures\facturesHotel_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS factures_restaurant_csv(
	index_note INT,
	index_client INT,
	nb_couverts SMALLINT,
	date_depart DATE,
	date_arrivee DATE,
	nb_adultes SMALLINT,
	nb_enfants SMALLINT,
	nuitees SMALLINT,
	index_mode_reglement INT,
	date_prestation DATE,
	prix_unitaire float8,
	quantite SMALLINT,
	index_produit INT,
	code_statistique VARCHAR(20),
	libelle_statistique VARCHAR(200),
	index_date INT,
	index_meteo INT
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Factures\facturesRestaurant_sortie.csv', format 'csv', delimiter ';');