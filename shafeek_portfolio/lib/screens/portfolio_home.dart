// lib/screens/portfolio_home.dart
import 'package:flutter/material.dart';
import '../screens/about_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/games_screen.dart';
import '../screens/contact_screen.dart';

class PortfolioHome extends StatefulWidget {
  final VoidCallback toggleTheme;
  const PortfolioHome({super.key, required this.toggleTheme});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AboutPage(),
    ProjectsPage(),
    GamesPage(),
    const ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 223, 255, 45),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}
