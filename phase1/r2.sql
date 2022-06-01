/* Lister les clients (numéro, nom) et leur nombre d’achats (que l’on nommera
nbA) triés par ordre décroissant de leur nombre d’achats (sans prendre en compte
la quantité achetée) */

SELECT		cl.numClient, nomClient, SUM(quantite) AS "nbA"
FROM		Client cl JOIN Vente v ON cl.numClient = v.numClient
			            JOIN Concerner c ON v.numVente = c.numVente
GROUP BY 	cl.numClient
ORDER BY	SUM(quantite) DESC;
