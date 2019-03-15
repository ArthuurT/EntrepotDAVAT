require 'csv'
require 'date'

vente = CSV.read("../PointDeVente/PointDeVente.csv")

def absolute(value)
    return value.delete("-")
end

def isHotel(value)
    return value == "TAXE" || value == "CHB" || value == "PDJ" || value == "FORFAIT" || value == "DIV" || value == "DEB"
end

def calcCouvert(value)
    return value[5].to_i + value[6].to_i
end

clients = CSV.read("factures.csv")
restau = CSV.open("facturesRestaurant.csv","w",{:col_sep => ";"})
hotel = CSV.open("facturesHotel.csv","w",{:col_sep => ";"})
headers = clients[0][0].split(";")
headers << "IndexPointDeVente"
hotel << headers
restau << headers

CSV.foreach('factures.csv', col_sep: ';').with_index(1) { |row, ln|
    if ln == 1 then next end
    row[10] = absolute(row[10])
    if row[13] == "TAXE" || row[13] == "PDJ" || row[13] == "CHB" then row[15] = 1
    elsif row[13] == "FORF" || row[13] == "REST" then row[15] = 2
    elsif row[13] == "BARA" || row[13] == "BARS" then row[15] = 3
    end
    jour_presta = row[9].split("/")[0]
    mois_presta = row[9].split("/")[1]
    annee_presta = row[9].split("/")[2]
    date_presta = Date.new(annee_presta.to_i,mois_presta.to_i,jour_presta.to_i)
    CSV.foreach('../Dates/dates.csv').with_index(1){ |date, ln|
        if ln == 1 then next end
        date_cmp = Date.new(date[1].to_i,date[2].to_i,date[3].to_i)
        if (date_cmp <=> date_presta) == 0 then  
            row[9] = date[0]
            next
        end
    }

    if(row[2] != nil) then
        restau << row
    else 
        if isHotel(row[13]) then 
            hotel << row
        else 
            row[2] = calcCouvert(row)
            restau << row
        end
    end
}