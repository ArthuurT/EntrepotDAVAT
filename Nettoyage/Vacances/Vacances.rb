require 'csv'

headers = CSV.read("data.csv", col_sep: ',', headers: true, encoding: "utf-8").headers
vacances_sortie = CSV.open("vacances_sortie.csv", "w", col_sep: ';', encoding: "utf-8")
vacances_sortie << headers

CSV.foreach('data.csv', col_sep: ',', :headers => true, encoding: "utf-8") { |row|
    anneeVacances = row[0].split("-")[0].to_i
    if anneeVacances > 2016 then
        vacances_sortie << row
    end
}