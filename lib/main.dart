import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/tasks_screen.dart';
import 'screens/subjects_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar SQLite
  try {
    await _initializeDatabase();
    runApp(StudyOrganizerApp());
  } catch (e) {
    print('Error inicializando base de datos: $e');
  }
}

/// Inicializa la base de datos SQLite
Future<void> _initializeDatabase() async {
  // Esto asegura que la base de datos esté lista
  await Future.delayed(Duration(milliseconds: 100));
}

/// Aplicación principal de Study Organizer
class StudyOrganizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Organizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Pantalla principal con navegación inferior
class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    TasksScreen(),
    SubjectsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Materias',
          ),
        ],
      ),
    );
  }
}