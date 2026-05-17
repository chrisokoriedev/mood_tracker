import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/core/contants/app_colors.dart';
import 'package:mood_tracker/core/models/mood_entry.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/core/providers/animation_notifier.dart';
import 'package:mood_tracker/util/extension/mood_type_extensions.dart';
import 'package:mood_tracker/util/widgets/mood_face_widget.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';

class Timeline extends ConsumerWidget {
  const Timeline({super.key, required this.entries});

  final List<MoodEntry> entries;

  String _getTimeOfDay(DateTime date) {
    final hour = date.hour;
    if (hour >= 5 && hour < 12) return 'Morning ☀️';
    if (hour >= 12 && hour < 17) return 'Afternoon 🌤️';
    if (hour >= 17 && hour < 21) return 'Evening 🌙';
    return 'Night 🌟';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animatingId = ref.watch(animationNotifierProvider);
    final activeMood = entries.isNotEmpty
        ? entries.first.mood
        : MoodType.neutral;

    return SizedBox(
      height: 88.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 24.w,
            right: 24.w,
            height: 2.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    activeMood.color.withValues(alpha: 0.35),
                    activeMood.color.withValues(alpha: 0.05),
                  ],
                ),
              ),
            ),
          ),
          ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: entries.length,
            separatorBuilder: (_, _) => SizedBox(width: 10.spMin),
            itemBuilder: (context, index) {
              final entry = entries[index];
              final isAnimating = animatingId == entry.id;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                transform: isAnimating
                    ? (Matrix4.identity()
                        ..scaleByDouble(1.04, 1.04, 1.0, 1.0)
                        ..rotateZ(0.012))
                    : Matrix4.identity(),
                transformAlignment: Alignment.center,
                width: 300.spMin,
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.all(10.spMin),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.82),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: entry.mood.color.withValues(alpha: 0.45),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: entry.mood.color.withValues(alpha: 0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    MoodFaceWidget(
                      mood: entry.mood,
                      size: 40.spMin,
                      faceColor: entry.mood.color.withValues(alpha: 0.28),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KMoodText(
                                entry.mood.label,
                                variant: MoodTextVariant.normal,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: entry.mood.color.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: KMoodText(
                                  _getTimeOfDay(entry.date),
                                  variant: MoodTextVariant.small,
                                  style: TextStyle(
                                    fontSize: 8.5.spMin,
                                    fontWeight: FontWeight.w700,
                                    color: entry.mood.color.withValues(
                                      alpha: 0.85,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          4.verticalSpace,
                          KMoodText(
                            DateFormat(
                              'EEE, MMM d • h:mm a',
                            ).format(entry.date),
                            variant: MoodTextVariant.small,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.black54,
                                  fontSize: 10.spMin,
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
        ],
      ),
    );
  }
}
