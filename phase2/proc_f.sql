/*Écrire une procédure qui prend en paramètre une année donnée, et un nom
d’éditeur et qui renvoie le(s) tuple(s) comportant l’année et le nom de l’éditeur
d’une part, associé au nom et email du(des) client(s) d’autre part ayant acheté le
plus de BD cette année-là chez cet éditeur*/
Drop type if exists type_proc_f cascade;
Create type type_proc_f as (annee float, nom_editeur varChar(23), nom_client varchar(11),mail_client text);
                           
Create or Replace function proc_f(annee float, nom_editeur Editeur.nomEditeur%TYPE)
returns setOf type_proc_f
As $$
  Begin
    Drop view if exists vue_proc_f cascade;
    Create view vue_proc_f as
    Select nomEditeur,Extract(YEAR from dtevente) as "year" , nomClient, mailClient, Sum (quantite) as "quantite_achat"
    From   Editeur e join Serie s on s.numEditeur = e.numEditeur
                     join BD    b on b.numSerie   = s.numSerie
                     join Concerner c1 on c1.isbn = b.isbn
                     join Vente v      on v.numVente = c1.numVente
                     join Client c     on c.numClient= v.numClient
    Group by c.numClient,nomEditeur,year
    Order by Extract(YEAR from dteVente);
    
    return query  Select year, nomEditeur, nomClient, mailClient
                  From   vue_proc_f
                  Where  year = annee and nomEditeur = nom_editeur and quantite_achat = (Select max(quantite_achat)
                                                                                         From   vue_proc_f
                                                                                         Where  year = annee and 
                                                                                                nomEditeur = nom_editeur); 
  End
$$ Language PLpgSQL;

--Test
Select * from proc_f(2000,'Dargaud');
