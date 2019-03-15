require 'csv'
clients = CSV.read("modesReglement.csv")
reglement = CSV.open("modeReglementv2.csv","w")


CSV.foreach('modesReglement.csv', col_sep: ';') { |row|
    p row
}