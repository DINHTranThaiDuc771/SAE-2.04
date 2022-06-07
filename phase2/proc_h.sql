/*Ecrire une procédure qui renvoie pour tous les clients sa plus petite quantitéEcrire une procédure qui renvoie pour tous les clients sa plus petite quantité
achetée (min) et sa plus grande quantité achetée (max) et la somme totale de ses
quantités achetées de BD.
Vous devrez donc créer un type composite ‘clientBD’ comportant quatre
attributs: l'identifiant du client, son nom, sa plus petite quantité achetée, sa plus
grande quantité achetée, et la somme totale de ses quantités achetées. Votre
procédure devra retourner des éléments de ce type de données.
On rajoutera le comportement suivant : si le minimum est égal au maximum pour
un client, on affichera le message 'Egalité du minimum et maximum pour le
client %' en précisant le nom du client.
NB : utiliser une boucle FOR ou un curseur...
achetée (min) et sa plus grande quantité achetée (max) et la somme totale de ses
quantités achetées de BD.
Vous devrez donc créer un type composite ‘clientBD’ comportant quatre
attributs: l'identifiant du client, son nom, sa plus petite quantité achetée, sa plus
grande quantité achetée, et la somme totale de ses quantités achetées. Votre
procédure devra retourner des éléments de ce type de données.
On rajoutera le comportement suivant : si le minimum est égal au maximum pour
un client, on affichera le message 'Egalité du minimum et maximum pour le
client %' en précisant le nom du client.
NB : utiliser une boucle FOR ou un curseur... */

Drop type if exists clientBD cascade;
Create type clientBD as (num int,nom varchar(11),mini int, maxi int, somme int);
Create or replace function proc_h ()
returns setOf clientBD
As $$
  Declare
    tuple clientBD;
    client Client%ROWTYPE;
  Begin
    for client in Select * from Client
    Loop
      tuple.num := client.numClient;
      tuple.nom := client.nomClient;
      Select min(quantite) into tuple.mini 
      From Client c join Vente v on v.numClient = c.numClient
                    join Concerner c1 on c1.numVente = v.numVente
      Where c.numClient = client.numClient;
      
      Select max(quantite) into tuple.maxi 
      From Client c join Vente v on v.numClient = c.numClient
                    join Concerner c1 on c1.numVente = v.numVente
      Where c.numClient = client.numClient;
      
      Select sum(quantite) into tuple.somme
      From Client c join Vente v on v.numClient = c.numClient
                    join Concerner c1 on c1.numVente = v.numVente
      Where c.numClient = client.numClient;
      return next tuple;
    end loop;
    return;
  End
$$Language PLpgSQL;
--Test
Select * from proc_h();
