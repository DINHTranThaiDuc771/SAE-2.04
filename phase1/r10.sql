/*Construire et afficher une vue bdEd10 qui affiche les éditeurs qui ont publié plus
de 10 BD, en donnant leur nom et email, ainsi que le nombre de BD différentes
qu’ils ont publiées.*/

create or replace view vueBdEd10 as
select nomEditeur, mailEditeur, COUNT(isbn) as "nombre BD"
from Editeur e join Serie s on e.numEditeur = s.numEditeur
               join bd    b on s.numSerie   = b.numSerie
Group by e.numEditeur
Having count(isbn) >=10
Order by e.numEditeur;
