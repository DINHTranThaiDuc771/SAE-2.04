/*Construire et afficher une vue bdEditeur qui affiche le nombre de BD vendues
par an et par éditeur, par ordre croissant des années et des noms d’éditeurs. On y
affichera le nom de l’éditeur, l’année considérée et le nombre de BD publiées.*/

create or replace view vueBdEditeur 
as 
select c.quantite,  v.dteVente, e.nomEditeur from Concerner c JOIN BD b
                                             ON c.isbn = b.isbn 
                                             JOIN Serie s 
                                             ON b.numSerie = s.numSerie 
                                             JOIN Editeur e 
                                             ON s.numEditeur = e.numEditeur
                                             JOIN Vente v 
                                             ON c.numVente = v.numV ente
                                             order by dteVente, nomEditeur;

select * from vuebdEditeur;  
