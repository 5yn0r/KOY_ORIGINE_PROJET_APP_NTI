import 'package:myapp/models/lesson_model.dart';
import 'package:myapp/models/quiz_question.dart';

final Map<String, List<Lesson>> allLessons = {
  'm01_phonetique': [
    Lesson(
      id: 'm01_l1',
      moduleId: 'm01_phonetique',
      title: 'Phonétique et prononciation',
      type: 'reading',
      content: '''
Dans ce module, vous découvrez les sons et les tons du baoulé.

- Les tons peuvent changer le sens des mots : haut, bas, moyen.
- Les voyelles nasales se prononcent avec un air qui passe par le nez.
- Essayez de répéter : "Agnio"/ (bonjour), "Kloua"/ (merci).

Le baoulé utilise des précisions claires et de petites variations de ton. Entraînez-vous en écoutant les locuteurs et en répétant lentement chaque mot.
''',
      order: 1,
      audioUrl:
          'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M1_L1.m4a',
    ),
    Lesson(
      id: 'm01_l2',
      moduleId: 'm01_phonetique',
      title: 'Les tons en détail',
      type: 'reading',
      content: '''
Approfondissons les tons du baoulé, essentiels pour la compréhension.

- Ton haut (`) : accent grave, comme dans "tè" (mal)
- Ton bas (') : accent aigu, comme dans "bé" (il/ils)
- Ton moyen : pas d'accent, ton neutre

Exemples :
- "bla" (vient) vs "blà" (marigot)
- "wun" (mari avec élévation de ton) vs "wun" (corps avec stabilisation du ton)

Pratiquez en répétant ces paires de mots pour sentir la différence.
''',
      order: 2,
      audioUrl:
          'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M1_L2.m4a',
    ),
    Lesson(
      id: 'm01_l3',
      moduleId: 'm01_phonetique',
      title: 'Exercices de prononciation',
      type: 'reading',
      content: '''
Mettez en pratique ce que vous avez appris avec ces exercices.

Exercice 1 : Répétez après l'audio :
- Bonjour : Agni / agniho
- Merci : kloua / klouaho
- Au revoir : Akwaba / Ye tè oh nou

Exercice 2 : Identifiez les tons :
- Écoutez et dites si le ton est haut, bas ou moyen.

Exercice 3 : Prononcez ces mots :
- Père : Baba / "Si" (baba avec ton moyen et Si avec ton haut)
- Mère : Mamy / "Ni" (mamy avec ton bas et Ni avec ton haut)
- Eau : N'zue
- Soleil : vià ( le ton selon votre appréciation)

Continuez à pratiquer régulièrement pour maîtriser la prononciation.
''',
      order: 3,
      audioUrl:
          'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M1_L3.m4a',
    ),
    Lesson(
      id: 'm01_q1',
      moduleId: 'm01_phonetique',
      title: 'Quiz intermédiaire : Tons et sons',
      type: 'quiz',
      content: 'Vérifiez vos progrès sur les tons et la prononciation.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel ton est utilisé pour "père" en baoulé "baba" ?',
          options: ['Ton haut', 'Ton bas', 'Pas de ton', 'Ton moyen'],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question: 'Comment prononcer "Agniho" ?',
          options: [
            'Avec ton bas',
            'Avec ton haut',
            'Sans change de ton',
            'Avec accent grave',
          ],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'Quelle différence entre "blà" et "bla" ?',
          options: ['Le ton', 'La voyelle', 'La consonne', 'Rien'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm01_q2',
      moduleId: 'm01_phonetique',
      title: 'Quiz final : Phonétique complète',
      type: 'quiz',
      content: 'Testez votre compréhension des sons et des tons baoulé.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel mot baoulé signifie "bonjour" ?',
          options: ['Baba', 'Agniho', 'Kloua', 'Ani'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Quelle caractéristique est importante en baoulé ?',
          options: [
            'La ponctuation',
            'La précision',
            'L\'orthographe',
            'Les tons',
          ],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question: 'Comment se prononce "tê" ?',
          options: ['Comme "tè"', 'Comme "ta"', 'Comme "ti"', 'Comme "té"'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm02_salutations': [
    Lesson(
      id: 'm02_l1',
      moduleId: 'm02_salutations',
      title: 'Salutations et politesse',
      type: 'reading',
      content: '''
Apprenez les formules de salutation en baoulé, c'est une marque très importante pour montrer du respect.

- Bonjour : Agni / Agniho
- Bonsoir : Ahoussi / Ahoussiho
- Nuit : Kôgouè
- Bonne nuit : Ahoussiho
- Comment ça va ? : Wô wun ti kpà
- Réponse : Mi wun ti kpa (Ça va bien ou je vais bien)

La politesse importe beaucoup dans la culture baoulé : on utilise des formules différentes selon l'âge et le statut social.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M2_L1.m4a',
    ),
    Lesson(
      id: 'm02_l2',
      moduleId: 'm02_salutations',
      title: 'Formules de respect',
      type: 'reading',
      content: '''
Découvrez les nuances de politesse selon les interlocuteurs. La formule de salutation change selon que vous parlez à un aîné, une femme ou un homme.

- Avec les aînés : "Mi yrou kpin Agniho" (Bonjour aîné avec respect)
- Avec les enfants : "Mi sima Agniho" (Bonjour enfant ou petit/petite frère/soeur avec respect)
- Avec les femmes : "Moh Agniho" (Bonjour madame avec respect)
- Avec les hommes : "N'djà Agniho" (Bonjour monsieur/aîné avec respect)
- Remerciements : "Kloua / Mo kloua / N'djà Kloua" (Merci beaucoup)

La hiérarchie sociale influence les formules utilisées. Observez et imitez les locuteurs natifs.
''',
      order: 2,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M2_L2.m4a',
    ),
    Lesson(
      id: 'm02_l3',
      moduleId: 'm02_salutations',
      title: 'Dialogues quotidiens',
      type: 'reading',
      content: '''
Pratiquez ces dialogues simples pour vous familiariser.

Dialogue 1 :
A: Agniho ! (Bonjour !)
B: Agniho ! wô wun ti kpà ? (Bonjour ! Comment ça va ?)
A: Mi wun ti kpa, klouaho. (Ça va, merci.)
A: Yè Habô ni (Et toi ?)
B: Mi wun ti kpa, klouaho. (Ça va, merci.)

Dialogue 2 :
A: Ahoussiho ! (Bonne nuit !)
B: Ahoussiho ! (Bonne nuit !)

Répétez ces échanges pour gagner en assurance.
''',
      order: 3,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M2_L3.m4a',
    ),
    Lesson(
      id: 'm02_q1',
      moduleId: 'm02_salutations',
      title: 'Quiz intermédiaire : Politesses',
      type: 'quiz',
      content: 'Testez vos connaissances sur les formules de respect.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle formule utiliser avec un aîné ?',
          options: ['Agné', 'Agniho', 'Agni', 'Wo wun ti kpà'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Que signifie "Mi wun ti kpa" ?',
          options: ['Bonjour', 'Ça va pas', 'Merci', 'Je vais bien'],
          correctAnswerIndex: 3,
        ),
      ],
    ),
    Lesson(
      id: 'm02_q2',
      moduleId: 'm02_salutations',
      title: 'Quiz final : Salutations complètes',
      type: 'quiz',
      content:
          'Vérifiez que vous maîtrisez les mots de base pour saluer et remercier.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Comment dit-on "merci" en baoulé ?',
          options: ['Kloua', 'Agnam', 'Mi wun ti kpa', 'Wo wun ti kpà'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Quelle phrase signifie "comment ça va ?" ?',
          options: ['Mi wun ti kpa', 'Soukpô', 'Wô wun ti kpà ', 'Vià'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'Quelle est la réponse polie à "Wô wun ti kpà" ?',
          options: ['Bohi', 'Mi wun ti kpa, agnam', 'Agni kô', 'Sô sah'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
  ],

  'm03_nombres': [
    Lesson(
      id: 'm03_l1',
      moduleId: 'm03_nombres',
      title: 'Nombres et quantités',
      type: 'reading',
      content: '''
Comptez en baoulé de 0 à 40.
- 0 : Mli mli                      - 21 : Ablahun ni kun
- 1 : Kun                          - 22 : Ablahun ni n'gnon
- 2 : N'gnon                        - 23 : Ablahun ni n'san
- 3 : N'san                        - 24 : Ablahun ni n'nan
- 4 : N'nan                        - 25 : Ablahun  ni n'nou
- 5 : N'nou                        - 26 : Ablahun ni n'sien
- 6 : N'sien                       - 27 : Ablahun ni n'so
- 7 : N'so                         - 28 : Ablahun ni môtchouê
- 8 : Môtchouê                     - 29 : Ablahun ni n'glouhan
- 9 : N'glouhan                    - 30 : Ablassan 
- 10 : Blou                        - 31 : Ablassan ni kun
- 11 : Blou ni kun                 - 32 : Ablassan ni n'gnon
- 12 : Blou ni n'gnon              - 33 : Ablassan ni n'san
- 13 : Blou ni n'san               - 34 : Ablassan ni n'nan
- 14 : Blou ni n'nan               - 35 : Ablassan ni n'nou
- 15 : Blou ni  n'nou              - 36 : Ablassan ni n'sien
- 16 : Blou ni n'sien              - 37 : Ablassan ni n'so
- 17 : Blou ni n'so                - 38 : Ablassan ni môtchouê
- 18 : Blou ni môtchouê            - 39 : Ablassan ni n'glouhan
- 19 : Blou ni n'glouhan           - 40 : AblaNan
- 20 : Ablahun                   

Utilisez ces nombres dans les marchés et les achats : "Man mi domi N'SAN" signifie "Donne moi (3) TROIS oranges".
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M3_L1.m4a',
    ),
    Lesson(
      id: 'm03_l2',
      moduleId: 'm03_nombres',
      title: 'Dizaines et centaines',
      type: 'reading',
      content: '''
Continuez avec les nombres plus grands.

- 50 : AbléNou
- 55 : Ablénou ni n'nou
- 60 : Ablésien 
- 69 : Ablésien ni n'glouhan
- 90 : Abléglouhan
- 100: Yakun
- 101 : Yakun ni kun
- 1000 : Akpi
- 1001 : Akpi ni kun

En Baoulé, de 20 à 40 l'initial des nombres est "Abla..." et de 50 à 90 est "Ablé..."

Exemples :
- 15 : Blou ni n'nou (10 + 5)
- 78 : Ablésso ni môtchouê   (70 + 8)
Règle 1: Le plus grand nombre (70) + le plus petit
Règle 2: Le plus(+) signifie en baoulé "Ni" ou "Ê ni"

''',
      order: 2,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M3_L2.m4a',
    ),
    Lesson(
      id: 'm03_l3',
      moduleId: 'm03_nombres',
      title: 'Utilisation pratique',
      type: 'reading',
      content: '''
Voyez comment utiliser les nombres au quotidien.

Au marché :
- "Blou ni kun" : Onze (10 + 1 = 11)
- "Kun gbâ" : Un(1)
- "Kotokun / Pônou" : Pour exprimer une somme d'argent en FCFA en général
- "Kotokun san" : Trois mille (3000) Francs

Dans les prix :
- "Pô Nan" : Cent francs(100 Fcfa)
- "Pônou Môtchouê" : Deux cents francs(200 Fcfa)
- "Pônou Ablahun" : Cinq cents francs(500 Fcfa)


Pratiquez en comptant des objets autour de vous et échanger avec des commerçants.
''',
      order: 3,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M3_L3.m4a',
    ),
    Lesson(
      id: 'm03_q1',
      moduleId: 'm03_nombres',
      title: 'Quiz intermédiaire : Comptage',
      type: 'quiz',
      content: 'Vérifiez vos connaissances sur les dizaines.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Comment dit-on "20" ?',
          options: ['N\'san', 'Blou', 'Ablahun', 'Akpi'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'Quel nombre correspond à "Blou ni N\'so" ?',
          options: ['27', '13', '3', '17'],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question: 'Quel nombre correspond à "Akpi" ?',
          options: ['1000', '76', '0', '100'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Comment dit-on "80" ?',
          options: ['Môtchouê', 'Ablémôtchouê', 'Ablahun', 'Yakun'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Lesson(
      id: 'm03_q2',
      moduleId: 'm03_nombres',
      title: 'Quiz final : Nombres complets',
      type: 'quiz',
      content: 'Testez les chiffres et les expressions de quantité.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel nombre correspond à "N\'sien" ?',
          options: ['3', '4', '5', '6'],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question: 'Comment dit-on "un kilo" ?',
          options: ['Kilo kun', 'Kilo N\'nou', 'Kpe nâ', 'Nè kpe'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Quelle est la traduction de "Ablésso" ?',
          options: ['10', '70', '100', '1000'],
          correctAnswerIndex: 2,
        ),
      ],
    ),
  ],

  'm04_famille': [
    Lesson(
      id: 'm04_l1',
      moduleId: 'm04_famille',
      title: 'Famille et entourage : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : famille, respect des aines, entourage, maison.

Le but est de donner une base utilisable dans la conversation, avec des mots simples et des phrases courtes. Les formes baoulé proposées doivent être vérifiées et améliorées avec les locuteurs, car la prononciation et certaines variantes changent selon les localités.

Vocabulaire de départ : père, mère, enfant, ami, maison.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/test1.mp3',
    ),
    Lesson(
      id: 'm04_l2',
      moduleId: 'm04_famille',
      title: 'Famille et entourage : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
- utiliser un mot clé du module
- former une phrase courte
- demander confirmation si la prononciation varie

Exercice : présenter une personne de sa famille.
''',
      order: 2,
      audioUrl: 'https://example.com/audio/m04_l2.mp3',
    ),
    Lesson(
      id: 'm04_l3',
      moduleId: 'm04_famille',
      title: 'Famille et entourage : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Famille et entourage.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://example.com/audio/m04_l3.mp3',
    ),
    Lesson(
      id: 'm04_q1',
      moduleId: 'm04_famille',
      title: 'Quiz intermédiaire : Famille et entourage',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur famille et entourage.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m04 ?',
          options: [
            'Famille et entourage',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm04_q2',
      moduleId: 'm04_famille',
      title: 'Quiz final : Famille et entourage',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur famille et entourage.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que doit faire l apprenant après ce brouillon ?',
          options: [
            'Vérifier et améliorer les données',
            'Tout supprimer',
            'Ne rien relire',
            'Changer de module au hasard',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm05_nature': [
    Lesson(
      id: 'm05_l1',
      moduleId: 'm05_nature',
      title: 'Nature et environnement : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : champ, eau, animaux, saisons, environnement.

Le but est de donner une base utilisable dans la conversation, avec des mots simples et des phrases courtes. Les formes baoulé proposées doivent être vérifiées et améliorées avec les locuteurs, car la prononciation et certaines variantes changent selon les localités.

Vocabulaire de départ : nzué/eau, fié/champ, nanin/boeuf.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://example.com/audio/m05_l1.mp3',
    ),
    Lesson(
      id: 'm05_l2',
      moduleId: 'm05_nature',
      title: 'Nature et environnement : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
- utiliser un mot clé du module
- former une phrase courte
- demander confirmation si la prononciation varie

Exercice : décrire un lieu autour du village.
''',
      order: 2,
      audioUrl: 'https://example.com/audio/m05_l2.mp3',
    ),
    Lesson(
      id: 'm05_l3',
      moduleId: 'm05_nature',
      title: 'Nature et environnement : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Nature et environnement.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://example.com/audio/m05_l3.mp3',
    ),
    Lesson(
      id: 'm05_q1',
      moduleId: 'm05_nature',
      title: 'Quiz intermédiaire : Nature et environnement',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur nature et environnement.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m05 ?',
          options: [
            'Nature et environnement',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm05_q2',
      moduleId: 'm05_nature',
      title: 'Quiz final : Nature et environnement',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur nature et environnement.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que doit faire l apprenant après ce brouillon ?',
          options: [
            'Vérifier et améliorer les données',
            'Tout supprimer',
            'Ne rien relire',
            'Changer de module au hasard',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm06_cuisine': [
    Lesson(
      id: 'm06_l1',
      moduleId: 'm06_cuisine',
      title: 'Nourriture et cuisine baoulé : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : repas, marché, igname, nourriture, partage.

Le but est de donner une base utilisable dans la conversation, avec des mots simples et des phrases courtes. Les formes baoulé proposées doivent être vérifiées et améliorées avec les locuteurs, car la prononciation et certaines variantes changent selon les localités.

Vocabulaire de départ : aliè/nourriture, to/acheter.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://example.com/audio/m06_l1.mp3',
    ),
    Lesson(
      id: 'm06_l2',
      moduleId: 'm06_cuisine',
      title: 'Nourriture et cuisine baoulé : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
- utiliser un mot clé du module
- former une phrase courte
- demander confirmation si la prononciation varie

Exercice : demander ou acheter de la nourriture.
''',
      order: 2,
      audioUrl: 'https://example.com/audio/m06_l2.mp3',
    ),
    Lesson(
      id: 'm06_l3',
      moduleId: 'm06_cuisine',
      title: 'Nourriture et cuisine baoulé : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Nourriture et cuisine baoulé.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://example.com/audio/m06_l3.mp3',
    ),
    Lesson(
      id: 'm06_q1',
      moduleId: 'm06_cuisine',
      title: 'Quiz intermédiaire : Nourriture et cuisine baoulé',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur nourriture et cuisine baoulé.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m06 ?',
          options: [
            'Nourriture et cuisine baoulé',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm06_q2',
      moduleId: 'm06_cuisine',
      title: 'Quiz final : Nourriture et cuisine baoulé',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur nourriture et cuisine baoulé.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que doit faire l apprenant après ce brouillon ?',
          options: [
            'Vérifier et améliorer les données',
            'Tout supprimer',
            'Ne rien relire',
            'Changer de module au hasard',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm07_grammaire': [
    Lesson(
      id: 'm07_l1',
      moduleId: 'm07_grammaire',
      title: 'Grammaire : structure de la phrase : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : sujet, action, phrase simple.

Vocabulaire de départ : N'sou kô mi awlo : Je m'en vais chez moi(à la maison), Man mi nzué : Donne moi de l'eau.

- "N' " : Je/Me/Moi
- "À bôhô" : Toi/Tu/Sa/Son
- "Hi / ê" : Il/Elle/Lui
-"Yebé" : Nous
-"Bé" : Eux/Ils/Elles

- "Mi" : Mon/Ma/Moi
- "Man" : Donner
- "Fà" : Prendre
- "Yo" : Faire
- "Bo" : Frapper/ Taper
- "Kô" : Aller
- "Sou" : En train /oreille
- "Nian" : Régarder
- "Floua" : Papier

Exemple: N'sou nian flouanou : Je suis en train d'étudier

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M7_L1.m4a',
    ),
    Lesson(
      id: 'm07_l2',
      moduleId: 'm07_grammaire',
      title: 'Grammaire : structure de la phrase : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- "Agniho/Arêho" : pour dire "Bonjour" avant toutes conversation avec la personne
- "Mo / Kloua" : pour dire "bon travail" ou "merci"
- "Yaki" : pour demander "pardon" 
- "Kô" : aller
- "Goua" : Marché - un lieu où on vends
- "Goua bo": Au marché 
- "Nouh" : dédans
- "Bla" : pour dire "vient"
- "Blà" : Marigot ou source d'eau
- "Blah" : Femme ou fille

Exemple 1: N'sou kô goua bo : Je vais au marché.
Exemple 2: N'sou kô blà nouh : Je vais au marigot.


Exercice : construire une phrase courte.
''',
      order: 2,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M7_L2.m4a',
    ),
    Lesson(
      id: 'm07_l3',
      moduleId: 'm07_grammaire',
      title: 'Grammaire : structure de la phrase : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Grammaire : structure de la phrase.

Phrase 1 : une phrase pour nommer. 
Réponse: "Bé flêhi" : Il s'appelle.

Phrase 2 : une phrase pour demander.
Réponse: "Yaki tchê mi" : Pardonne-moi

Phrase 3 : une phrase pour répondre.
Réponse: "N'sou kô" : Je vais

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M7_L3.m4a',
    ),
    Lesson(
      id: 'm07_q1',
      moduleId: 'm07_grammaire',
      title: 'Quiz intermédiaire : Grammaire : structure de la phrase',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur grammaire : structure de la phrase.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module 07 ?',
          options: [
            'Grammaire : structure de la phrase',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
         QuizQuestion(
          question:
              'Que veut dire: "N\'sou kô blà nouh" ?',
          options: [
            'Je m\'en vais à l\'école',
            'Parce que le baoulé ne se parle pas',
            'Je vais au marigot',
            'La phrase n\'a pas de sens',
          ],
          correctAnswerIndex: 2,
        ),
      ],
    ),
    Lesson(
      id: 'm07_q2',
      moduleId: 'm07_grammaire',
      title: 'Quiz final : Grammaire : structure de la phrase',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur grammaire : structure de la phrase.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
            'Faire des phrases courtes',
          ],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que signifie "Hi blah" ?',
          options: [
            'Son marigot',
            'Venir',
            'Sa femme',
            'Bienvenue',
          ],
          correctAnswerIndex: 2,
        ),
      ],
    ),
  ],

  'm08_quotidien': [
    Lesson(
      id: 'm08_l1',
      moduleId: 'm08_quotidien',
      title: 'Vie quotidienne et déplacements : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : maison, champ, marché, déplacement, action.

- "Souhâ": Maison
- "Loto" : Voiture
- "Kpanguô" : Vélo
- "Anuan": Porte
- "Wandi": Courir
- "Fié" : Champ
- "Nanti" : Marché (je marche)
- "Djasso" : Se lever
- "Tô" : Tomber
- "To" : Lancer / acheter / payer
- "Sika" : L'argent
- "Sika ôclouê" : L'or
- "Fà" : Prendre
- "Tiké" : Ouvre
- "Clô" : Village / Ville

Vocabulaire de départ : awlo/maison, anuan/porte, wandi/courir.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M8_L1.m4a',
    ),
    Lesson(
      id: 'm08_l2',
      moduleId: 'm08_quotidien',
      title: 'Vie quotidienne et déplacements : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- Agniho, â sou kô ni : Bonjour, où allez-vous ?
- N'sou kô clô : Je vais au village 
- Tiké Anuan : Ouvre la porte
- N'sou kô wandi : Je cours

Exercice : Dire où on va et ce qu'on fait.
''',
      order: 2,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/test1.mp3',
    ),
    Lesson(
      id: 'm08_l3',
      moduleId: 'm08_quotidien',
      title: 'Vie quotidienne et déplacements : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Vie quotidienne et déplacements.

Phrase 1 : une phrase pour nommer.
Répnse: "Mi sika" : Mon argent
Phrase 2 : une phrase pour demander.
Réponse: "N'gué ô" : C'est quoi ?
Phrase 3 : une phrase pour répondre.
Réponse: "sika ô" : C'est de l'argent

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M8_L3.m4a',
    ),
    Lesson(
      id: 'm08_q1',
      moduleId: 'm08_quotidien',
      title: 'Quiz intermédiaire : Vie quotidienne et déplacements',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur vie quotidienne et déplacements.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module 08 ?',
          options: [
            'Vie quotidienne et déplacements',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Que signifie "Sika ôclouê" ?',
          options: [
            'De l\'argent',
            'Parce que le baoulé ne se parle pas',
            'De l\'or',
            'Marché',
          ],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question:
              '"N\'sou bâ" signifie quoi',
          options: [
            'Je suis en bas',
            'Je vais',
            'Je suis là',
            'J\'arrive',
          ],
          correctAnswerIndex: 3,
        ),
      ],
    ),
    Lesson(
      id: 'm08_q2',
      moduleId: 'm08_quotidien',
      title: 'Quiz final : Vie quotidienne et déplacements',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur vie quotidienne et déplacements.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
            'Pour mieux retenir et parler',
          ],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question: 'Le nom baoulé du village est : ',
          options: [
            'Sakassou',
            'Clô',
            'Ne rien relire',
            'Bouaké',
          ],
          correctAnswerIndex: 1,
        ),
      ],
    ),
  ],

  'm09_interactions': [
    Lesson(
      id: 'm09_l1',
      moduleId: 'm09_interactions',
      title: 'Interactions sociales : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : inviter, accepter, refuser, remercier, respecter.

Vocabulaire de départ : Agniho, Kloua, Wo wun ti kpa.

- "Eh wlou awlo" : Je vous invite à manger
- "N'ti li" : J'ai compris
- "Tchêtchê" : Non / refuser
- "Mo" : Merci
- "Kloua" : Merci
- "Gni" : Face / Visage
- "Gni gni lê" : Le respect

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M9_L1.m4a',
    ),
    Lesson(
      id: 'm09_l2',
      moduleId: 'm09_interactions',
      title: 'Interactions sociales : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
P1- Ahoussi oh : Bonsoir
P2- E Wlou awlo : Je vous invite ?
P1- Tchêchê wa yo kpâ : Non, c'est bon
P1- Kloua : Merci

Exercice : Tenir un petit dialogue social.
''',
      order: 2,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M9_L2.m4a',
    ),
    Lesson(
      id: 'm09_l3',
      moduleId: 'm09_interactions',
      title: 'Interactions sociales : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Interactions sociales.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M9_L3.m4a',
    ),
    Lesson(
      id: 'm09_q1',
      moduleId: 'm09_interactions',
      title: 'Quiz intermédiaire : Interactions sociales',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur interactions sociales.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m09 ?',
          options: [
            'Les couleurs uniquement',
            'Les calculs',
            'Interactions sociales',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Comment inviter une personne à manger en baoulé ?',
          options: [
            'E wandi',
            'Tchêtchê wa yo kpâ',
            'Parce que les phrases sont interdites',
            'E wlou awlo',
          ],
          correctAnswerIndex: 3,
        ),
      ],
    ),
    Lesson(
      id: 'm09_q2',
      moduleId: 'm09_interactions',
      title: 'Quiz final : Interactions sociales',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur interactions sociales.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel mot pour remercier en Baoulé ?',
          options: [
            'Yaki',
            'Kloua',
            'Blah',
            'Kpâ',
          ],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
            'Pour mieux retenir et parler',
          ],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question: 'Que signifie "Ahoussi" ?',
          options: [
            'Bonsoir',
            'Tout supprimer',
            'Bonjour',
            'Courir',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm10_proverbes': [
    Lesson(
      id: 'm10_l1',
      moduleId: 'm10_proverbes',
      title: 'Proverbes et expressions : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : sagesse, image, conseil, sens caché.

Le but est de donner une base utilisable dans la conversation, avec des mots simples et des phrases courtes. Les formes baoulé proposées doivent être vérifiées et améliorées avec les locuteurs, car la prononciation et certaines variantes changent selon les localités.

Vocabulaire de départ : Hî di lê yo yah = c est difficile.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/test1.mp3',
    ),
    Lesson(
      id: 'm10_l2',
      moduleId: 'm10_proverbes',
      title: 'Proverbes et expressions : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
- utiliser un mot clé du module
- former une phrase courte
- demander confirmation si la prononciation varie

Exercice : comprendre une expression dans son contexte.
''',
      order: 2,
      audioUrl: 'https://example.com/audio/m10_l2.mp3',
    ),
    Lesson(
      id: 'm10_l3',
      moduleId: 'm10_proverbes',
      title: 'Proverbes et expressions : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Proverbes et expressions.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://example.com/audio/m10_l3.mp3',
    ),
    Lesson(
      id: 'm10_q1',
      moduleId: 'm10_proverbes',
      title: 'Quiz intermédiaire : Proverbes et expressions',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur proverbes et expressions.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m10 ?',
          options: [
            'Proverbes et expressions',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm10_q2',
      moduleId: 'm10_proverbes',
      title: 'Quiz final : Proverbes et expressions',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur proverbes et expressions.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que doit faire l apprenant après ce brouillon ?',
          options: [
            'Vérifier et améliorer les données',
            'Tout supprimer',
            'Ne rien relire',
            'Changer de module au hasard',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm11_verbes': [
    Lesson(
      id: 'm11_l1',
      moduleId: 'm11_verbes',
      title: 'Verbes d action et conjugaison : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : acheter, courir, donner, ouvrir, aller, venir.

Le but est de donner une base utilisable dans la conversation, avec des mots simples et des phrases courtes. Les formes baoulé proposées doivent être vérifiées et améliorées avec les locuteurs, car la prononciation et certaines variantes changent selon les localités.

Vocabulaire de départ : to/acheter, wandi/courir.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://example.com/audio/m11_l1.mp3',
    ),
    Lesson(
      id: 'm11_l2',
      moduleId: 'm11_verbes',
      title: 'Verbes d action et conjugaison : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
- utiliser un mot clé du module
- former une phrase courte
- demander confirmation si la prononciation varie

Exercice : mettre un verbe dans une phrase.
''',
      order: 2,
      audioUrl: 'https://example.com/audio/m11_l2.mp3',
    ),
    Lesson(
      id: 'm11_l3',
      moduleId: 'm11_verbes',
      title: 'Verbes d action et conjugaison : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Verbes d action et conjugaison.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://example.com/audio/m11_l3.mp3',
    ),
    Lesson(
      id: 'm11_q1',
      moduleId: 'm11_verbes',
      title: 'Quiz intermédiaire : Verbes d action et conjugaison',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur verbes d action et conjugaison.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m11 ?',
          options: [
            'Verbes d action et conjugaison',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm11_q2',
      moduleId: 'm11_verbes',
      title: 'Quiz final : Verbes d action et conjugaison',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur verbes d action et conjugaison.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que doit faire l apprenant après ce brouillon ?',
          options: [
            'Vérifier et améliorer les données',
            'Tout supprimer',
            'Ne rien relire',
            'Changer de module au hasard',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm12_communication': [
    Lesson(
      id: 'm12_l1',
      moduleId: 'm12_communication',
      title: 'Communication avancée : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : besoin, précision, reformulation, correction.

Le but est de donner une base utilisable dans la conversation, avec des mots simples et des phrases courtes. Les formes baoulé proposées doivent être vérifiées et améliorées avec les locuteurs, car la prononciation et certaines variantes changent selon les localités.

Vocabulaire de départ : comment dire, répète, je ne comprends pas.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://example.com/audio/m12_l1.mp3',
    ),
    Lesson(
      id: 'm12_l2',
      moduleId: 'm12_communication',
      title: 'Communication avancée : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
- utiliser un mot clé du module
- former une phrase courte
- demander confirmation si la prononciation varie

Exercice : demander une explication clairement.
''',
      order: 2,
      audioUrl: 'https://example.com/audio/m12_l2.mp3',
    ),
    Lesson(
      id: 'm12_l3',
      moduleId: 'm12_communication',
      title: 'Communication avancée : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Communication avancée.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://example.com/audio/m12_l3.mp3',
    ),
    Lesson(
      id: 'm12_q1',
      moduleId: 'm12_communication',
      title: 'Quiz intermédiaire : Communication avancée',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur communication avancée.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m12 ?',
          options: [
            'Communication avancée',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm12_q2',
      moduleId: 'm12_communication',
      title: 'Quiz final : Communication avancée',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur communication avancée.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que doit faire l apprenant après ce brouillon ?',
          options: [
            'Vérifier et améliorer les données',
            'Tout supprimer',
            'Ne rien relire',
            'Changer de module au hasard',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm13_culture': [
    Lesson(
      id: 'm13_l1',
      moduleId: 'm13_culture',
      title: 'Histoire et culture : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : peuple akan, centre de la Côte d Ivoire, Paquinou, chefferie, arts.
- "Wawoulé" : Baoulé 
- "Paquinou" : La fête de pâques
- "Afihin" : Au milieu / Au centre
- "Sakassou" : Le village de la reine Pokou
- "Klô kpin" : Le chef du village 
- "Nanan" : Roi / Chef suprême
- "Bia" : Tabouret royal
- "Awlo dan" : La cours royale
- "Amoun" : Masque
- "Walêbo" : Une variété de danse
- "Adjémélé" : Une danse Baoulé comme le Zaouli
- "Goli" : Masque Baoulé dansé dans les festives 
Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M13_L1.m4a',
    ),
    Lesson(
      id: 'm13_l2',
      moduleId: 'm13_culture',
      title: 'Histoire et culture : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation : 
Réponse : "Nana Agniho" : Bonjour le chef

- utiliser un mot clé du module
Réponse : "N'sou kô Sakassou" : Je vais à Sakassou

- former une phrase courte
Réponse : "E sou kô awlo dan" : Nous allons à la cours royale

Exercice : Expliquer un repère culturel.
''',
      order: 2,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M13_L2.m4a',
    ),
    Lesson(
      id: 'm13_l3',
      moduleId: 'm13_culture',
      title: 'Histoire et culture : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Histoire et culture.

Phrase 1 : une phrase pour nommer.
Réponse : "Be flêhi Goli" : Il s'appelle Goli

Phrase 2 : une phrase pour demander.
Réponse : "Be sou yo n'gué" : Ils font quoi ?

Phrase 3 : une phrase pour répondre.
Réponse : "Be sou si Goli" : Ils dansent le Goli

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M13_L3.m4a',
    ),
    Lesson(
      id: 'm13_q1',
      moduleId: 'm13_culture',
      title: 'Quiz intermédiaire : Histoire et culture',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur histoire et culture.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m13 ?',
          options: [
            'Histoire et culture',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Que signifie "Amoun" ?',
          options: [
            'Goli',
            'Tabouret',
            'Masque',
            'Dents',
          ],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question:
              'Comment appelle-t-on le chef du village ?',
          options: [
            'Adjémélé',
            'Klô kpin',
            'Bia',
            'Walêbo',
          ],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Lesson(
      id: 'm13_q2',
      moduleId: 'm13_culture',
      title: 'Quiz final : Histoire et culture',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur histoire et culture.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Qua signifie "Be sou si ablé" ?',
          options: [
            'Ils sont en train de parler',
            'Ils sont en train de danser',
            'Elle mange',
            'Piler du Maîs',
          ],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
            'Pour mieux retenir et parler',
          ],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question: 'Comment appelle-t-on le centre en Baoulé ?',
          options: [
            'À siè hun',
            'Wlafouin',
            'Afihin',
            'Sakassou',
          ],
          correctAnswerIndex: 2,
        ),
      ],
    ),
  ],

  'm14_narration': [
    Lesson(
      id: 'm14_l1',
      moduleId: 'm14_narration',
      title: 'Récits et narration : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : qui, où, action, suite, fin, morale.

Vocabulaire de départ : "I Bo bolê": d'abord, "N'guà sou isou" : ensuite, "I bo goualê / À goualiê" : enfin/fin.
Récit Baoulé : " Min i bo bolê inou liké dann dan be si ni"
En français : "D'abord, dans la création de l'humanité beaucoup de choses se sont passées".

Récit Baoulé: "I bo goualê inou liké dann dan be wa si"
En français : "Enfin, à sa fin beaucoup de choses vont se passer"

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/test1.mp3',
    ),
    Lesson(
      id: 'm14_l2',
      moduleId: 'm14_narration',
      title: 'Récits et narration : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
Réponse : "Hi boli i bo" : Il a commencé

- utiliser un mot clé du module
Réponse : "N'guà sou isou" : Ensuite

- former une phrase courte
Réponse : "Hi gouali I bo" : Il a terminé


Exercice : raconter une petite scène.
''',
      order: 2,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/test1.mp3',
    ),
    Lesson(
      id: 'm14_l3',
      moduleId: 'm14_narration',
      title: 'Récits et narration : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Récits et narration.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/test1.mp3',
    ),
    Lesson(
      id: 'm14_q1',
      moduleId: 'm14_narration',
      title: 'Quiz intermédiaire : Récits et narration',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur récits et narration.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m14 ?',
          options: [
            'Récits et narration',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Quelle structure pour raconter un fait en Baoulé ?',
          options: [
            'I bo bolê, guà sou, i bo bolê',
            'Parce que les mots sont toujours en français',
            'I bo bolê, n\'guà sou isou, i bo goualê',
            'D\'abord, ensuite, enfin',
          ],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question:
              'À quoi servent les contes Baoulé ?',
          options: [
            'Pas d\'importance',
            'Préserver le patrimoine culturel et enseigner facilement',
            'Se divertir',
            'Parler le Boualé',
          ],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Lesson(
      id: 'm14_q2',
      moduleId: 'm14_narration',
      title: 'Quiz final : Récits et narration',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur récits et narration.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Un conte signifie quoi pour les baoulé ?',
          options: [
            'Mieux mentir',
            'Un moment de partage et d\'apprentissage',
            'Éviter la conversation',
            'Ne pas respecter les anciens',
          ],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Que signifie "I bo goualê" ?',
          options: [
            'Klô',
            'Tout de suite',
            'Au mileu',
            'Au commencent',
          ],
          correctAnswerIndex: 3,
        ),
      ],
    ),
  ],

  'm15_argumentation': [
    Lesson(
      id: 'm15_l1',
      moduleId: 'm15_argumentation',
      title: 'Argumentation et débats : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : opinion, raison, exemple, respect, désaccord.

- "Mi sou wôsou" : Je suis d'accord avec toi (d'accord)
- "Mi sou man wôsou" : Je ne suis pas d'accord avec toi (désaccord)
- "Kê n'guà mon" : Pendant que / Où ...
- "Mi gni gni ô" : Je te/vous respecte
- "N'bou kê" : Je pense que ...
- "Nian" : Regarder / Voir

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M15_L1.m4a',
    ),
    Lesson(
      id: 'm15_l2',
      moduleId: 'm15_argumentation',
      title: 'Argumentation et débats : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
Réponse: "Agniho Anian" : Bonjour Frère

- utiliser un mot clé du module
Réponse: "Mi sou wôsou" : Je suis d'accord avec toi

- formuler une phrase courte
Réponse: "N'bou kê mi sou wôsou" : Je pense que je suis d'accord

Exercice : donner un avis avec calme.
''',
      order: 2,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/test1.mp3',
    ),
    Lesson(
      id: 'm15_l3',
      moduleId: 'm15_argumentation',
      title: 'Argumentation et débats : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Argumentation et débats.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/M15_L3.m4a',
    ),
    Lesson(
      id: 'm15_q1',
      moduleId: 'm15_argumentation',
      title: 'Quiz intermédiaire : Argumentation et débats',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur argumentation et débats.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m15 ?',
          options: [
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
            'Argumentation et débats',
          ],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Que veut dire "wôsou" ?',
          options: [
            'Désaccord',
            'Pendant que....',
            'suivre quelqu\'un ou être d\'accord',
            'Pas d\'accord',
          ],
          correctAnswerIndex: 2,
        ),
      ],
    ),
    Lesson(
      id: 'm15_q2',
      moduleId: 'm15_argumentation',
      title: 'Quiz final : Argumentation et débats',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur argumentation et débats.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Comment dire " Je ne suis pas d\'accord" en Baoulé ?',
          options: [
            'Mi awlo',
            'Mi sou man wôsou',
            'N\'dê dan dan mou',
            'Djasso',
          ],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour suivre quelqu\'un',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'LA côte d\'Ivoire a eu son indépendance le 07 Août 1960',
          options: [
            'N\'ti li',
            'Mi sou man wôsou',
            'Tchêtchê',
            'Mi sou wôsou',
          ],
          correctAnswerIndex: 3,
        ),
      ],
    ),
  ],

  'm16_formel': [
    Lesson(
      id: 'm16_l1',
      moduleId: 'm16_formel',
      title: 'Expressions formelles : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : salutation formelle, demande polie, aines, autorité.

Le but est de donner une base utilisable dans la conversation, avec des mots simples et des phrases courtes. Les formes baoulé proposées doivent être vérifiées et améliorées avec les locuteurs, car la prononciation et certaines variantes changent selon les localités.

Vocabulaire de départ : Agniho, Kloua, formule respectueuse.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/test1.mp3',
    ),
    Lesson(
      id: 'm16_l2',
      moduleId: 'm16_formel',
      title: 'Expressions formelles : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
- utiliser un mot clé du module
- former une phrase courte
- demander confirmation si la prononciation varie

Exercice : faire une demande avec respect.
''',
      order: 2,
      audioUrl: 'https://example.com/audio/test1.mp3',
    ),
    Lesson(
      id: 'm16_l3',
      moduleId: 'm16_formel',
      title: 'Expressions formelles : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Expressions formelles.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://example.com/audio/m16_l3.mp3',
    ),
    Lesson(
      id: 'm16_q1',
      moduleId: 'm16_formel',
      title: 'Quiz intermédiaire : Expressions formelles',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur expressions formelles.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m16 ?',
          options: [
            'Expressions formelles',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm16_q2',
      moduleId: 'm16_formel',
      title: 'Quiz final : Expressions formelles',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur expressions formelles.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que doit faire l apprenant après ce brouillon ?',
          options: [
            'Vérifier et améliorer les données',
            'Tout supprimer',
            'Ne rien relire',
            'Changer de module au hasard',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm17_correspondance': [
    Lesson(
      id: 'm17_l1',
      moduleId: 'm17_correspondance',
      title: 'Langue écrite et correspondance : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : message court, salutation, information, relecture.

Le but est de donner une base utilisable dans la conversation, avec des mots simples et des phrases courtes. Les formes baoulé proposées doivent être vérifiées et améliorées avec les locuteurs, car la prononciation et certaines variantes changent selon les localités.

Vocabulaire de départ : bonjour, merci, rendez vous.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://example.com/audio/m17_l1.mp3',
    ),
    Lesson(
      id: 'm17_l2',
      moduleId: 'm17_correspondance',
      title: 'Langue écrite et correspondance : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
- utiliser un mot clé du module
- former une phrase courte
- demander confirmation si la prononciation varie

Exercice : écrire un message simple.
''',
      order: 2,
      audioUrl: 'https://example.com/audio/m17_l2.mp3',
    ),
    Lesson(
      id: 'm17_l3',
      moduleId: 'm17_correspondance',
      title: 'Langue écrite et correspondance : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Langue écrite et correspondance.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://example.com/audio/m17_l3.mp3',
    ),
    Lesson(
      id: 'm17_q1',
      moduleId: 'm17_correspondance',
      title: 'Quiz intermédiaire : Langue écrite et correspondance',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur langue écrite et correspondance.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m17 ?',
          options: [
            'Langue écrite et correspondance',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm17_q2',
      moduleId: 'm17_correspondance',
      title: 'Quiz final : Langue écrite et correspondance',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur langue écrite et correspondance.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que doit faire l apprenant après ce brouillon ?',
          options: [
            'Vérifier et améliorer les données',
            'Tout supprimer',
            'Ne rien relire',
            'Changer de module au hasard',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],

  'm18_perfectionnement': [
    Lesson(
      id: 'm18_l1',
      moduleId: 'm18_perfectionnement',
      title: 'Perfectionnement oral : bases',
      type: 'reading',
      content: '''
Ce module travaille le thème suivant : écoute, répétition, tons, fluidité, correction.

Le but est de donner une base utilisable dans la conversation, avec des mots simples et des phrases courtes. Les formes baoulé proposées doivent être vérifiées et améliorées avec les locuteurs, car la prononciation et certaines variantes changent selon les localités.

Vocabulaire de départ : écouter, répéter, demander correction.

Objectif : comprendre le thème avant de mémoriser les détails.
''',
      order: 1,
      audioUrl: 'https://example.com/audio/m18_l1.mp3',
    ),
    Lesson(
      id: 'm18_l2',
      moduleId: 'm18_perfectionnement',
      title: 'Perfectionnement oral : usage en contexte',
      type: 'reading',
      content: '''
Dans cette leçon, vous apprenez à utiliser le thème en situation.

Méthode :
- commencer par une salutation
- utiliser un mot clé du module
- former une phrase courte
- demander confirmation si la prononciation varie

Exercice : parler avec plus de confiance.
''',
      order: 2,
      audioUrl: 'https://example.com/audio/m18_l2.mp3',
    ),
    Lesson(
      id: 'm18_l3',
      moduleId: 'm18_perfectionnement',
      title: 'Perfectionnement oral : pratique guidée',
      type: 'reading',
      content: '''
Pratique guidée.

Construisez trois phrases simples autour du thème : Perfectionnement oral.

Phrase 1 : une phrase pour nommer.
Phrase 2 : une phrase pour demander.
Phrase 3 : une phrase pour répondre.

Conseil : gardez les phrases courtes. La précision vient avec la répétition et la correction par les locuteurs.
''',
      order: 3,
      audioUrl: 'https://example.com/audio/m18_l3.mp3',
    ),
    Lesson(
      id: 'm18_q1',
      moduleId: 'm18_perfectionnement',
      title: 'Quiz intermédiaire : Perfectionnement oral',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur perfectionnement oral.',
      order: 4,
      quizQuestions: [
        QuizQuestion(
          question: 'Quel est le thème principal du module m18 ?',
          options: [
            'Perfectionnement oral',
            'Les couleurs uniquement',
            'Les calculs',
            'Les appels vidéo',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question:
              'Pourquoi faut-il vérifier certaines formes avec les locuteurs ?',
          options: [
            'Parce que la prononciation peut varier',
            'Parce que le baoulé ne se parle pas',
            'Parce que les mots sont toujours anglais',
            'Parce que les phrases sont interdites',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Lesson(
      id: 'm18_q2',
      moduleId: 'm18_perfectionnement',
      title: 'Quiz final : Perfectionnement oral',
      type: 'quiz',
      content: 'Vérifiez vos acquis sur perfectionnement oral.',
      order: 5,
      quizQuestions: [
        QuizQuestion(
          question: 'Quelle méthode est conseillée pour pratiquer ?',
          options: [
            'Faire des phrases courtes',
            'Inventer sans vérifier',
            'Ignorer les tons',
            'Ne jamais répéter',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Pourquoi utiliser des exemples concrets ?',
          options: [
            'Pour mieux retenir et parler',
            'Pour supprimer le vocabulaire',
            'Pour éviter la conversation',
            'Pour remplacer les audios',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'Que doit faire l apprenant après ce brouillon ?',
          options: [
            'Vérifier et améliorer les données',
            'Tout supprimer',
            'Ne rien relire',
            'Changer de module au hasard',
          ],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ],
};
