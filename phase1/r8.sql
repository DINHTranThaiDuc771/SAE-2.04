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
