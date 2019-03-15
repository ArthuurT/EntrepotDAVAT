require 'csv'

vente = CSV.open("PointDeVente.csv","w",{:col_sep => ";"})
entete = ["Index","Libellé"]

vente << entete
vente << ["1","Hotel"]
vente << ["2","Restaurant"]
vente << ["3","Bar"]