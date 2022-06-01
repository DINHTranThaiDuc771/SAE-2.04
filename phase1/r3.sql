/*Lister les clients (numéro, nom) avec leur coût total d’achats (que l’on nommera
coutA) triés par leur coût décroissant, qui ont totalisé au moins 50000€
d’achats...*/
SELECT		cl.numClient, nomClient, SUM(prixVente*quantite) AS "coutA"
FROM		Client cl JOIN Vente v ON cl.numClient = v.numClient
		  	  JOIN Concerner c ON v.numVente = c.numVente
GROUP BY	cl.numClient
HAVING 		SUM(prixVente*quantite) >= 50000
ORDER BY	SUM(prixVente*quantite) DESC;
