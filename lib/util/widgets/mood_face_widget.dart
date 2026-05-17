import 'package:flutter/material.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/util/painters/mood_face_painter.dart';

class MoodFaceWidget extends StatelessWidget {
  const MoodFaceWidget({
    super.key,
    required this.mood,
    this.size = 44,
    this.faceColor,
    this.strokeColor,
  });

  final MoodType mood;
  final double size;
  final Color? faceColor;
  final Color? strokeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: MoodFacePainter(
          mood: mood,
          faceColor: faceColor,
          strokeColor: strokeColor ?? const Color(0xFF2F2F2F),
        ),
      ),
    );
  }
}
