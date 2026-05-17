import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tracker/core/contants/app_strings.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withValues(alpha: 0.06),
            ),
            child: const Icon(Icons.mood_outlined, color: Colors.black54),
          ),
          12.verticalSpace,
          const KMoodText(
            AppStrings.emptyStateTitle,
            variant: MoodTextVariant.normal,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          4.verticalSpace,
          KMoodText(
            AppStrings.emptyStateMessage,
            variant: MoodTextVariant.small,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
