import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/core/contants/app_colors.dart';
import 'package:mood_tracker/core/models/mood_entry.dart';
import 'package:mood_tracker/core/providers/animation_notifier.dart';
import 'package:mood_tracker/util/extension/mood_type_extensions.dart';
import 'package:mood_tracker/util/widgets/mood_face_widget.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';

class Timeline extends ConsumerWidget {
  const Timeline({super.key, required this.entries});

  final List<MoodEntry> entries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animatingId = ref.watch(animationNotifierProvider);

    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length,
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final entry = entries[index];
          final isAnimating = animatingId == entry.id;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            transform: isAnimating
                ? (Matrix4.identity()
                    ..scaleByDouble(1.05, 1.05, 1.0, 1.0)
                    ..rotateZ(0.015))
                : Matrix4.identity(),
            transformAlignment: Alignment.center,
            width: 222.w,
            margin: EdgeInsets.symmetric(vertical: 6.h),
            padding: EdgeInsets.all(12.spMin),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  entry.mood.color.withValues(alpha: 0.18),
                  entry.mood.color.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: entry.mood.color.withValues(alpha: 0.65),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: entry.mood.color.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                MoodFaceWidget(
                  mood: entry.mood,
                  size: 48.spMin,
                  faceColor: entry.mood.color.withValues(alpha: 0.34),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KMoodText(
                        entry.mood.label,
                        variant: MoodTextVariant.normal,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                        ),
                      ),
                      6.verticalSpace,
                      KMoodText(
                        DateFormat('EEE, MMM d • h:mm a').format(entry.date),
                        variant: MoodTextVariant.small,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
