SELECT SUM(prixVente*quantite)
FROM Concerner c JOIN Vente v ON c.numVente = v.numVente
WHERE EXTRACT(YEAR FROM dteVente) = 2021;
