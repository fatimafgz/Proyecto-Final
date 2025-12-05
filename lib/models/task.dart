/// Modelo de datos para representar una tarea académica
class Task {
  String id;
  String title;
  String description;
  String subject;
  DateTime dueDate;
  String priority; // 'Alta', 'Media', 'Baja'
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });

  /// Convierte el objeto a Map para almacenamiento
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subject': subject,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  /// Crea un objeto Task desde un Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      subject: map['subject'],
      dueDate: DateTime.parse(map['dueDate']),
      priority: map['priority'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}