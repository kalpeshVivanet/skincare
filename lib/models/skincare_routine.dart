class SkincareRoutine {
  final String? id;
  final String date;
  final Map<String, bool> steps;
  final int timestamp;

  SkincareRoutine({
    this.id,
    required this.date,
    required this.steps,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'steps': steps,
      'timestamp': timestamp,
    };
  }

  factory SkincareRoutine.fromMap(Map<String, dynamic> map) {
    return SkincareRoutine(
      id: map['id'],
      date: map['date'],
      steps: Map<String, bool>.from(map['steps']),
      timestamp: map['timestamp'],
    );
  }
}