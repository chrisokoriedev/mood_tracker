import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/util/extension/mood_type_extensions.dart';
import 'package:mood_tracker/util/widgets/mood_face_widget.dart';

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
    return SizedBox(
      height: 80.h,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 16.w,
            children: MoodType.values.map((mood) {
              final isSelected = mood == selectedMood;
              return InkWell(
                customBorder: const CircleBorder(),
                onTap: () => onSelect(mood),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeOutBack,
                  scale: isSelected ? 1.15 : 1.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    width: 50.r,
                    height: 50.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? mood.color : const Color(0xFFF1F5F9),
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 3.r,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: mood.color.withValues(alpha: 0.35),
                                blurRadius: 16,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: MoodFaceWidget(
                        mood: mood,
                        size: 36.sp,
                        faceColor: Colors.transparent,
                        strokeColor: isSelected
                            ? const Color(0xFF0F172A)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
