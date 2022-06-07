/*Créer une fonction stockée qui prend en paramètre le nom d’une série de BD et
qui renvoie les clients ayants acheté tous les albums de la série (utiliser des
boucles FOR et/ou des curseurs).
Si aucun client ne répond à la requête alors on affichera un message
d’avertissement ‘Aucun client n’a acheté tous les exemplaires de la série %’, en
complétant le ‘ %’ par le nom de la série.*/
Create or replace function proc_d (nom_serie_param Serie.nomSerie%TYPE)
returns setOf Client
As $$
  Declare
    ncli Client.numClient%TYPE;
    clientRet Client%ROWTYPE;
    compareTable int;
    num_isbn BD.isbn%TYPE;
  Begin
    for ncli in Select numClient from Client
    loop
      compareTable := 0 ;
      for num_isbn in (Select isbn
                      From  BD b join Serie s on s.numSerie = b.numSerie
                      Where nomSerie = nom_serie_param
                      Except
                      Select isbn
                      From Vente v join Concerner c1 on c1.numVente = v.numVente
                      Where numClient=ncli)
      loop
        compareTable := compareTable +1;
      end loop;
      if compareTable = 0 then
        Select * into clientRet from Client Where numClient = ncli;
      else
        clientRet := null;
      end if;
      
      if clientRet is not null then
        return next clientRet;
      end if;
    end loop;
    return;
  End
$$ Language PLpgSQL;  
