DELETE FROM factureresto;
DELETE FROM facturehotel;
DELETE FROM dimensiondate;
DELETE FROM dimensionmodepaiement;
DELETE FROM dimensionmeteo;
DELETE FROM dimensionproduit;
DELETE FROM dimensionclient;

INSERT INTO dimensiondate 
SELECT IndexDate, Date, Annee, Mois, Jour, VacancesScolaires
FROM dates_csv;

INSERT INTO dimensionmodepaiement
SELECT IndexModeReglement, ModeReglement
FROM modes_reglement_csv;

INSERT INTO dimensionmeteo
SELECT IndexMeteo, MIN_TEMPERATURE_C, MAX_TEMPERATURE_C, WINDSPEED_MAX_KMH, PRECIP_TOTAL_DAY_MM, CLOUDCOVER_AVG_PERCENT
FROM meteo_csv;

INSERT INTO dimensionproduit
SELECT IndexPrdVente, LibellePrdVente, PointDeVente, CodeFamilleVente, LibelleFamilleVente, CodeMC, TauxTva
FROM produits_csv;

INSERT INTO dimensionclient
SELECT IndexClient, NomClient, Prenom, Titre, Telephone, AdrInternet, Pays, Region, Adresse, Nationalite, CodePostal
FROM clients_csv;

INSERT INTO facturehotel (idProduit, idClient, idModePaiement, idMeteo, idDate, numeroNote, quantite, prixUnitaire, dateArrivee, dateDepart, nbNuitees, nbAdultes, NbEnfants)
SELECT IProduitVente, IndexClient, IModeReglement, IndexMeteo, IndexDate, IndexNote, Quantite, PrixUnitaire, DateArrivee, DateDepart, Nuitees, NbAdultes, NbEnfants
FROM factures_hotel_csv;

INSERT INTO factureresto (idProduit, idClient, idModePaiement, idMeteo, idDate, numeroNote, quantite, prixUnitaire, nbCouverts)
SELECT IProduitVente, IndexClient, IModeReglement, IndexMeteo, IndexDate, IndexNote, Quantite, PrixUnitaire, nbcouverts
FROM factures_restaurant_csv;