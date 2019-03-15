require 'csv'
vacances = CSV.read("calendrierVacancesScolaires.csv")
sortie = CSV.open("calendrierVacancesScolairesV2.csv","w")

def goodZone(zone)
    return (zone == "Zone A" || zone == "Zone B" || zone == "Zone C")
end

CSV.open("calendrierVacancesScolairesV2.csv","w",{:col_sep => ";"}) do |csv|
    CSV.foreach('calendrierVacancesScolaires.csv', col_sep: ';'){ |row|
        if row[0] != "Description" then
            if row[2] != nil then
                annee_debut = row[2].split("-")[0]
                mois_debut = row[2].split("-")[1]
                jour_debut =  row[2].split("-")[2]
                debut = jour_debut.to_s + "/" + mois_debut.to_s + "/" + annee_debut.to_s
            else
                debut = nil
            end
            if row[3] != nil then
                annee_fin = row[3].split("-")[0]
                mois_fin = row[3].split("-")[1]
                jour_fin =  row[3].split("-")[2]
                fin = jour_fin.to_s + "/" + mois_fin.to_s + "/" + annee_fin.to_s 
            else
                fin = nil
            end
            
            row[2] = debut
            row[3] = fin
        end

        if goodZone(row[5]) || row[0] == "Description" then
            csv << row
        end
    }
end