/* ADMINISTRATEUR */
GRANT   *
ON      DATABASE
TO      administrateur;

GRANT   * 
ON      Serie, BD, Editeur, Auteur, Vente, Client, Concerner 
TO      administrateur 
WITH GRANT OPTION;

/* VENDEUR */
GRANT   SELECT, INSERT 
ON      Vente, Client, Concerner
TO      vendeur;

/* EDITEUR */
GRANT   SELECT, INSERT 
ON      Vente, Client, Concerner, BD, Serie, Auteur
TO      editeur; 
