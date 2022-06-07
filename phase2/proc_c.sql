/*Écrire une procédure qui prend en paramètre un nom d’éditeur et un nom
d’auteur dessinateur et un nom d’auteur scénariste, et qui renvoie la liste des BD
de ces auteurs éditées par l’éditeur choisi. Si l’éditeur n’a pas édité de BD de ces
auteurs, ou qu’il n’existe pas de BD de ces deux auteurs, on devra générer le
message suivant « l’éditeur % n’a pas édité de BD des auteurs % et %» où on
remplacera les « % » par les noms correspondants.*/

DROP FUNCTION if exists prod_c CASCADE;

CREATE or REPLACE FUNCTION prod_c(un_numEditeur Editeur.numEditeur%TYPE, un_numDessinateur Auteur.numAuteur%TYPE, un_numScenariste Auteur.numAuteur%TYPE)
RETURNS SETOF BD
AS $$
    DECLARE 
        une_bd BD%ROWTYPE;
    BEGIN 
        SELECT * INTO une_bd
        FROM BD 
        WHERE isbn IN (Select isbn FROM BD b JOIN Auteur a1
                                        ON b.numAuteurDessinateur = un_numDessinateur
                                        JOIN Auteur a2
                                        ON b.numAuteurScenariste = un_numScenariste
                                        JOIN Serie s 
                                        ON b.numSerie = s.numSerie
                                        JOIN Editeur e 
                                        ON e.numEditeur = un_numEditeur);
        if(une_bd IS NULL) then 
          RAISE EXCEPTION 'L editeur % n a pas édité de BD de ces deux auteurs % et %', numEditeur, numDessinateur, numScenariste;
        else
          return query une_bd;            
    END
$$LANGUAGE PLPGSQL;    

SELECT * FROM prod_c(1,23,23);
