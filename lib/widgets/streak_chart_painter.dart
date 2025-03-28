import 'package:flutter/material.dart';

class StreakChartPainter extends CustomPainter {
  final List<double> streakData;

  StreakChartPainter(this.streakData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    
    for (int i = 0; i < streakData.length; i++) {
      final x = (i / (streakData.length - 1)) * size.width;
      final y = size.height - (streakData[i] * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}