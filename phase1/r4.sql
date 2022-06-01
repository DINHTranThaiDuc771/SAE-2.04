/* Afficher le chiffre d’affaire des ventes effectuées en 2021 (on pourra utiliser la
fonction extract pour récupérer l’année seule d’une date) */


SELECT SUM(prixVente*quantite)
FROM Concerner c JOIN Vente v ON c.numVente = v.numVente
WHERE EXTRACT(YEAR FROM dteVente) = 2021;
