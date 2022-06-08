/*Écrire une fonction SQL utilisant un curseur, qui classe pour un éditeur dont le
nom est donné en entrée, les clients de cet éditeur en trois catégories selon le
nombre de BD qu’ils leur ont achetées (attention on ne comptabilisera pas les
quantités achetées, seulement le nombre de BD distinctes) : les « très bons
clients » (plus de 10 achats strictement), les « bons clients » (entre 2 et 10 BD),
les « mauvais clients » (moins ou égal à 2 BD)*/

Drop type if exists type_proc_g cascade;
Create type type_proc_g as (nom_client varchar(11), type text);

Create or replace function proc_g (nom_editeur_param Editeur.nomEditeur%TYPE)
returns setOf type_proc_g
As $$
Declare
	cli Client;
	curseur CURSOR FOR select * from Client;
	achat bigint;
	tuple type_proc_g;
Begin
	/*Creer une vue qui contient groupé par les editeurs et ses clients*/
	Drop view if exists vue_proc_g cascade;
	Create view vue_proc_g as
	Select nomEditeur, c.numClient, nomClient,Count (DISTINCT c1.isbn) as "quantite_de_isbn_achat"
	From   Editeur e join Serie s on s.numEditeur = e.numEditeur
                     join BD    b on b.numSerie   = s.numSerie
                     join Concerner c1 on c1.isbn = b.isbn
                     join Vente v      on v.numVente = c1.numVente
                     join Client c     on c.numClient= v.numClient
	Group by c.numClient,nomEditeur
	Order by nomEditeur;
    
    Open curseur;
      Loop
	      Fetch curseur into cli;
	      Exit when not found;
	      tuple.nom_client := cli.nomClient;
	      Select quantite_de_isbn_achat into achat 
	      from vue_proc_g 
	      where nomEditeur = nom_editeur_param and numClient = cli.numClient;
	      if not found then
	      	tuple.type := 'Aucun achat de ce client';
	      end if;
	      if achat >10 then 
		tuple.type := 'très bons clients';
	      end if;
	      if achat <=10 and achat > 2 then 
		tuple.type := 'bons clients';
	      end if;
	      if achat<=2 then 
		tuple.type := 'mauvais clients';
	      end if;
	      achat :=0;
	      return next tuple;
      end loop;
   close curseur;
End
$$Language PLpgSQL;

Select * from proc_g('Lombard');
