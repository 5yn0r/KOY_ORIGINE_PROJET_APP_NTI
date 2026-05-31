import '../models/dictionary_word.dart';

// Pour l'instant, les données sont stockées localement.
// Plus tard, cela pourrait venir d'une base de données ou d'une API.
final List<DictionaryWord> dictionaryWords = [
  DictionaryWord(
    baoule: WordDetails(word: 'awlo', pronunciation: 'a-wlo'),
    french: WordDetails(word: 'maison'),
    audioUrl:
        'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Awlo.m4a', // Exemple de lien audio
    examples: [
      Example(baoule: 'N sou kô mi awlo', french: 'Je vais à la maison'),
    ],
    category: 'Vie Quotidienne',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'akwaba', pronunciation: 'a-kwa-ba'),
    french: WordDetails(word: 'bienvenue'),
    audioUrl:
        'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Akwaba.m4a',
    examples: [
      Example(
        baoule: 'Mi awlo, akwaba!',
        french: 'Dans ma maison, bienvenue !',
      ),
    ],
    category: 'Salutations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'nzué', pronunciation: 'n-zou-é'),
    french: WordDetails(word: 'eau'),
    audioUrl:
        'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Nzue.m4a',
    examples: [Example(baoule: 'Man mi nzué', french: 'Donne-moi de l\'eau')],
    category: 'Nourriture et Boisson',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'famien', pronunciation: 'fa-mi-en'),
    french: WordDetails(word: 'roi'),
    audioUrl:
        'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Famien.m4a',
    examples: [Example(baoule: 'Assé ti a mou liè famien', french: 'Salut, le roi')],
    category: 'Salutations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'Nanin', pronunciation: 'na-nin'),
    french: WordDetails(word: 'Bouef'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/bouef.mp3?alt=media&token=12345678-1234-1234-1234-123456789012', // Exemple de lien audio
    examples: [
      Example(baoule: 'Nanin sou bà', french: 'le bouef arrive'),
    ],
    category: 'Animaux',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'to', pronunciation: 'tau'),
    french: WordDetails(word: 'acheter'),
    audioUrl:
        'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/To.m4a', // Exemple de lien audio
    examples: [
      Example(baoule: 'Hun sou To aliè', french: 'J\'achete de la nourriture'),
    ],
    category: 'Achat et Nourriture',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'wandi', pronunciation: 'wandi'),
    french: WordDetails(word: 'courir'),
    audioUrl:
        'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Wandi.m4a', // Exemple de lien audio
    examples: [
      Example(baoule: 'N\'sou wandi', french: 'Je cours'),
    ],
    category: 'Sports et Activités',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'agni oh', pronunciation: 'agni-oh'),
    french: WordDetails(word: 'Bonjour'),
    audioUrl:
        'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Agniho.m4a', // Exemple de lien audio
    examples: [
      Example(baoule: 'Mo agni oh', french: 'Bonjour(le matin, à une femme)'),
    ],
    category: 'Salutations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'anou', pronunciation: 'a-nou'),
    french: WordDetails(word: 'soir'),
    audioUrl:
        'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Anou.m4a', // Exemple de lien audio
    examples: [
      Example(baoule: 'gna anou oh', french: 'Bonsoir(le soir, à un garçon)'),
    ],
    category: 'Salutations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'bakan', pronunciation: 'ba-kan'),
    french: WordDetails(word: 'enfant'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/enfant.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'Nian bakan guàlê', french: 'Régarde cet enfant'),
    ],
    category: 'Famille et Relations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'mami', pronunciation: 'ma-mi'),
    french: WordDetails(word: 'maman'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/maman.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'N\'mami', french: 'Ma maman'),
    ],
    category: 'Famille et Relations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'sî', pronunciation: 'sih'),
    french: WordDetails(word: 'père'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/pere.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'N\'sî', french: 'Mon père'),
    ],
    category: 'Famille et Relations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'janvuê', pronunciation: 'jan-vouê'),
    french: WordDetails(word: 'ami'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/ami.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'N\'janvuê', french: 'Mon ami'),
    ],
    category: 'Famille et Relations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'aniann', pronunciation: 'ani-han'),
    french: WordDetails(word: 'frère'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/frere.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'Mi niann', french: 'Mon frère'),
    ],
    category: 'Famille et Relations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'gnamien', pronunciation: 'gna-mien'),
    french: WordDetails(word: 'dieu'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/dieu.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'N\'gnamien', french: 'Mon dieu'),
    ],
    category: 'Divinité',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'kpli', pronunciation: 'kpli'),
    french: WordDetails(word: 'grand ou gros'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/maison.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'gnamien kpli', french: 'Le grand Dieu'),
    ],
    category: 'Quantité',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'anuan', pronunciation: 'anouan'),
    french: WordDetails(word: 'porte'),
    audioUrl:
        'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Anouan.m4a', // Exemple de lien audio
    examples: [
      Example(baoule: 'Mi anuan', french: 'Ma porte'),
      Example(baoule: 'Tiké anuan', french: 'Ouvre la porte'),
    ],
    category: 'Meubles',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'fié', pronunciation: 'fi-eh'),
    french: WordDetails(word: 'champ'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/maison.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'Mi fié', french: 'Mon champ'),
      Example(baoule: 'N\'sou kô fié sou', french: 'Je vais dans le champ'),
    ],
    category: 'Travail',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'anglannanh', pronunciation: 'anglan-nanh'),
    french: WordDetails(word: 'canne à sucre'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/maison.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'N\'sou dî anglannanh', french: 'Je mange de la canne à sucre'),
    ],
    category: 'Jus',
    difficulty: 4,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'koto', pronunciation: 'koto'),
    french: WordDetails(word: 'sac'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/maison.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'N\'Koto', french: 'Mon sac'),
    ],
    category: 'Vetements et Accessoires',
    difficulty: 3,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'sran', pronunciation: 'sranh'),
    french: WordDetails(word: 'personne'),
    audioUrl:
        'https://firebasestorage.googleapis.com/v0/b/koy-nti.appspot.com/o/maison.mp3?alt=media&token=434b92c4-5431-41d3-b187-5a7a72382f1b', // Exemple de lien audio
    examples: [
      Example(baoule: 'Mi Sran', french: 'Ma personne'),
      Example(baoule: 'Sran koun bah', french: 'Une personne arrive'),
    ],
    category: 'Famille et Relations',
    difficulty: 1,
    stats: WordStats(),
  ),
  // Nouveaux mots Baoulé ajoutés du dictionnaire enrichi
  DictionaryWord(
    baoule: WordDetails(word: 'agni', pronunciation: 'a-gni'),
    french: WordDetails(word: 'bonjour'),
    audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Agniho.m4a',
    examples: [
      Example(baoule: 'Agni!', french: 'Bonjour!'),
      Example(baoule: 'Agniho!', french: 'Bonjour! (variante)'),
    ],
    category: 'Salutations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'kloua', pronunciation: 'klou-a'),
    french: WordDetails(word: 'merci'),
    audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Kloua.m4a',
    examples: [
      Example(baoule: 'Kloua!', french: 'Merci!'),
      Example(baoule: 'Mo kloua', french: 'Merci beaucoup'),
    ],
    category: 'Salutations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'ahoussi', pronunciation: 'a-hou-ssi'),
    french: WordDetails(word: 'bonsoir'),
    audioUrl: 'https://zjtsioapfvilgglqgwjj.supabase.co/storage/v1/object/public/finalaudios/Dict_Nti/Ahoussiho.m4a',
    examples: [
      Example(baoule: 'Ahoussiho!', french: 'Bonsoir!'),
    ],
    category: 'Salutations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'baba', pronunciation: 'ba-ba'),
    french: WordDetails(word: 'père'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Mi baba', french: 'Mon père'),
    ],
    category: 'Famille et Relations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'mamy', pronunciation: 'ma-mi'),
    french: WordDetails(word: 'mère'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Mi mamy', french: 'Ma mère'),
    ],
    category: 'Famille et Relations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'blah', pronunciation: 'blah'),
    french: WordDetails(word: 'femme'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Hi blah', french: 'Sa femme'),
    ],
    category: 'Famille et Relations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'kun', pronunciation: 'kun'),
    french: WordDetails(word: 'un (1)'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Kun gbâ', french: 'Un seul'),
    ],
    category: 'Nombres',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'n\'gnon', pronunciation: 'n-gnon'),
    french: WordDetails(word: 'deux (2)'),
    audioUrl: '',
    examples: [
      Example(baoule: 'N\'gnon sran', french: 'Deux personnes'),
    ],
    category: 'Nombres',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'n\'san', pronunciation: 'n-san'),
    french: WordDetails(word: 'trois (3)'),
    audioUrl: '',
    examples: [
      Example(baoule: 'N\'san oranges', french: 'Trois oranges'),
    ],
    category: 'Nombres',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'blou', pronunciation: 'blou'),
    french: WordDetails(word: 'dix (10)'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Blou ni kun', french: 'Onze (10 + 1)'),
    ],
    category: 'Nombres',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'ablahun', pronunciation: 'a-bla-hun'),
    french: WordDetails(word: 'vingt (20)'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Ablahun sran', french: 'Vingt personnes'),
    ],
    category: 'Nombres',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'yakun', pronunciation: 'ya-kun'),
    french: WordDetails(word: 'cent (100)'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Yakun francs', french: 'Cent francs'),
    ],
    category: 'Nombres',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'akpi', pronunciation: 'ak-pi'),
    french: WordDetails(word: 'mille (1000)'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Akpi francs', french: 'Mille francs'),
    ],
    category: 'Nombres',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'sika', pronunciation: 'si-ka'),
    french: WordDetails(word: 'argent'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Mi sika', french: 'Mon argent'),
      Example(baoule: 'Sika ôclouê', french: 'De l\'or'),
    ],
    category: 'Commerce',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'goua', pronunciation: 'gou-a'),
    french: WordDetails(word: 'marché'),
    audioUrl: '',
    examples: [
      Example(baoule: 'N\'sou kô goua bo', french: 'Je vais au marché'),
    ],
    category: 'Lieux',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'clô', pronunciation: 'klô'),
    french: WordDetails(word: 'village'),
    audioUrl: '',
    examples: [
      Example(baoule: 'N\'sou kô clô', french: 'Je vais au village'),
    ],
    category: 'Lieux',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'blà', pronunciation: 'blà'),
    french: WordDetails(word: 'marigot'),
    audioUrl: '',
    examples: [
      Example(baoule: 'N\'sou kô blà nouh', french: 'Je vais au marigot'),
    ],
    category: 'Environnement',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'vià', pronunciation: 'vi-a'),
    french: WordDetails(word: 'soleil'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Vià sou bô', french: 'Le soleil brille'),
    ],
    category: 'Environnement',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'kô', pronunciation: 'kô'),
    french: WordDetails(word: 'aller'),
    audioUrl: '',
    examples: [
      Example(baoule: 'N\'sou kô', french: 'Je vais'),
      Example(baoule: 'Â sou kô ni?', french: 'Où allez-vous?'),
    ],
    category: 'Verbes',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'tiké', pronunciation: 'ti-ké'),
    french: WordDetails(word: 'ouvrir'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Tiké anuan', french: 'Ouvre la porte'),
    ],
    category: 'Verbes',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'fà', pronunciation: 'fà'),
    french: WordDetails(word: 'prendre'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Fà nzué', french: 'Prends de l\'eau'),
    ],
    category: 'Verbes',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'yo', pronunciation: 'yo'),
    french: WordDetails(word: 'faire'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Be sou yo n\'gué?', french: 'Ils font quoi?'),
    ],
    category: 'Verbes',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'nian', pronunciation: 'ni-an'),
    french: WordDetails(word: 'regarder'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Nian mi floua', french: 'Regarde mon papier'),
    ],
    category: 'Verbes',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'djasso', pronunciation: 'dja-sso'),
    french: WordDetails(word: 'se lever'),
    audioUrl: '',
    examples: [
      Example(baoule: 'N\'sou djasso', french: 'Je me lève'),
    ],
    category: 'Verbes',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'man mi', pronunciation: 'man mi'),
    french: WordDetails(word: 'donne-moi'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Man mi nzué', french: 'Donne-moi de l\'eau'),
      Example(baoule: 'Man mi n\'san oranges', french: 'Donne-moi trois oranges'),
    ],
    category: 'Verbes',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'gni gni lê', pronunciation: 'gni gni lê'),
    french: WordDetails(word: 'respect'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Mi gni gni ô', french: 'Je te respecte'),
    ],
    category: 'Valeurs',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'tchêtchê', pronunciation: 'tché-tché'),
    french: WordDetails(word: 'non'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Tchêtchê wa yo kpâ', french: 'Non, c\'est bon'),
    ],
    category: 'Communication',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'n\'ti li', pronunciation: 'n-ti li'),
    french: WordDetails(word: 'j\'ai compris'),
    audioUrl: '',
    examples: [
      Example(baoule: 'N\'ti li, kloua', french: 'J\'ai compris, merci'),
    ],
    category: 'Communication',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'yaki', pronunciation: 'ya-ki'),
    french: WordDetails(word: 'pardon'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Yaki tchê mi', french: 'Pardonne-moi'),
    ],
    category: 'Salutations',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'mi sou wôsou', pronunciation: 'mi sou wô-sou'),
    french: WordDetails(word: 'je suis d\'accord'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Mi sou wôsou', french: 'Je suis d\'accord avec toi'),
    ],
    category: 'Communication',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'goli', pronunciation: 'go-li'),
    french: WordDetails(word: 'masque/danse'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Be sou si Goli', french: 'Ils dansent le Goli'),
      Example(baoule: 'Be flêhi Goli', french: 'Il s\'appelle Goli'),
    ],
    category: 'Culture',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'amoun', pronunciation: 'a-moun'),
    french: WordDetails(word: 'masque'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Mi amoun', french: 'Mon masque'),
    ],
    category: 'Culture',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'nanan', pronunciation: 'na-nan'),
    french: WordDetails(word: 'roi'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Nana Agniho', french: 'Bonjour le chef'),
    ],
    category: 'Hiérarchie sociale',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'sakassou', pronunciation: 'sa-ka-ssou'),
    french: WordDetails(word: 'Sakassou'),
    audioUrl: '',
    examples: [
      Example(baoule: 'N\'sou kô Sakassou', french: 'Je vais à Sakassou'),
    ],
    category: 'Lieux culturels',
    difficulty: 3,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'n\'guà sou isou', pronunciation: 'n\'guà sou i-sou'),
    french: WordDetails(word: 'ensuite'),
    audioUrl: '',
    examples: [
      Example(baoule: 'I bo bolê, n\'guà sou isou', french: 'D\'abord, ensuite'),
    ],
    category: 'Narration',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'i bo bolê', pronunciation: 'i bo bo-lê'),
    french: WordDetails(word: 'd\'abord'),
    audioUrl: '',
    examples: [
      Example(baoule: 'I bo bolê inou', french: 'D\'abord, dans...'),
    ],
    category: 'Narration',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'i bo goualê', pronunciation: 'i bo gou-a-lê'),
    french: WordDetails(word: 'enfin'),
    audioUrl: '',
    examples: [
      Example(baoule: 'I bo goualê inou', french: 'À la fin...'),
    ],
    category: 'Narration',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'be flêhi', pronunciation: 'be flê-hi'),
    french: WordDetails(word: 'il/elle s\'appelle'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Be flêhi Goli', french: 'Il s\'appelle Goli'),
    ],
    category: 'Verbes',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'be sou si', pronunciation: 'be sou si'),
    french: WordDetails(word: 'ils/elles dansent'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Be sou si ablé', french: 'Ils sont en train de danser'),
    ],
    category: 'Verbes',
    difficulty: 2,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'loto', pronunciation: 'lo-to'),
    french: WordDetails(word: 'voiture'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Mi loto', french: 'Ma voiture'),
    ],
    category: 'Transports',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'kpanguô', pronunciation: 'kpan-guô'),
    french: WordDetails(word: 'vélo'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Mi kpanguô', french: 'Mon vélo'),
    ],
    category: 'Transports',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'floua', pronunciation: 'flou-a'),
    french: WordDetails(word: 'papier'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Nian mi floua', french: 'Regarde mon papier'),
    ],
    category: 'Objets',
    difficulty: 1,
    stats: WordStats(),
  ),
  DictionaryWord(
    baoule: WordDetails(word: 'aliè', pronunciation: 'a-li-è'),
    french: WordDetails(word: 'nourriture'),
    audioUrl: '',
    examples: [
      Example(baoule: 'Hun sou to aliè', french: 'J\'achète de la nourriture'),
    ],
    category: 'Nourriture et Boisson',
    difficulty: 1,
    stats: WordStats(),
  ),
];
