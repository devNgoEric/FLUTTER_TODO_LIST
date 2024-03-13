// ignore_for_file: file_names

class Task {
  final String id;
  final String taskName;
  final String taskDescription;
  final bool isComplete;

  const Task({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isComplete,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'taskName': String taskName,
        'taskDescription': String taskDescription,
        'isComplete': bool isComplete,
      } =>
        Task(
          id: id,
          taskName: taskName,
          taskDescription: taskDescription,
          isComplete: isComplete,
        ),
      _ => throw const FormatException('Failed to load task.'),
    };
  }
}