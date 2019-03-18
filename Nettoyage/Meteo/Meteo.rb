require 'csv'

headers = CSV.read("meteoAixLesBains2017.csv", col_sep: ',', headers: true, encoding: "utf-8").headers << "IndexMeteo"
meteo_cible = CSV.open("meteoAixLesBains_sortie.csv", "w", col_sep: ';', encoding: 'utf-8');
meteo_cible << headers

index = 0;

CSV.foreach('meteoAixLesBains2017.csv', col_sep: ',', encoding: 'utf-8', headers: true) { |meteo|
    index += 1
    meteo["IndexMeteo"] = index
    meteo_cible << meteo
}

CSV.foreach('meteoAixLesBains2018.csv', col_sep: ',', encoding: 'utf-8', headers: true) { |meteo|
    index += 1
    meteo["IndexMeteo"] = index
    meteo_cible << meteo
}
