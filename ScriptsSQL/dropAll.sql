DROP FOREIGN TABLE IF EXISTS clients_csv;
DROP FOREIGN TABLE IF EXISTS dates_csv;
DROP FOREIGN TABLE IF EXISTS meteo_csv;
DROP FOREIGN TABLE IF EXISTS produits_csv;
DROP FOREIGN TABLE IF EXISTS modes_reglement_csv;
DROP FOREIGN TABLE IF EXISTS factures_hotel_csv;
DROP FOREIGN TABLE IF EXISTS factures_restaurant_csv;

DROP SERVER IF EXISTS my_csv_accessor;
DROP EXTENSION IF EXISTS file_fdw;

DROP TABLE IF EXISTS facture_hotel;
DROP TABLE IF EXISTS facture_resto;
DROP TABLE IF EXISTS dimension_date;
DROP TABLE IF EXISTS dimension_mode_paiement;
DROP TABLE IF EXISTS dimension_produit;
DROP TABLE IF EXISTS dimension_client;
DROP TABLE IF EXISTS dimension_meteo;

DROP TYPE IF EXISTS type_point_de_vente;
DROP TYPE IF EXISTS type_titre;