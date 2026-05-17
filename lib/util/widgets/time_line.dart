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

    return Column(
      children: entries.map((entry) {
        final isAnimating = animatingId == entry.id;
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
          padding: EdgeInsets.all(12.spMin),
          decoration: BoxDecoration(
            color: entry.mood.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: entry.mood.color, width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: entry.mood.color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: KMoodText(
                    entry.mood.initial,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KMoodText(
                    entry.mood.label,
                    variant: MoodTextVariant.normal,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  KMoodText(
                    DateFormat('MMM d, yyyy - h:mm a').format(entry.date),
                    variant: MoodTextVariant.small,
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black54),
                  ),
                ],
              ),
              const Spacer(),
              if (isAnimating)
                SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
