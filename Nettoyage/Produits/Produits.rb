require 'csv'


headers = CSV.read("produits.csv", col_sep: ';', headers: true, encoding: "utf-8").headers << "pointDeVente"
produits_sortie = CSV.open("produits_sortie.csv", "w", col_sep: ';', encoding: "utf-8")
produits_sortie << headers


def getPointDeVente(value)
    if value == "FORFAIT" || value == "REST" then return "RESTAURANT"
    elsif value == "BARA" || value == "BARS" then return "BAR"
    else return "HOTEL" end
end

CSV.foreach('produits.csv', col_sep: ';', :headers => true, encoding: "utf-8") { |row|
    produits_sortie << (row << getPointDeVente(row["CodeStatistique"]))
}