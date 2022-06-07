/*On souhaite classer tous les clients par leur quantité totale d'achats de BD. Ainsi
on veut associer à chaque client son rang de classement en tant qu'acheteur dans
l'ordre décroissant des quantités achetées. Ainsi le client de rang 1 (classé
premier) aura totalisé le plus grand nombre d'achats.
Vous devez donc créer un nouveau type de données ‘rangClient’, qui associe
l'identifiant du client, son nom et son classement dans les acheteurs (attribut
nommé ‘rang’).
Ecrire une fonction qui renvoie pour tous les clients, son identifiant, son nom et
son classement d'acheteur décrit ci-dessus.
NB : on pourra avantageusement utiliser une boucle FOR ou un curseur... */

Drop type if exists rangClient cascade;
Create type rangClient as (numClient int, nomClient varchar(11), rang int);

Create or replace function proc_j()
returns setOf rangClient
As $$
  Declare
    tuple rangClient;
    rang bigint;
    num_client Client.numClient%TYPE;
  Begin
    Drop view if exists vue_proc_j cascade;
    Create view vue_proc_j as
    Select c.numClient as "num_Client"
    From   Client c join Vente v on v.numClient = c.numClient
                    join Concerner c1 on c1.numVente = v.numVente
    Group by c.numClient
    Order by sum(Quantite);
    rang := 1;
    for num_Client in Select * from vue_proc_j
    loop
      tuple.numClient := num_Client;
      tuple.rang := rang; 
      Select nomClient into tuple.nomClient from Client where numClient = num_client;
      rang := rang +1;
      return next tuple;
    end loop;
    return;
  End
$$Language PLpgSQL;
--Test
Select * from proc_j();

