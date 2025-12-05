/// Modelo de datos para representar una materia académica
class Subject {
  String id;
  String name;
  String professor;
  String schedule;
  String classroom;

  Subject({
    required this.id,
    required this.name,
    required this.professor,
    required this.schedule,
    required this.classroom,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'professor': professor,
      'schedule': schedule,
      'classroom': classroom,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'],
      name: map['name'],
      professor: map['professor'],
      schedule: map['schedule'],
      classroom: map['classroom'],
    );
  }
}