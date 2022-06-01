--Lister les clients (numéro et nom) qui n’ont acheté que les BD de la série ‘Asterix
--le gaulois’ (en utilisant la clause EXCEPT)
--'Asterix le gaulois'



Select c.numClient,nomClient
From   Client c join Vente v on c.numClient = v.numClient
                join Concerner c1 on c1.numVente = v.numVente 
                join BD b on b.isbn = c1.isbn
                join Serie s on s.numSerie = b.numSerie
Where  nomSerie = 'Asterix le gaulois'

Except 

Select c.numClient,nomClient
From   Client c join Vente v on c.numClient = v.numClient
                join Concerner c1 on c1.numVente = v.numVente 
                join BD b on b.isbn = c1.isbn
                join Serie s on s.numSerie = b.numSerie
Where  nomSerie != 'Asterix le gaulois';
