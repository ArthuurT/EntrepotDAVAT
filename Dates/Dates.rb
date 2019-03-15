require 'csv'

def jourVacances(zonea,zoneb,zonec)
    return (zonea == "True" || zoneb == "True" || zonec == "True")
end

dates = CSV.open("dates.csv","w")

dates << ["IndexDate","Annee","Mois","Jour","Date","VacancesScolaires"]
index = 0
2017.upto(2018) do |x|
    1.upto(12) do |y|
        1.upto(31) do |z|
            if Date.valid_date?(x,y,z) then
                if y.to_s.length == 1 then month = "0" + y.to_s else month = y.to_s end
                if z.to_s.length == 1 then day = "0" + z.to_s else day = z.to_s end
                complete = day + "/" + month + "/" + x.to_s
                date = Date.new(x,y,z)
                bool = false
                CSV.foreach('../Vacances/data.csv', col_sep: ',') { |row|
                    if row[0] != "date" then
                        jour = row[0].split("-")[2]
                        mois = row[0].split("-")[1]
                        annee = row[0].split("-")[0]
                        if annee.to_i >= 2017 && annee.to_i <= 2018 then
                            date_cmp = Date.new(annee.to_i,mois.to_i,jour.to_i)
                            if (date_cmp <=> date) == 0 && jourVacances(row[1],row[2],row[3]) then
                                bool = true
                                p "ici"
                            end
                        end            
                    end
                }
                dates << [index.to_s, x.to_s, month , day, complete, bool]
                index += 1
            end
        end
    end
end

