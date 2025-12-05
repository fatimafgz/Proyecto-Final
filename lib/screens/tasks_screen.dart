import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_service.dart';
import 'add_task_screen.dart';
import '../widgets/task_card.dart';

/// Pantalla principal para gestionar tareas académicas
class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  /// Carga las tareas desde la base de datos
  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);
    _tasks = await _dbService.getAllTasks();
    setState(() => _isLoading = false);
  }

  /// Navega a la pantalla para agregar nueva tarea
  Future<void> _navigateToAddTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );

    if (result != null && result is Task) {
      await _dbService.addTask(result);
      await _loadTasks();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Tarea "${result.title}" guardada'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  /// Marca una tarea como completada/incompleta
  Future<void> _toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _dbService.updateTask(task);
    await _loadTasks();
  }

  /// Elimina una tarea
  Future<void> _deleteTask(String id) async {
    await _dbService.deleteTask(id);
    await _loadTasks();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🗑️ Tarea eliminada'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📚 Gestión de Tareas'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
          ? _buildEmptyState()
          : _buildTasksList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /// Construye la lista de tareas
  Widget _buildTasksList() {
    return RefreshIndicator(
      onRefresh: _loadTasks,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Dismissible(
            key: Key(task.id),
            background: Container(color: Colors.red),
            onDismissed: (direction) => _deleteTask(task.id),
            child: TaskCard(
              task: task,
              onToggleComplete: () => _toggleTaskCompletion(task),
            ),
          );
        },
      ),
    );
  }

  /// Muestra estado vacío cuando no hay tareas
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment, size: 80, color: Colors.grey[300]),
          SizedBox(height: 20),
          Text(
            'No hay tareas registradas',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Presiona el botón + para agregar tu primera tarea',
            style: TextStyle(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}