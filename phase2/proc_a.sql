/* a Ecrire une procédure qui prend en paramètre un numéro d’auteur dessinateur et
qui renvoie pour chaque titre de BD de l’auteur, le nombre d’exemplaires vendus
de cette BD.*/

DROP TYPE typeProcA CASCADE;
CREATE TYPE typeProcA AS(titre text, numLivre bigint);

DROP FUNCTION IF EXISTS proc_a (BD.numAuteurDessinateur%TYPE) CASCADE;
CREATE OR REPLACE FUNCTION proc_a (p_numAuteurDessinateur BD.numAuteurDessinateur%TYPE)
    RETURNS SETOF typeProcA 
    AS $$ 
        DECLARE
        
        BEGIN

            RETURN QUERY
			SELECT titre ,SUM(quantite)
			FROM BD b JOIN Concerner c ON b.isbn = c.isbn
			WHERE numAuteurDessinateur = p_numAuteurDessinateur
			GROUP BY titre;


        END
    $$ LANGUAGE PlpgSQL;

	SELECT * FROM proc_a(30);
