require 'csv'
clients = CSV.read("produits.csv")
restau = CSV.open("produitsv2.csv","w")


CSV.foreach('produits.csv', col_sep: ';') { |row|
    p row
}