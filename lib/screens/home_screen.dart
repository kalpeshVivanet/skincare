// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'streaks_screen.dart';
// import '../models/skincare_routine.dart';
// import '../services/firestore_service.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final FirestoreService _firestoreService = FirestoreService();

//   final Map<String, bool> _skincareTasks = {
//     'Cleanser': false,
//     'Toner': false,
//     'Moisturizer': false,
//     'Sunscreen': false,
//     'Lip Balm': false,
//   };

//   int _currentStreak = 0;

//   @override
//   void initState() {
//     super.initState();
//     _calculateStreak();
//   }

//   Future<void> _calculateStreak() async {
//     final streak = await _firestoreService.calculateStreak();
//     setState(() {
//       _currentStreak = streak;
//     });
//   }

//   Future<void> _saveDailyRoutine() async {
//     final routine = SkincareRoutine(
//       date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
//       steps: _skincareTasks,
//       timestamp: DateTime.now().millisecondsSinceEpoch,
//     );

//     try {
//       await _firestoreService.saveDailyRoutine(routine);

//       setState(() {
//         _skincareTasks.updateAll((key, value) => false);
//       });

//       await _calculateStreak();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Routine saved successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to save routine: $e')),
//       );
//     }
//   }

//   void _navigateToStreaksScreen() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => StreaksScreen(
//           currentStreak: _currentStreak,
//           streakData: [
//             1.0, 0.8, 0.6, 0.7, 0.9, 
//             0.5, 0.8, 0.7, 0.6, 0.9
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Skincare Tracker'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.timeline),
//             onPressed: _navigateToStreaksScreen,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16),
//             color: Colors.pink[50],
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Current Streak: $_currentStreak days',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Icon(
//                   Icons.whatshot,
//                   color: _currentStreak > 0 ? Colors.orange : Colors.grey,
//                 ),
//               ],
//             ),
//           ),
          
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16),
//               children: _skincareTasks.keys.map((task) {
//                 return CheckboxListTile(
//                   title: Text(task),
//                   value: _skincareTasks[task] ?? false,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       _skincareTasks[task] = value ?? false;
//                     });
//                   },
//                   activeColor: Colors.pink,
//                 );
//               }).toList(),
//             ),
//           ),

//           Padding(
//             padding: EdgeInsets.all(16),
//             child: ElevatedButton(
//               onPressed: _saveDailyRoutine,
//               child: Text('Save Routine'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(double.infinity, 50),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'streaks_screen.dart';
import '../models/skincare_routine.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  final Map<String, bool> _skincareTasks = {
    'Cleanser': false,
    'Toner': false,
    'Moisturizer': false,
    'Sunscreen': false,
    'Lip Balm': false,
  };

  int _currentStreak = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _calculateStreak();
  }

  Future<void> _calculateStreak() async {
    final streak = await _firestoreService.calculateStreak();
    setState(() {
      _currentStreak = streak;
    });
  }

  Future<void> _saveDailyRoutine() async {
    final routine = SkincareRoutine(
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      steps: _skincareTasks,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      await _firestoreService.saveDailyRoutine(routine);

      setState(() {
        _skincareTasks.updateAll((key, value) => false);
      });

      await _calculateStreak();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Routine saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save routine: $e')),
      );
    }
  }

  // Routine Tab Widget
  Widget _buildRoutineTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.pink[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Streak: $_currentStreak days',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.whatshot,
                color: _currentStreak > 0 ? Colors.orange : Colors.grey,
              ),
            ],
          ),
        ),
        
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: _skincareTasks.keys.map((task) {
              return CheckboxListTile(
                title: Text(task),
                value: _skincareTasks[task] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _skincareTasks[task] = value ?? false;
                  });
                },
                activeColor: Colors.pink,
              );
            }).toList(),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _saveDailyRoutine,
            child: Text('Save Routine'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ),
      ],
    );
  }

  // Streak Tab Widget
  Widget _buildStreakTab() {
    return StreaksScreen(
      currentStreak: _currentStreak,
      streakData: [
        1.0, 0.8, 0.6, 0.7, 0.9, 
        0.5, 0.8, 0.7, 0.6, 0.9
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skincare Tracker'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildRoutineTab(),
          _buildStreakTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Routine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Streaks',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
    );
  }
}