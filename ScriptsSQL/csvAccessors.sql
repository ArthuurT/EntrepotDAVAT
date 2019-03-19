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
	IndexClient INT,
	NomClient VARCHAR(20),
	Prenom VARCHAR(20),
	Telephone VARCHAR(15),
	Adresse VARCHAR(50),
	AdrInternet VARCHAR(50),
	Titre Titre,
	Pays VARCHAR(20),
	Nationalite VARCHAR(20),
	CodePays VARCHAR(5),
	Region VARCHAR(20),
	CodePostal VARCHAR(5)
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Client\clients_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS dates_csv(
	IndexDate INT,
	Annee SMALLINT,
	Mois SMALLINT,
	JOUR SMALLINT,
	Date DATE,
	VacancesScolaires BOOLEAN
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Dates\dates_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS meteo_csv(
	DATE DATE,
	MAX_TEMPERATURE_C SMALLINT,
	MIN_TEMPERATURE_C SMALLINT,
	WINDSPEED_MAX_KMH SMALLINT,
	TEMPERATURE_MORNING_C SMALLINT,
	TEMPERATURE_NOON_C SMALLINT,
	TEMPERATURE_EVENING_C SMALLINT,
	PRECIP_TOTAL_DAY_MM float8,
	HUMIDITY_MAX_PERCENT SMALLINT,
	VISIBILITY_AVG_KM float8,
	PRESSURE_MAX_MB SMALLINT,
	CLOUDCOVER_AVG_PERCENT float8,
	HEATINDEX_MAX_C SMALLINT,
	DEWPOINT_MAX_C SMALLINT,
	WINDTEMP_MAX_C SMALLINT,
	WEATHER_CODE_MORNING SMALLINT,
	WEATHER_CODE_NOON SMALLINT,
	WEATHER_CODE_EVENING SMALLINT,
	OPINION VARCHAR(100),
	IndexMeteo INT
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Meteo\meteoAixLesBains_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS produits_csv(
	IndexPrdVente INT,
	CodePrdVente VARCHAR(20),
	LibellePrdVente VARCHAR(50),
	CodeFamilleVente VARCHAR(5),
	LibelleFamilleVente VARCHAR(50),
	TauxTva float8,
	CodeMC VARCHAR(20),
	CodeStatistiques VARCHAR(20),
	PointDeVente pointdevente
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Produits\produits_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS modes_reglement_csv(
	IndexModeReglement INT,
	CodeModeReglement VARCHAR(3),
	ModeReglement VARCHAR(20)
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Reglement\modesReglement.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS factures_hotel_csv(
	IndexNote INT,
	IndexClient INT,
	nbcourverts SMALLINT,
	DateDepart DATE,
	DateArrivee DATE,
	NbAdultes SMALLINT,
	NbEnfants SMALLINT,
	Nuitees SMALLINT,
	IModeReglement INT,
	DatePrestation DATE,
	PrixUnitaire float8,
	Quantite SMALLINT,
	IProduitVente INT,
	CodeStatistique VARCHAR(20),
	LibelleStatistique VARCHAR(200),
	IndexDate INT,
	IndexMeteo INT
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Factures\facturesHotel_sortie.csv', format 'csv', delimiter ';');

CREATE FOREIGN TABLE IF NOT EXISTS factures_restaurant_csv(
	IndexNote INT,
	IndexClient INT,
	nbcouverts SMALLINT,
	DateDepart DATE,
	DateArrivee DATE,
	NbAdultes SMALLINT,
	NbEnfants SMALLINT,
	Nuitees SMALLINT,
	IModeReglement INT,
	DatePrestation DATE,
	PrixUnitaire float8,
	Quantite SMALLINT,
	IProduitVente INT,
	CodeStatistique VARCHAR(20),
	LibelleStatistique VARCHAR(200),
	IndexDate INT,
	IndexMeteo INT
) SERVER my_csv_accessor
OPTIONS (header 'true', filename 'D:\Universite\Semestre 8\BDDs\Projet\EntrepotDAVAT\Nettoyage\Factures\facturesRestaurant_sortie.csv', format 'csv', delimiter ';');