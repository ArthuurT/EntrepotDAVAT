require 'csv'

dates = CSV.open("dates_sortie.csv", "w", col_sep: ';', encoding: 'utf-8')

dates << ["IndexDate", "Annee", "Mois", "Jour", "Date", "VacancesScolaires"]
index = 0

def estJourVacances(zonea,zoneb,zonec)
    return (zonea == "True" || zoneb == "True" || zonec == "True")
end

2017.upto(2018) do |annee|
    1.upto(12) do |mois|
        1.upto(31) do |jour|
            if Date.valid_date?(annee, mois, jour) then
                if mois.to_s.length == 1 then month = "0" + mois.to_s else month = mois.to_s end
                if jour.to_s.length == 1 then day = "0" + jour.to_s else day = jour.to_s end
                complete = annee.to_s + "-" + month + "-" + day 
                date = Date.new(annee, mois, jour)
                bool = false
                CSV.foreach('../Vacances/data.csv', col_sep: ',', headers: true) { |row|
                    if row[0] != "date" then
                        jourVacances = row[0].split("-")[2]
                        moisVacances = row[0].split("-")[1]
                        anneeVacances = row[0].split("-")[0]
                        if anneeVacances.to_i >= 2017 && anneeVacances.to_i <= 2018 then
                            date_cmp = Date.new(anneeVacances.to_i, moisVacances.to_i, jourVacances.to_i)
                            if (date_cmp <=> date) == 0 && estJourVacances(row["vacances_zone_a"], row["vacances_zone_b"], row["vacances_zone_c"]) then
                                bool = true
                                break
                            end
                        end            
                    end
                }
                dates << [index.to_s, annee.to_s, month , day, complete, bool]
                index += 1
            end
        end
    end
end

