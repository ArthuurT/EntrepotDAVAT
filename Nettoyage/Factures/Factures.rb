require 'csv'
require 'date'

headers = CSV.read("factures.csv", col_sep: ';', headers: true, encoding: "utf-8").headers << "IndexDate" << "IndexMeteo"
resto = CSV.open("facturesRestaurant_sortie.csv", "w", col_sep: ";")
hotel = CSV.open("facturesHotel_sortie.csv", "w", col_sep: ";")
hotel << headers
resto << headers

cacheIndexDate = Hash.new
cacheIndexMeteo = Hash.new

def absolute(value)
    return value.delete("-")
end

def isHotel(value)
    return value == "TAXE" || value == "CHB" || value == "PDJ" || value == "FORFAIT" || value == "DIV" || value == "DEB"
end

def dateFormator(date)
    jour = date.split("/")[0]
    mois = date.split("/")[1]
    annee = date.split("/")[2]
    return annee + "-" + mois + "-" + jour
end

CSV.foreach('factures.csv', col_sep: ';', headers: true, encoding: 'utf-8') { |row|
    row["PrixUnitaire"] = absolute(row["PrixUnitaire"])
    row["DatePrestation"] = dateFormator(row["DatePrestation"])
    if row["DateArrivee"] != nil && row["DateDepart"] != nil then
        row["DateDepart"] = dateFormator(row["DateDepart"])
        row["DateArrivee"] = dateFormator(row["DateArrivee"])
    end
    
    if cacheIndexDate[row["DatePrestation"]] == nil then
        CSV.foreach('../Dates/dates_sortie.csv', col_sep: ';', headers: true) { |date|
            if date["Date"] == row["DatePrestation"] then
                row["IndexDate"] = date["IndexDate"]
                cacheIndexDate[row["DatePrestation"]] = date["IndexDate"]
                break
            end
        }
    else
        row["IndexDate"] = cacheIndexDate[row["DatePrestation"]]
    end

    if cacheIndexMeteo[row["DatePrestation"]] == nil then
        CSV.foreach('../Meteo/meteoAixLesBains_sortie.csv', col_sep: ';', headers: true, encoding: 'utf-8') { |meteoRow|
            if (meteoRow["DATE"] == row["DatePrestation"]) then
                row["IndexMeteo"] = meteoRow["IndexMeteo"]
                cacheIndexMeteo[row["DatePrestation"]] = meteoRow["IndexMeteo"]
                break
            end
        }
    else
        row["IndexMeteo"] = cacheIndexMeteo[row["DatePrestation"]]
    end

    if(row["nbcouverts"] != nil) then
        resto << row
    else 
        if isHotel(row["CodeStatistique"]) then 
            hotel << row
        else 
            row["nbcouverts"] = row["NbAdultes"].to_i + row["NbEnfants"].to_i
            resto << row
        end
    end
}