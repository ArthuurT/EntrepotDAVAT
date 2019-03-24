DROP TABLE IF EXISTS facture_hotel;
DROP TABLE IF EXISTS facture_resto;
DROP TABLE IF EXISTS dimension_date;
DROP TABLE IF EXISTS dimension_mode_paiement;
DROP TABLE IF EXISTS dimension_produit;
DROP TABLE IF EXISTS dimension_client;
DROP TABLE IF EXISTS dimension_meteo;

DROP TYPE IF EXISTS type_point_de_dente;
DROP TYPE IF EXISTS type_titre;

CREATE TABLE IF NOT EXISTS dimension_date(
	id_date INT PRIMARY KEY,
	date DATE UNIQUE NOT NULL,
	annee SMALLINT NOT NULL CHECK(annee = EXTRACT (YEAR FROM date)),
	mois SMALLINT NOT NULL CHECK (mois = EXTRACT (MONTH FROM date)),
	jour SMALLINT NOT NULL CHECK (jour = EXTRACT (DAY FROM date)),
	semaine SMALLINT NOT NULL,
	vacances_scolaire BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS dimension_mode_paiement(
	id_mode_paiement INT PRIMARY KEY,
	mode_paiement VARCHAR(20) UNIQUE NOT NULL
);
								  
CREATE TYPE type_point_de_vente AS ENUM('HOTEL', 'RESTAURANT', 'BAR');								  
								  
CREATE TABLE IF NOT EXISTS dimension_produit(
	id_produit INT PRIMARY KEY,
	libelle VARCHAR(50),
	point_de_vente type_point_de_vente NOT NULL,
	code_famille_vente VARCHAR(5),
	famille_vente VARCHAR(50),
	code_mc VARCHAR(20),
	taux_tva float8 NOT NULL
);								  

CREATE TYPE type_titre AS ENUM('Mr', 'Mme');								  
								  
CREATE TABLE IF NOT EXISTS dimension_client(
	id_client INT PRIMARY KEY,
	nom VARCHAR(20) NOT NULL,
	prenom VARCHAR(20),
	titre type_titre,
	telephone VARCHAR(15),
	email VARCHAR(50),
	pays VARCHAR(20),
	region VARCHAR(20),
	adresse VARCHAR(50),
	nationalite VARCHAR(20),
	code_postal VARCHAR(5)
);
								  
CREATE TABLE IF NOT EXISTS dimension_meteo(
	id_meteo INT PRIMARY KEY,
	temperature_min SMALLINT,
	temperature_max SMALLINT,
	vitesse_vent_max SMALLINT,
	precipitation_max float8,
	couverture_nuageuse_moyenne SMALLINT
);
								  
CREATE TABLE IF NOT EXISTS facture_hotel(
	id_facture_hotel SERIAL PRIMARY KEY,
	id_produit INT REFERENCES dimension_produit(id_produit),
	id_client INT REFERENCES dimension_client(id_client),
	id_mode_paiement INT REFERENCES dimension_mode_paiement(id_mode_paiement),
	id_meteo INT REFERENCES dimension_meteo(id_meteo),
	id_date INT REFERENCES dimension_date(id_date),
	numero_note INT NOT NULL,
	quantite SMALLINT NOT NULL CHECK (quantite > 0),
	prix_unitaire float8 NOT NULL,
	date_arrivee DATE NOT NULL,
	date_depart DATE NOT NULL,
	nb_nuitees SMALLINT NOT NULL,
	nb_adultes SMALLINT NOT NULL,
	nb_enfants SMALLINT NOT NULL
);
								  
CREATE TABLE IF NOT EXISTS facture_resto(
	id_facture_resto SERIAL PRIMARY KEY,
	id_produit INT REFERENCES dimension_produit(id_produit),
	id_client INT REFERENCES dimension_client(id_client),
	id_mode_paiement INT REFERENCES dimension_mode_paiement(id_mode_paiement),
	id_meteo INT REFERENCES dimension_meteo(id_meteo),
	id_date INT REFERENCES dimension_date(id_date),
	numero_note INT NOT NULL,
	quantite SMALLINT NOT NULL CHECK (quantite > 0),
	prix_unitaire float8 NOT NULL,
	nb_couverts SMALLINT NOT NULL
);