create or replace view vueBdEd10 as
select nomEditeur, mailEditeur, COUNT(isbn) as "nombre BD"
from Editeur e join Serie s on e.numEditeur = s.numEditeur
               join bd    b on s.numSerie   = b.numSerie
Group by e.numEditeur
Having count(isbn) >=10
Order by e.numEditeur;
