import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'tasks_screen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final _screens = [
    HomeScreen(),
    TasksScreen(),
    Scaffold(
      appBar: AppBar(title: Text('Materias')),
      body: Center(child: Text('Pantalla de Materias - En desarrollo')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Tareas'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Materias'),
        ],
      ),
    );
  }
}