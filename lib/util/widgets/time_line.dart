import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/core/contants/app_colors.dart';
import 'package:mood_tracker/core/models/mood_entry.dart';
import 'package:mood_tracker/core/providers/animation_notifier.dart';
import 'package:mood_tracker/util/extension/mood_type_extensions.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';

class Timeline extends ConsumerWidget {
  const Timeline({super.key, required this.entries});

  final List<MoodEntry> entries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animatingId = ref.watch(animationNotifierProvider);

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final entry = entries[index];
        final isAnimating = animatingId == entry.id;

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            ref
                .read(animationNotifierProvider.notifier)
                .triggerAnimation(entry.id);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            width: 154,
            transform: isAnimating
                ? (Matrix4.identity()
                    ..scaleByDouble(1.06, 1.06, 1.0, 1.0)
                    ..rotateZ(0.02))
                : Matrix4.identity(),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: entry.mood.color, width: 1.8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                  color: entry.mood.color.withValues(alpha: 0.16),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 10.spMin,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor: entry.mood.color.withValues(alpha: 0.2),
                  child: KMoodText(
                    entry.mood.initial,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),

                KMoodText(
                  entry.mood.label,
                  variant: MoodTextVariant.normal,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                KMoodText(
                  DateFormat('EEE, d MMM').format(entry.date),
                  variant: MoodTextVariant.small,
                  style: const TextStyle(color: AppColors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
