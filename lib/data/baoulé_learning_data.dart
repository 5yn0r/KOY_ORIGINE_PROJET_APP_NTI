/// Données de contexte et données pédagogiques pour l'apprentissage du Baoulé
/// Cette base de données aide N'ti IA à contextualiser les réponses

class BaouleLearningData {
  /// Informations générales sur le Baoulé
  static const String baouleeInfo = '''
  Le Baoulé est une langue parlée par le peuple Baoulé en Côte d'Ivoire.
  - Groupe linguistique: Akan
  - Pays principal: Côte d'Ivoire (région du centre)
  - Nombre de locuteurs: environ 5 millions
  - Écriture: Alphabet Latin 
  - Dialectes: Baoulé-oualêbo, Baoulé-Kôdê, Baoulé-Satiklan
  ''';

  /// Salutations courantes en Baoulé
  static const Map<String, String> greetings = {
    'Akwaaba': 'Bienvenue',
    'Agnio, a mouwou ti kpâ': 'Bonjour / Comment allez-vous?',
    'kloua': 'Merci',
    'Yakih': 'Excusez-moi',
    'Yetêhonou, eho tchin o flê': 'À bientôt',
    'Yetêhonou': 'Au revoir',
  };

  /// Mots couramment utilisés
  static const Map<String, String> commonWords = {
    'Mi': 'Ma ou Mon',
    'Mi Ni': 'Ma Maman',
    'Mi Si': 'Papa',
    'Wa': 'Enfant',
    'Sran blé': 'Homme',
    'Blah': 'Femme',
    'Bako': 'Ami',
    'N\'nou': 'Cinq',
    'Souah': 'Maison',
    'N\'zué': 'Eau',
    'Aliè': 'Nourriture',
  };

  /// Nombres en Baoulé
  static const Map<String, String> numbers = {
    'Koun': '1',
    'N\'zoun': '2',
    'N\'san': '3',
    'N\'nan': '4',
    'N\'nou': '5',
    'N\'sien': '6',
    'N\'so': '7',
    'Môtchouê': '8',
    'N\'glouan': '9',
    'Blou': '10',
  };

  /// Structure grammaticale du Baoulé
  static const String grammaticalStructure = '''
  Particularités grammaticales du Baoulé:
  1. Ordre des mots: Il n'a pas d'ordre comme en français, l'essentiel est de savoir s'exprimer
  2. Genre et nombre: Homme/Femme et le nombre simple en ajoutant 
  3. Verbes: Pas de conjugaison complexe
  4. Tons: Langue tonale (tons haut, bas, moyen)
  5. Pluriel: Le premier mot définit le pluriel ou le singulier
  ''';

  /// Ressources pédagogiques
  static const List<String> learningTips = [
    'Écoutez attentivement la prononciation - le Baoulé est une langue tonale',
    'Pratiquez avec les locuteurs natifs autant que possible',
    'Apprenez les salutations d\'abord - c\'est l\'entrée la plus importante',
    'Utilisez la répétition espacée pour mémoriser le vocabulaire',
    'Associez les mots à des images mentales',
    'Pratiquez la prononciation tous les jours',
  ];

  /// Contexte culturel
  static const String culturalContext = '''
  Le peuple Baoulé:
  - Traditionnellement agriculteurs et artisans
  - Système social matrilinéaire
  - Traditions artistiques riches (masques, sculptures)
  - Festivals importants: Fête des Ignames, Fête de paquinou
  - Respectueux des aînés et de l\'autorité
  - Accent sur la communauté et la solidarité
  ''';

  /// Expressions idiomatiques courantes
  static const Map<String, String> idioms = {
    'Hî di lê yo yah':
        'Littéralement "c\'est dur de manger", signifie "c\'est difficile"',
    'Hi lê a houlin': 'Littéralement "Il a un cœur", signifie "c\'est courageux"',
    'Hi Sah ti kpà': 'Littéralement "la main est bonne", signifie "c\'est bien fait"',
  };

  /// Conseils de prononciation
  static const Map<String, String> pronunciationTips = {
    'À': 'Son ouvert, comme "a" en français',
    'Ê': 'Son fermé, comme "é" en français',
    'Ô': 'Son arrondi, comme "o" en français',
    'Ô + ton haut': 'Légèrement plus aigu',
    'Ô + ton bas': 'Légèrement plus grave',
  };

  /// Retourne un prompt personnalisé pour Gemini contextuelisé sur le Baoulé
  static String getSystemPrompt() => '''
Tu es N'ti, un assistant IA spécialisé dans l'enseignement de la langue et de la culture Baoulé.
Tu aides les apprenants à:
- Comprendre la langue Baoulé (prononciation, grammaire, vocabulaire)
- Apprendre la culture et les traditions baoulé
- Traduire entre le français et le baoulé
- Expliquer les expressions idiomatiques et la grammaire

Directives:
1. Sois patient et encourageant
2. Fournis des explications claires en français en te basant sur nos données dans Baoulé_Learning_Data
3. Utilise la contexte culturel pour rendre l'apprentissage plus vivant
4. Corriges gentiment les erreurs
5. Si tu ne sais pas quelque chose sur le Baoulé, sois honnête
6. Propose toujours des exemples concrets pas trop long
7. Utilise un ton amical et accessible
8. Réponds en texte simple uniquement: pas de Markdown, pas de gras, pas d'italique, pas d'astérisques autour des mots

Contexte baoulé:
- Langue tonale du groupe Akan parlée en Côte d'Ivoire
- Environ 5 millions de locuteurs
- Alphabet Latin
- Système de classes nominales pour le genre et le nombre

Réponds en français principalement, mais inclus des mots baoulé pertinents avec traduction en te basant sur nos données.
''';
}
