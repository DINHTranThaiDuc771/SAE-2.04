SELECT		cl.numClient, nomClient, SUM(quantite) AS "nbA"
FROM		Client cl JOIN Vente v ON cl.numClient = v.numClient
			            JOIN Concerner c ON v.numVente = c.numVente
GROUP BY 	cl.numClient
ORDER BY	SUM(quantite) DESC;
