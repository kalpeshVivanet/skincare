import 'package:flutter/material.dart';
import '../widgets/streak_chart_painter.dart';

class StreaksScreen extends StatelessWidget {
  final int currentStreak;
  final List<double> streakData;

  StreaksScreen({
    required this.currentStreak, 
    required this.streakData
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Streaks'),
        backgroundColor: Colors.pink[50],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Goal: 3 streak days",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Streak Days",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink[700],
                        ),
                      ),
                      Text(
                        "$currentStreak",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[900],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Daily Streak",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$currentStreak",
              style: TextStyle(
                fontSize: 24,
                color: Colors.pink[700],
              ),
            ),

            SizedBox(height: 20),

            Container(
              height: 200,
              width: double.infinity,
              child: CustomPaint(
                painter: StreakChartPainter(streakData),
              ),
            ),

            Spacer(),

            Center(
              child: Text(
                "Keep it up! You're on a roll.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.pink[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}