require 'csv'
headers = CSV.read("evenements.csv", col_sep: ';', headers: true, encoding: "utf-8").headers << "IndexDate"
evenements_sortie = CSV.open("evenements_sortie.csv", "w", encoding: 'utf-8')
evenements_sortie << headers


CSV.foreach('evenements.csv', col_sep: ';', headers: true, encoding: 'utf-8') { |row|
    p row
}