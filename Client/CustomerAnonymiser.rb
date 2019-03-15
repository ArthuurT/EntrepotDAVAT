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

clients = CSV.read("clients.csv")
newfile = CSV.open("clientsv2.csv","w")
headers = clients[0][0].split(";")
newfile << headers

CSV.foreach('clients.csv', col_sep: ';') { |row|
    if(row[0] != "IndexClient")
        row[6] = updatePrefix(row[6])
        row[1] = Faker::Name.middle_name
        row[2] = getName(row[6])
        row[3] = Faker::Address.street_address
        row[4] = getPhoneNumber()
        row[5] = getPostalCode()
        row[10] = getMail(row[2],row[1])
        newfile << row
    end
}