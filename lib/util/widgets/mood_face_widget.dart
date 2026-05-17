import 'package:flutter/material.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/util/painters/mood_face_painter.dart';

class MoodFaceWidget extends StatelessWidget {
  const MoodFaceWidget({
    super.key,
    required this.mood,
    this.size = 44,
    this.faceColor,
  });

  final MoodType mood;
  final double size;
  final Color? faceColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: MoodFacePainter(mood: mood, faceColor: faceColor),
      ),
    );
  }
}
