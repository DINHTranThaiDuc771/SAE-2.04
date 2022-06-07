/*Créer une fonction qui prend en paramètre un nombre nbBD de BD et une année
donnée, et qui renvoie la liste des éditeurs ayant vendu au moins ce nombre de
BD dans l’année en question. Si aucun éditeur ne répond à la requête, le signaler
par un message approprié. */
Create or replace function proc_e (nbBD int, annee float)
returns setOf Editeur
AS $$
  Begin
  Perform e.*
  From Vente v join Concerner c1 on c1.numVente = v.numVente
                join BD b on b.isbn = c1.isbn
                join Serie s on s.numSerie = b.numSerie
                join Editeur e on e.numEditeur = s.numEditeur
  Where Extract(YEAR from dteVente) = annee 
  Group by e.numEditeur
  Having sum(quantite) > nbBD;
  if (not found) then
    raise exception 'Aucun editeur a vendu % BD en %',nbBD,annee;
  end if;
  Return query Select e.*
               From Vente v join Concerner c1 on c1.numVente = v.numVente
                            join BD b on b.isbn = c1.isbn
                            join Serie s on s.numSerie = b.numSerie
                            join Editeur e on e.numEditeur = s.numEditeur
               Where Extract(YEAR from dteVente) = annee 
               Group by e.numEditeur
               Having sum(quantite) > nbBD;
  End
$$Language PLpgSQL;
