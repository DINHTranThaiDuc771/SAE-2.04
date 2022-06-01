SELECT		cl.numClient, nomClient, SUM(prixVente*quantite) AS "coutA"
FROM		Client cl JOIN Vente v ON cl.numClient = v.numClient
		  	  JOIN Concerner c ON v.numVente = c.numVente
GROUP BY	cl.numClient
HAVING 		SUM(prixVente*quantite) >= 50000
ORDER BY	SUM(prixVente*quantite) DESC;
