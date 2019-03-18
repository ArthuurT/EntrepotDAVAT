require 'csv'
require 'faker'

def updatePrefix(prefix)
    if prefix == "MRS" 
        return "Mme"
    else 
        return "Mr"
    end
end

def getName(prefix)
    if prefix == "Mme" 
        return Faker::Name.female_first_name
    else 
        return Faker::Name.male_first_name
    end
end

def getMail(prenom,nom)
    return nom + "." + prenom + "@gmail.com"
end


def getPhoneNumber()
    prng = Random.new
    phone = ""
    4.times do
        phone = phone + "." + prng.rand(0..9).to_s + prng.rand(0..9).to_s
    end
    return "06" + phone
end

def getPostalCode()
    prng = Random.new
    return prng.rand(10000..95000).to_s
end

headers = CSV.read("clients.csv", col_sep: ';', headers: true, encoding: "utf-8").headers << "CodePostal"
clients_sortie = CSV.open("clients_sortie.csv", "w", col_sep: ';', encoding: 'utf-8')
clients_sortie << headers

CSV.foreach('clients.csv', col_sep: ';', headers: true, encoding: 'utf-8') { |row|
    row["Titre"] = updatePrefix(row["Titre"])
    row["NomClient"] = Faker::Name.middle_name
    row["Prenom"] = getName(row["Titre"])
    row["Adresse"] = Faker::Address.street_address
    row["Telephone"] = getPhoneNumber()
    row["CodePostal"] = getPostalCode()
    row["AdrInternet"] = getMail(row["Prenom"],row["NomClient"])
    clients_sortie << row
}