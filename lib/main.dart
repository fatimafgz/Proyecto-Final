import 'package:flutter/material.dart';
import 'screens/navigation_screen.dart';

void main() {
  runApp(StudyOrganizerApp());
}

class StudyOrganizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Organizer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NavigationScreen(),
    );
  }
}