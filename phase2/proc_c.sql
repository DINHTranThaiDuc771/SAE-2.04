/*Écrire une procédure qui prend en paramètre un nom d’éditeur et un nom
d’auteur dessinateur et un nom d’auteur scénariste, et qui renvoie la liste des BD
de ces auteurs éditées par l’éditeur choisi. Si l’éditeur n’a pas édité de BD de ces
auteurs, ou qu’il n’existe pas de BD de ces deux auteurs, on devra générer le
message suivant « l’éditeur % n’a pas édité de BD des auteurs % et %» où on
remplacera les « % » par les noms correspondants.*/

DROP FUNCTION if exists proc_c CASCADE;

CREATE or REPLACE FUNCTION proc_c(un_nomEditeur Editeur.nomEditeur%TYPE, un_nomDessinateur Auteur.nomAuteur%TYPE, un_nomScenariste Auteur.nomAuteur%TYPE)
RETURNS SETOF BD
AS $$
    BEGIN 
        PERFORM *
        FROM BD 
        WHERE isbn IN (Select isbn FROM BD b JOIN Auteur a1
                                        ON a1.numAuteur = b.numAuteurScenariste
                                        JOIN Auteur a2
                                        ON b.numAuteurDessinateur = a2.numAuteur
                                        JOIN Serie s 
                                        ON b.numSerie = s.numSerie
                                        JOIN Editeur e 
                                        ON e.numEditeur = s.numEditeur
                         WHERE a1.nomAuteur = un_nomScenariste AND a2.nomAuteur = un_nomDessinateur AND e.nomEditeur = un_nomEditeur);
        if(NOT FOUND) then 
          RAISE EXCEPTION 'L editeur % n a pas édité de BD de ces deux auteurs % et %', numEditeur, numDessinateur, numScenariste;
        else
          return query Select *
                       FROM BD 
                       WHERE isbn IN (Select isbn FROM BD b JOIN Auteur a1
                                                       ON a1.numAuteur = b.numAuteurScenariste
                                                       JOIN Auteur a2
                                                       ON b.numAuteurDessinateur = a2.numAuteur
                                                       JOIN Serie s 
                                                       ON b.numSerie = s.numSerie
                                                       JOIN Editeur e 
                                                       ON e.numEditeur = s.numEditeur
                                       WHERE a1.nomAuteur = un_nomScenariste AND a2.nomAuteur = un_nomDessinateur AND e.nomEditeur = un_nomEditeur);
        end if;           
    END
$$LANGUAGE PLPGSQL; 
