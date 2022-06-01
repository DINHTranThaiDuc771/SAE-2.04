/*Construire et afficher une vue bdEditeur qui affiche le nombre de BD vendues
par an et par éditeur, par ordre croissant des années et des noms d’éditeurs. On y
affichera le nom de l’éditeur, l’année considérée et le nombre de BD publiées.*/

Create or replace view vueBdEditeur
as
Select nomEditeur as "Nom éditeur", EXTRACT(Year From dteVente) as "Année de vente", count(quantite) as "Nombre de BD vendues"
From  Editeur e join Serie s on s.numEditeur = e.numEditeur
                join BD b on b.numSerie = s.numSerie
                join Concerner c1 on c1.isbn = b.isbn
                join Vente v on c1.numVente = v.numVente
Group by EXTRACT(Year from v.dteVente), nomEditeur
Order by EXTRACT(Year from v.dteVente), nomEditeur;
