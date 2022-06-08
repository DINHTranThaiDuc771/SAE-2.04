/*Ecrire une fonction qui supprime une vente dont l'identifiant est passé en
paramètre.
Vérifier d'abord que la vente associée à l'identifiant existe, si elle n'existe pas
afficher un message d'erreur le mentionnant; si elle existe on la supprime.
Cette suppression va générer une violation de clé étrangère dans la table
‘Concerner’.
Pour gérer cela, on utilisera le code d'erreur FOREIGN_KEY_VIOLATION
dans un bloc EXCEPTION dans lequel on supprimera tous les tuples de la table
‘Concerner’ qui possèdent ce numéro de vente, avant de supprimer la venet ellemême. On pourra au passage afficher aussi un message d'avertissement sur cette
exception*/
Create or replace function proc_i (num_vente_param Vente.numVente%TYPE)
returns void
As $$
  Begin
    Perform * from Vente Where numVente = num_vente_param;
    if not found then
      raise exception 'Ce numero de vente n''existe pas';
    end if;
    Delete from Vente
    Where numVente = num_vente_param;
  Exception
    When FOREIGN_KEY_VIOLATION then
      Delete from Concerner
      Where numVente = num_vente_param;
    RAISE NOTICE 'Vente supprimée !';
  End
$$Language PLpgSQL;
--Test 
Select * from proc_i(1);
