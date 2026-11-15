# Réponses - TP3 : Du Servlet au MVC

## Q1. Quelle est la différence entre forward et redirect ?
- `forward` : transfère la requête vers une autre ressource côté serveur.
- `redirect` : demande au navigateur d'effectuer une nouvelle requête.

## Q2. Pourquoi utiliser le pattern PRG ?
Pour éviter de renvoyer le formulaire lorsqu'on actualise la page après une soumission.

## Q3. Pourquoi utiliser c:out ?
Pour afficher les données de manière sécurisée et éviter les attaques XSS.

## Q4. Quel est le rôle d'un filtre ?
Un filtre permet d'intercepter les requêtes avant qu'elles arrivent aux servlets, par exemple pour vérifier l'authentification.