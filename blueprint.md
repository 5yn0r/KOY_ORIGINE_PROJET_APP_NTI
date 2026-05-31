# Blueprint de l'Application d'Apprentissage du Baoulé

## Vue d'ensemble

Cette application a pour but de fournir une plateforme mobile complète, interactive et communautaire pour l'apprentissage de la langue Baoulé. Elle s'adresse à tous les niveaux, des débutants aux plus avancés.

## Style et Design

L'application est développée avec Flutter et suit les principes de Material Design pour une interface utilisateur épurée, intuitive et moderne.

*   **Palette de couleurs :** Le thème principal s'articule autour d'une couleur primaire `deepPurple`, avec des schémas de couleurs adaptés pour les modes clair et sombre.
*   **Typographie :** Utilisation de polices Google Fonts pour une meilleure lisibilité et une identité visuelle forte.
*   **Iconographie :** Icônes Material Design pour une navigation claire et cohérente.

## Fonctionnalités Implémentées

### 1. Authentification Sécurisée
*   **Système complet :** Inscription et connexion via email et mot de passe gérées par **Firebase Authentication**.
*   **Interface claire :** Écrans dédiés pour la connexion et l'inscription avec validation des champs.

### 2. Tableau de Bord Principal (`MainScaffold`)
*   **Navigation centralisée :** Une `BottomNavigationBar` persistante permet d'accéder facilement aux quatre sections principales : Accueil, Modules, Communauté, et Dictionnaire.
*   **AppBar dynamique :** L'AppBar s'adapte au contexte. Elle affiche un message d'accueil personnalisé sur l'écran d'accueil et le titre de la section sur les autres écrans.

### 3. Écran d'Accueil (`HomeScreen`)
*   **Contenu dynamique :** L'écran est alimenté par les données de Firestore pour une expérience personnalisée.
*   **Suivi de la progression :** Une `ProgressCard` affiche les statistiques de l'utilisateur (progression globale, modules complétés).
*   **Activité récente :** Une `RecentActivityCard` liste les dernières leçons consultées par l'utilisateur.
*   **Raccourcis :** Une `ShortcutsCard` offre un accès rapide aux fonctionnalités clés (à développer).

### 4. Modules d'Apprentissage
*   **Structure claire :** Les leçons sont organisées en modules thématiques (Salutations, Famille, etc.).
*   **Navigation fluide :** `ModulesScreen` -> `LessonListScreen` -> `LessonScreen`.
*   **Quiz interactifs :** Chaque leçon peut être associée à un quiz (`QuizScreen`) pour valider les connaissances.
*   **Contenu statique (pour l'instant) :** Les données des cours sont actuellement dans `lib/data/course_data.dart`, prêtes à être migrées vers Firestore.

### 5. Dictionnaire Riche
*   **Recherche et consultation :** Un dictionnaire Baoulé-Français complet avec un écran de liste (`DictionaryScreen`) et un écran de détail.
*   **Mot du Jour :** Une section met en avant un nouveau mot chaque jour pour encourager l'apprentissage continu.
*   **Détails complets :** Chaque mot inclut la prononciation, des exemples de phrases, et un **lien audio** pour écouter la prononciation correcte (hébergé sur Firebase Storage).

### 6. Communauté (Chat et Appels Vidéo)

*   **Messagerie en temps réel :** Une fonctionnalité de chat entièrement fonctionnelle construite sur **Firestore**.
    *   **Liste des utilisateurs :** L'onglet "Communauté" (`UserListScreen`) affiche la liste des autres utilisateurs inscrits, avec leur nom, avatar, et statut de présence (en ligne/hors ligne).
    *   **Conversations privées :** En cliquant sur un utilisateur, on accède à un écran de chat privé (`ChatScreen`).
    *   **Persistance des messages :** Les conversations sont stockées dans Firestore, permettant aux utilisateurs de retrouver leurs historiques de discussion.
*   **Appels vidéo Peer-to-Peer (WebRTC) :**
    *   **Technologie WebRTC :** Utilise `flutter_webrtc` pour établir des connexions vidéo directes entre les utilisateurs, garantissant une faible latence.
    *   **Architecture robuste (Stream-based) :** 
        *   Le `CallService` se charge uniquement de la communication avec Firestore et expose des `Stream` (flux) de données pour les réponses et les candidats ICE.
        *   L'écran `CallScreen` gère son propre état en s'abonnant à ces flux et en s'assurant d'annuler les abonnements dans la méthode `dispose()`. Cette approche évite les fuites de mémoire et résout les problèmes de concurrence ("race conditions").
    *   **Signalisation via Firestore :** Firestore est utilisé comme serveur de signalisation pour échanger les métadonnées de connexion (offres/réponses SDP et candidats ICE).
    *   **Interface d'appel :** Un écran `CallScreen` dédié affiche le flux vidéo local et distant, avec des commandes pour créer ou rejoindre un appel via un ID unique.

## Plan de Développement (Préparation pour GitHub)

**Objectif :** Rendre le projet propre, bien documenté et prêt à être partagé sur GitHub.

**Étapes réalisées :**

1.  **Création du `.gitignore` :** Un fichier `.gitignore` complet a été ajouté pour exclure les fichiers générés par l'IDE, les builds, et les clés de configuration Firebase.
2.  **Mise à jour du `README.md` :** Le fichier a été transformé en une page d'accueil professionnelle pour le projet, avec des instructions d'installation claires.
3.  **Mise à jour du `blueprint.md` :** Ce document a été mis à jour pour refléter l'état actuel et les fonctionnalités réelles de l'application.
