/*Écrire une fonction qui prend en paramètre le nom d’une série de BD et qui
renvoie pour chaque titre de la série le nombre d’exemplaires vendus et le chiffre
d’affaire réalisé par titre.*/

DROP TYPE if exists type_b CASCADE;

CREATE TYPE type_b AS (nbExemplaire bigint, chiffreAffaire float);


DROP FUNCTION if exists proc_b CASCADE;

CREATE or REPLACE FUNCTION proc_b (nom_serie Serie.nomSerie%TYPE) RETURNS 
SETOF type_b
AS $$
    BEGIN 
        RETURN QUERY select count(b.*), prixActuel*count(b.*)
        FROM BD b JOIN Serie s ON b.numSerie = s.numSerie
        WHERE s.nomSerie = nom_serie
        GROUP BY prixActuel;
    END
$$LANGUAGE PLPGSQL;

SELECT * from proc_b('L Adoption');
