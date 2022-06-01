CREATE OR REPLACE VIEW CA AS
SELECT SUM(prixVente*quantite) AS CA, EXTRACT(YEAR FROM dteVente) AS annee
FROM Concerner c JOIN Vente v ON c.numVente = v.numVente
GROUP BY annee
ORDER BY annee; 


