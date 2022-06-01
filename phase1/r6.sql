/*Lister tous les clients (numéro et nom) ayant acheté des BD de la série ‘Astérix
le gaulois’.*/
Select c.numClient,nomClient
From   Client c join Vente v on c.numClient = v.numClient
                join Concerner c1 on c1.numVente = v.numVente 
                join BD b on b.isbn = c1.isbn
                join Serie s on s.numSerie = b.numSerie
Where  nomSerie = 'Asterix le gaulois'
