require 'csv'
meteo2017 = CSV.read("meteoAixLesBains2017.csv")
meteo2018 = CSV.read("meteoAixLesBains2018.csv",:quote_char => ",")
date = CSV.read("../Dates/Dates.csv")
meteo2017_cible = CSV.open("meteoAixLesBains2017v2.csv","w")
meteo2018_cible = CSV.open("meteoAixLesBains2018v2.csv","w")
headers = meteo2017[0][0].split(";")
meteo2017_cible << headers
meteo2018_cible << headers

CSV.foreach('meteoAixLesBains2017.csv', col_sep: ';') { |meteo|
    annee = meteo[0].split("-")[0]
    mois = meteo[0].split("-")[1]
    jour = meteo[0].split("-")[2]
    complete = jour.to_s + "/" + mois.to_s + "/" + annee.to_s
   
    CSV.foreach("../Dates/Dates.csv") { |date|
        if meteo[0] != "Date" then
            if complete == date[4] then
                meteo[6] = date[0]
                meteo2017_cible << meteo
            end
        end
    }
}

CSV.foreach('meteoAixLesBains2018.csv', col_sep: ';') { |meteo|
    annee = meteo[0].split("-")[0]
    mois = meteo[0].split("-")[1]
    jour = meteo[0].split("-")[2]
    complete = jour.to_s + "/" + mois.to_s + "/" + annee.to_s

    CSV.foreach("../Dates/Dates.csv") { |date|
        if meteo[0] != "Date" then
            if complete == date[4] then
                meteo[6] = date[0]
                meteo2018_cible << meteo
            end
        end
    }
}
