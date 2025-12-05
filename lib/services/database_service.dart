import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';
import '../models/subject.dart';

/// Servicio para manejar la base de datos SQLite local
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  /// Obtiene la instancia de la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Inicializa la base de datos y crea las tablas
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'study_organizer.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  /// Crea las tablas necesarias
  Future<void> _createDatabase(Database db, int version) async {
    // Tabla de tareas
    await db.execute('''
      CREATE TABLE tasks(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        subject TEXT NOT NULL,
        dueDate TEXT NOT NULL,
        priority TEXT NOT NULL,
        isCompleted INTEGER DEFAULT 0
      )
    ''');

    // Tabla de materias
    await db.execute('''
      CREATE TABLE subjects(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        professor TEXT,
        schedule TEXT,
        classroom TEXT
      )
    ''');

    // Insertar materias de ejemplo
    await _insertSampleSubjects(db);
  }

  /// Inserta materias de ejemplo
  Future<void> _insertSampleSubjects(Database db) async {
    final subjects = [
      Subject(
        id: '1',
        name: 'Matemáticas',
        professor: 'Dr. Pérez',
        schedule: 'Lunes 8:00-10:00',
        classroom: 'Aula 301',
      ),
      Subject(
        id: '2',
        name: 'Literatura',
        professor: 'Dra. Gómez',
        schedule: 'Martes 10:00-12:00',
        classroom: 'Aula 205',
      ),
      Subject(
        id: '3',
        name: 'Ciencias',
        professor: 'Dr. Rodríguez',
        schedule: 'Miércoles 14:00-16:00',
        classroom: 'Laboratorio 101',
      ),
    ];

    for (var subject in subjects) {
      await db.insert('subjects', subject.toMap());
    }
  }

  // OPERACIONES PARA TAREAS

  /// Obtiene todas las tareas
  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  /// Obtiene tareas pendientes
  Future<List<Task>> getPendingTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'isCompleted = ?',
      whereArgs: [0],
    );
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  /// Agrega una nueva tarea
  Future<void> addTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  /// Actualiza una tarea existente
  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  /// Elimina una tarea
  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // OPERACIONES PARA MATERIAS

  /// Obtiene todas las materias
  Future<List<Subject>> getAllSubjects() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('subjects');
    return List.generate(maps.length, (i) => Subject.fromMap(maps[i]));
  }

  /// Agrega una nueva materia
  Future<void> addSubject(Subject subject) async {
    final db = await database;
    await db.insert('subjects', subject.toMap());
  }
}