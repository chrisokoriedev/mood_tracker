import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/core/providers/mood_notifier.dart';
import 'package:mood_tracker/util/extension/mood_type_extensions.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';

class MoodSelector extends ConsumerWidget {
  const MoodSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 10.spMin,
      runSpacing: 10.spMin,
      children: MoodType.values.map((mood) {
        return InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => ref.read(moodNotifierProvider.notifier).addEntry(mood),
          child: Container(
            width: 96.spMin,
            padding: EdgeInsets.symmetric(
              vertical: 12.spMin,
              horizontal: 10.spMin,
            ),
            decoration: BoxDecoration(
              color: mood.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: mood.color.withValues(alpha: 0.45)),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: mood.color.withValues(alpha: 0.2),
                  child: KMoodText(
                    mood.initial,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                KMoodText(
                  mood.label,
                  variant: MoodTextVariant.small,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
