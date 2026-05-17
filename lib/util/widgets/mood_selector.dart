import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/util/extension/mood_type_extensions.dart';
import 'package:mood_tracker/util/widgets/mood_face_widget.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    super.key,
    required this.onSelect,
    required this.selectedMood,
  });

  final ValueChanged<MoodType> onSelect;
  final MoodType selectedMood;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.spMin,
      runSpacing: 10.spMin,
      children: MoodType.values.map((mood) {
        final isSelected = mood == selectedMood;
        return InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => onSelect(mood),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            scale: isSelected ? 1.03 : 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              width: 96.spMin,
              padding: EdgeInsets.symmetric(
                vertical: 12.spMin,
                horizontal: 10.spMin,
              ),
              decoration: BoxDecoration(
                color: mood.color.withValues(alpha: isSelected ? 0.22 : 0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: mood.color.withValues(alpha: isSelected ? 0.85 : 0.45),
                  width: isSelected ? 1.8 : 1.2,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: mood.color.withValues(alpha: 0.30),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                children: [
                  MoodFaceWidget(
                    mood: mood,
                    size: 40.spMin,
                    faceColor: mood.color.withValues(alpha: isSelected ? 0.42 : 0.28),
                  ),
                  const SizedBox(height: 8),
                  KMoodText(
                    mood.label,
                    variant: MoodTextVariant.small,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
