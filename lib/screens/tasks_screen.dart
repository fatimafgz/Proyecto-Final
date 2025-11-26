import 'package:flutter/material.dart';

import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Map<String, dynamic>> tasks = [
    {
      'id': '1',
      'title': 'Proyecto de Matemáticas',
      'subject': 'Matemáticas',
      'dueDate': '2024-12-01',
      'priority': 'Alta',
      'completed': false
    },
    {
      'id': '2',
      'title': 'Ensayo de Literatura',
      'subject': 'Literatura',
      'dueDate': '2024-12-05',
      'priority': 'Media',
      'completed': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Tareas'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: tasks.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No hay tareas',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              'Presiona el botón + para agregar una nueva tarea',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return _buildTaskCard(task);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTask(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color getPriorityColor(String priority) {
      switch (priority) {
        case 'Alta': return Colors.red;
        case 'Media': return Colors.orange;
        case 'Baja': return Colors.green;
        default: return Colors.grey;
      }
    }

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Checkbox(
              value: task['completed'],
              onChanged: (value) {
                setState(() {
                  task['completed'] = value;
                });
              },
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: task['completed']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.book, size: 14, color: Colors.blue),
                      SizedBox(width: 4),
                      Text(
                        task['subject'],
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                      Spacer(),
                      Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        task['dueDate'],
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: getPriorityColor(task['priority']),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                task['priority'],
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddTask(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        tasks.add({
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'title': result['title'],
          'subject': result['subject'],
          'dueDate': result['dueDate'],
          'priority': result['priority'],
          'completed': false,
        });
      });

      // Mostrar mensaje de confirmación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Tarea "${result['title']}" guardada exitosamente!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}