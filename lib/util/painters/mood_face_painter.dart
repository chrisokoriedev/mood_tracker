import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/util/extension/mood_type_extensions.dart';

class MoodFacePainter extends CustomPainter {
  MoodFacePainter({required this.mood, this.faceColor, this.strokeColor = const Color(0xFF2F2F2F)});

  final MoodType mood;
  final Color? faceColor;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = faceColor ?? mood.color.withValues(alpha: 0.28)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.055
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final eyePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.45;

    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, strokePaint);

    switch (mood) {
      case MoodType.happy:
        _drawHappy(canvas, size, eyePaint, strokePaint);
        break;
      case MoodType.neutral:
        _drawNeutral(canvas, size, eyePaint, strokePaint);
        break;
      case MoodType.sad:
        _drawSad(canvas, size, eyePaint, strokePaint);
        break;
      case MoodType.excited:
        _drawExcited(canvas, size, eyePaint, strokePaint);
        break;
      case MoodType.anxious:
        _drawAnxious(canvas, size, eyePaint, strokePaint);
        break;
    }
  }

  void _drawHappy(Canvas canvas, Size size, Paint eyePaint, Paint strokePaint) {
    _drawBasicEyes(canvas, size, eyePaint);

    final mouthRect = Rect.fromLTRB(
      size.width * 0.25,
      size.height * 0.52,
      size.width * 0.75,
      size.height * 0.82,
    );
    canvas.drawArc(mouthRect, 0, math.pi, false, strokePaint);

    canvas.drawLine(
      Offset(size.width * 0.27, size.height * 0.26),
      Offset(size.width * 0.43, size.height * 0.23),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.57, size.height * 0.23),
      Offset(size.width * 0.73, size.height * 0.26),
      strokePaint,
    );
  }

  void _drawNeutral(Canvas canvas, Size size, Paint eyePaint, Paint strokePaint) {
    _drawBasicEyes(canvas, size, eyePaint);

    canvas.drawLine(
      Offset(size.width * 0.30, size.height * 0.66),
      Offset(size.width * 0.70, size.height * 0.66),
      strokePaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.27, size.height * 0.25),
      Offset(size.width * 0.43, size.height * 0.25),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.57, size.height * 0.25),
      Offset(size.width * 0.73, size.height * 0.25),
      strokePaint,
    );
  }

  void _drawSad(Canvas canvas, Size size, Paint eyePaint, Paint strokePaint) {
    _drawBasicEyes(canvas, size, eyePaint);

    final mouthRect = Rect.fromLTRB(
      size.width * 0.25,
      size.height * 0.58,
      size.width * 0.75,
      size.height * 0.86,
    );
    canvas.drawArc(mouthRect, math.pi, math.pi, false, strokePaint);

    canvas.drawLine(
      Offset(size.width * 0.27, size.height * 0.25),
      Offset(size.width * 0.43, size.height * 0.30),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.57, size.height * 0.30),
      Offset(size.width * 0.73, size.height * 0.25),
      strokePaint,
    );
  }

  void _drawExcited(Canvas canvas, Size size, Paint eyePaint, Paint strokePaint) {
    _drawStarEye(canvas, size, Offset(size.width * 0.35, size.height * 0.38), eyePaint);
    _drawStarEye(canvas, size, Offset(size.width * 0.65, size.height * 0.38), eyePaint);

    final mouthRect = Rect.fromLTRB(
      size.width * 0.20,
      size.height * 0.50,
      size.width * 0.80,
      size.height * 0.84,
    );
    canvas.drawArc(mouthRect, 0, math.pi, false, strokePaint);

    canvas.drawLine(
      Offset(size.width * 0.23, size.height * 0.24),
      Offset(size.width * 0.39, size.height * 0.20),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.61, size.height * 0.20),
      Offset(size.width * 0.77, size.height * 0.24),
      strokePaint,
    );
  }

  void _drawAnxious(Canvas canvas, Size size, Paint eyePaint, Paint strokePaint) {
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.38),
      size.width * 0.08,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.38),
      size.width * 0.08,
      eyePaint,
    );

    final path = Path()..moveTo(size.width * 0.25, size.height * 0.67);
    path.quadraticBezierTo(
      size.width * 0.375,
      size.height * 0.57,
      size.width * 0.50,
      size.height * 0.67,
    );
    path.quadraticBezierTo(
      size.width * 0.625,
      size.height * 0.77,
      size.width * 0.75,
      size.height * 0.67,
    );
    canvas.drawPath(path, strokePaint);

    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.29),
      Offset(size.width * 0.43, size.height * 0.23),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.57, size.height * 0.23),
      Offset(size.width * 0.75, size.height * 0.29),
      strokePaint,
    );
  }

  void _drawBasicEyes(Canvas canvas, Size size, Paint eyePaint) {
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.38),
      size.width * 0.07,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.38),
      size.width * 0.07,
      eyePaint,
    );
  }

  void _drawStarEye(Canvas canvas, Size size, Offset center, Paint paint) {
    final outer = size.width * 0.085;
    final inner = outer * 0.45;
    final path = Path();

    for (var i = 0; i < 10; i++) {
      final angle = (math.pi / 5) * i - math.pi / 2;
      final radius = i.isEven ? outer : inner;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MoodFacePainter oldDelegate) {
    return oldDelegate.mood != mood ||
        oldDelegate.faceColor != faceColor ||
        oldDelegate.strokeColor != strokeColor;
  }
}
