import 'package:flutter/material.dart';
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
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withValues(alpha: 0.06),
            ),
            child: const Icon(Icons.mood_outlined, color: Colors.black54),
          ),
          const SizedBox(height: 12),
          const KMoodText(
            AppStrings.emptyStateTitle,
            variant: MoodTextVariant.normal,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
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
