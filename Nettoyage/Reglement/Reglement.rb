require 'csv'
clients = CSV.read("modesReglement.csv")
reglement = CSV.open("modeReglement_sortie.csv","w")


CSV.foreach('modesReglement.csv', col_sep: ';') { |row|
    p row
}