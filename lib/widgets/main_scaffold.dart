import 'package:flutter/material.dart';
import 'package:myapp/screens/home/home_screen.dart';
import 'package:myapp/screens/modules/modules_screen.dart';
import 'package:myapp/screens/dictionary/dictionary_screen.dart';
import 'package:myapp/screens/peer_to_peer/user_list_screen.dart'; // Import de l'écran des utilisateurs

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // Mettez à jour la liste des widgets pour inclure l'écran de chat/P2P
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ModulesScreen(),
    UserListScreen(), // Écran pour le peer-to-peer
    DictionaryScreen(),
  ];

  // Mettons à jour les titres pour refléter le changement
  static const List<String> _widgetTitles = <String>[
    'Tableau de Bord',
    'Modules',
    'Communauté', // Nouveau titre pour le P2P
    'Dictionnaire',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Widget pour l'AppBar personnalisée
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      // On enlève le titre centré qui causait la confusion
      title: _selectedIndex == 0
          ? _buildWelcomeHeader(
              context,
              'NomUtilisateur',
            ) // Placeholder pour le nom
          : Text(
              _widgetTitles.elementAt(_selectedIndex),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            // Logique de déconnexion à implémenter
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Fonctionnalité de déconnexion à venir.'),
              ),
            );
          },
          tooltip: 'Déconnexion',
        ),
      ],
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, String userName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Bienvenue,',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        Text(
          userName, // Le nom de l'utilisateur sera dynamique plus tard
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Modules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            activeIcon: Icon(Icons.people_alt),
            label: 'Communauté',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            activeIcon: Icon(Icons.book),
            label: 'Dictionnaire',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[700],
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}
