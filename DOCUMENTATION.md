# Documentation de l'application MYAPP

## Objectif du projet

MYAPP est une application pédagogique visant à faciliter l'apprentissage de la langue baoulé. Elle s'adresse aux débutants et aux apprenants qui souhaitent progresser à travers des leçons structurées, des outils d'entraînement, un dictionnaire bilingue et une expérience communautaire.

## Utilisateurs cibles

- Étudiants d'une école ou d'une université.
- Personnes souhaitant découvrir le baoulé.
- Enseignants cherchant un support pédagogique interactif.
- Communautés désireuses d'apprendre en groupe.

## Fonctionnalités détaillées

### 1. Authentification et onboarding
- Inscription utilisateur avec email et mot de passe.
- Connexion sécurisée via Firebase Auth.
- Page d’onboarding pour orienter les nouveaux utilisateurs.

### 2. Dashboard principal
- Espace central de navigation.
- Onglets pour : Accueil, Modules, Dictionnaire, Chatbot et Peers.
- Accès rapide au profil et aux événements.

### 3. Modules d'apprentissage
- Leçons organisées par thème.
- Suivi du progrès utilisateur.
- Score et avancement sauvegardés.

### 4. Dictionnaire
- Recherche de mots et expressions en baoulé et français.
- Affichage des définitions et des exemples.

### 5. Chatbot IA « N'ti »
- Assistant conversationnel intégré.
- Utilise Gemini via `google_generative_ai` et `firebase_ai`.
- Conçu pour expliquer le vocabulaire, la grammaire et fournir du support.

### 6. Peer-to-peer et communication
- Appels vidéo pour permettre des échanges en temps réel.
- Gestion des appels entrants et sortants.
- Présence en ligne sauvegardée dans Firestore.

### 7. Profil utilisateur
- Affichage du nom, du niveau et du statut.
- Accès aux informations personnelles.

## Architecture du code

### Points d'entrée
- `lib/main.dart` : initialisation de Firebase et configuration du routeur.

### State management
- `provider` est utilisé pour gérer l’état global.
- `AuthProvider` gère l’authentification et la présence en ligne.
- `ChatbotProvider` gère la conversation IA.

### Navigation
- `go_router` donne la navigation déclarative entre les écrans.
- Routes principales : `/`, `/onboarding`, `/login`, `/signup`.

### Services principaux
- `lib/services/auth_service.dart` : connexion et inscription Firebase.
- `lib/services/gemini_service.dart` : intégration de l’IA.
- `lib/services/call_service.dart` : appels vidéo WebRTC.
- `lib/services/dictionary_service.dart` : accès au dictionnaire.
- `lib/services/lesson_service.dart` : gestion des leçons.
- `lib/services/event_service.dart` : gestion des événements culturels.
- `lib/services/user_progress_service.dart` : suivi du progrès.

## Base de données et modèle de données

### Firestore
Le projet utilise Firestore pour stocker :

- `users` : données utilisateurs, niveau, présence, score.
- `chatbot_conversations` : historique des conversations IA.
- `messages` : messages de chat et réponses du bot.
- `lessons` / `modules` : contenu pédagogique et structure des cours.
- `events` : événements culturels ou pédagogiques.

### Structures de données
- `lib/models/` contient les objets métiers utilisés par l’application.
- `ChatbotMessage` représente un message de la conversation IA.
- `EventModel`, `LessonModel`, etc. décrivent les éléments consultés dans l’interface.

## Flux utilisateur

1. L’utilisateur installe l’application.
2. Il passe par l’onboarding.
3. Il crée un compte ou se connecte.
4. Il arrive sur le dashboard central.
5. Il navigue entre les modules pédagogiques, le dictionnaire, le chatbot et la communauté.
6. Ses actions sont sauvegardées dans Firebase.

## Configuration Firebase

### Fichiers à générer localement
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

Ces fichiers sont exclus du dépôt via `.gitignore`.

### Bonnes pratiques
- Ne jamais committer les fichiers de configuration Firebase.
- Vérifier que le projet Firebase contient bien les règles de lecture/écriture nécessaires pour l’application.

## Déploiement et tests

### Exécution en développement
```sh
flutter pub get
flutter run
```

### Build Android
```sh
flutter build apk --release
```

### Build Web
```sh
flutter build web
```

## Liste des fichiers à ne pas committer

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `local.properties`
- `.env`
- `build/`
- `.dart_tool/`
- `.idea/`
- `.vscode/`
- `*.keystore`
- `*.log`

## Conseils pour l’administration

- Utiliser la branche `main` ou `master` pour la version stable.
- Conserver `pubspec.lock` pour assurer des builds reproductibles.
- Ajouter des captures d’écran dans le README si besoin.
- Expliquer dans le dépôt que les fichiers Firebase sont spécifiques à l’environnement local.

## Notes de mise en ligne

Ce projet est prêt à être publié sur GitHub une fois que :

- `google-services.json` est bien absent du dépôt,
- la structure du code est clarifiée dans le README,
- la documentation `DOCUMENTATION.md` est ajoutée pour les examinateurs.

---

Merci de consulter ce document pour comprendre rapidement l’architecture et le fonctionnement de MYAPP.
