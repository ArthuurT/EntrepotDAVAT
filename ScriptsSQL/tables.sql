DROP TABLE IF EXISTS FactureHotel;
DROP TABLE IF EXISTS FactureResto;
DROP TABLE IF EXISTS DimensionDate;
DROP TABLE IF EXISTS DimensionModePaiement;
DROP TABLE IF EXISTS DimensionProduit;
DROP TABLE IF EXISTS DimensionClient;
DROP TABLE IF EXISTS DimensionMeteo;

DROP TYPE IF EXISTS PointDeVente;
DROP TYPE IF EXISTS Titre;

CREATE TABLE IF NOT EXISTS DimensionDate(
	idDate INT PRIMARY KEY,
	date DATE UNIQUE NOT NULL,
	annee SMALLINT NOT NULL CHECK(annee = EXTRACT (YEAR FROM date)),
	mois SMALLINT NOT NULL CHECK (mois = EXTRACT (MONTH FROM date)),
	jour SMALLINT NOT NULL CHECK (jour = EXTRACT (DAY FROM date)),
	vacancesScolaire BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS DimensionModePaiement(
	idModePaiement INT PRIMARY KEY,
	modePaiement VARCHAR(20) UNIQUE NOT NULL
);
								  
CREATE TYPE PointDeVente AS ENUM('HOTEL', 'RESTAURANT', 'BAR');								  
								  
CREATE TABLE IF NOT EXISTS DimensionProduit(
	idProduit INT PRIMARY KEY,
	libelle VARCHAR(50),
	pointDeVente PointDeVente NOT NULL,
	codeFamilleVente VARCHAR(5),
	familleVente VARCHAR(50),
	codeMC VARCHAR(20),
	tauxTVA float8 NOT NULL
);								  

CREATE TYPE Titre AS ENUM('Mr', 'Mme');								  
								  
CREATE TABLE IF NOT EXISTS DimensionClient(
	idClient INT PRIMARY KEY,
	nom VARCHAR(20) NOT NULL,
	prenom VARCHAR(20),
	titre Titre,
	telephone VARCHAR(15),
	email VARCHAR(50),
	pays VARCHAR(20),
	region VARCHAR(20),
	adresse VARCHAR(50),
	nationalite VARCHAR(20),
	codePostal VARCHAR(5)
);
								  
CREATE TABLE IF NOT EXISTS DimensionMeteo(
	idMeteo INT PRIMARY KEY,
	temperatureMin SMALLINT,
	temperatureMax SMALLINT,
	vitesseVentMax SMALLINT,
	precipitationMax float8,
	couvertureNuageuseMoyenne SMALLINT
);
								  
CREATE TABLE IF NOT EXISTS FactureHotel(
	idFactureHotel SERIAL PRIMARY KEY,
	idProduit INT REFERENCES DimensionProduit(idProduit),
	idClient INT REFERENCES DimensionClient(idClient),
	idModePaiement INT REFERENCES DimensionModePaiement(idModePaiement),
	idMeteo INT REFERENCES DimensionMeteo(idMeteo),
	idDate INT REFERENCES DimensionDate(idDate),
	numeroNote INT NOT NULL,
	quantite SMALLINT NOT NULL CHECK (quantite > 0),
	prixUnitaire float8 NOT NULL,
	dateArrivee DATE NOT NULL,
	dateDepart DATE NOT NULL,
	nbNuitees SMALLINT NOT NULL,
	nbAdultes SMALLINT NOT NULL,
	nbEnfants SMALLINT NOT NULL
);
								  
CREATE TABLE IF NOT EXISTS FactureResto(
	idFactureResto SERIAL PRIMARY KEY,
	idProduit INT REFERENCES DimensionProduit(idProduit),
	idClient INT REFERENCES DimensionClient(idClient),
	idModePaiement INT REFERENCES DimensionModePaiement(idModePaiement),
	idMeteo INT REFERENCES DimensionMeteo(idMeteo),
	idDate INT REFERENCES DimensionDate(idDate),
	numeroNote INT NOT NULL,
	quantite SMALLINT NOT NULL CHECK (quantite > 0),
	prixUnitaire float8 NOT NULL,
	nbCouverts SMALLINT NOT NULL
);