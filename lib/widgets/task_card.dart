import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleComplete;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onToggleComplete,
  }) : super(key: key);

  /// Métodoo para obtener color según prioridad
  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'alta': return Colors.red;
      case 'media': return Colors.orange;
      case 'baja': return Colors.green;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) => onToggleComplete(),
                ),
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isCompleted
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(task.priority),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    task.priority,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            if (task.description.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(left: 40, bottom: 8),
                child: Text(
                  task.description,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Icon(Icons.book, size: 14, color: Colors.blue),
                  SizedBox(width: 4),
                  Text(
                    task.subject,
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}