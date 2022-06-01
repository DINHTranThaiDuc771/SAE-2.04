/*Créer et afficher une vue nommée best5 qui liste les 5 meilleurs clients (ayant
donc dépensé le plus d’argent en BD) en affichant leur numéro, nom et adresse
mail, ainsi que le nombre total de BD qu’ils ont acheté (champ nbBD en tenant
compte des quantités achetées), ainsi que le total de leurs achats (champ coutA).*/
CREATE OR REPLACE view best5 AS  
Select c.numClient, nomClient, mailClient, Sum(quantite) as "quantiteBD", Sum(prixVente) as "coutA" 
From   Client c join Vente v on v.numClient = c.numClient
                join Concerner c1 on c1.numVente = v.numVente
Group by c.numClient
Order by Sum(prixVente) DESC
Limit 5;
