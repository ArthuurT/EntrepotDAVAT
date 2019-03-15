require 'csv'
event = CSV.read("evenements.csv")
#reglement = CSV.open("modeReglementv2.csv","w")


CSV.foreach('evenements.csv', col_sep: ';') { |row|
    p row
}