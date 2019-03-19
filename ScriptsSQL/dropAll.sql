DROP FOREIGN TABLE IF EXISTS clients_csv;
DROP FOREIGN TABLE IF EXISTS dates_csv;
DROP FOREIGN TABLE IF EXISTS meteo_csv;
DROP FOREIGN TABLE IF EXISTS produits_csv;
DROP FOREIGN TABLE IF EXISTS modes_reglement_csv;
DROP FOREIGN TABLE IF EXISTS factures_hotel_csv;
DROP FOREIGN TABLE IF EXISTS factures_restaurant_csv;

DROP SERVER IF EXISTS my_csv_accessor;
DROP EXTENSION IF EXISTS file_fdw;

DROP TABLE IF EXISTS FactureHotel;
DROP TABLE IF EXISTS FactureResto;
DROP TABLE IF EXISTS DimensionDate;
DROP TABLE IF EXISTS DimensionModePaiement;
DROP TABLE IF EXISTS DimensionProduit;
DROP TABLE IF EXISTS DimensionClient;
DROP TABLE IF EXISTS DimensionMeteo;

DROP TYPE IF EXISTS PointDeVente;
DROP TYPE IF EXISTS Titre;