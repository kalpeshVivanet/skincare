import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/skincare_routine.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveDailyRoutine(SkincareRoutine routine) async {
    try {
      await _firestore.collection('skincare_routines').add(routine.toMap());
    } catch (e) {
      print('Error saving routine: $e');
      rethrow;
    }
  }

  Future<int> calculateStreak() async {
    final now = DateTime.now();
    final routinesQuery = await _firestore
        .collection('skincare_routines')
        .where('date', isGreaterThan: DateFormat('yyyy-MM-dd')
            .format(now.subtract(Duration(days: 30))))
        .orderBy('date', descending: true)
        .get();

    int streak = 0;
    DateTime? lastDate;

    for (var doc in routinesQuery.docs) {
      final routine = SkincareRoutine.fromMap(doc.data());
      final routineDate = DateTime.parse(routine.date);

      final isFullRoutine = routine.steps.values.every((completed) => completed);

      if (isFullRoutine) {
        if (lastDate == null) {
          streak++;
          lastDate = routineDate;
        } else {
          final dayDifference = lastDate.difference(routineDate).inDays;
          if (dayDifference == 1) {
            streak++;
            lastDate = routineDate;
          } else {
            break;
          }
        }
      }
    }

    return streak;
  }
}