import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tracker/core/contants/app_strings.dart';
import 'package:mood_tracker/core/providers/mood_notifier.dart';
import 'package:mood_tracker/util/widgets/empty_state.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';
import 'package:mood_tracker/util/widgets/mood_selector.dart';
import 'package:mood_tracker/util/widgets/panel.dart';
import 'package:mood_tracker/util/widgets/time_line.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(moodNotifierProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const KMoodText(
          AppStrings.appName,
          variant: MoodTextVariant.header,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.spMin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KMoodText(
                AppStrings.moodEntryTitle,
                variant: MoodTextVariant.header,
              ),
              6.verticalSpace,
              KMoodText(
                'Pick one mood to log your current state.',
                variant: MoodTextVariant.small,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                ),
              ),
              14.verticalSpace,
              const Panel(child: MoodSelector()),
              18.verticalSpace,
              Row(
                children: [
                  const KMoodText(
                    'Last 7 moods',
                    variant: MoodTextVariant.normal,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.spMin,
                      vertical: 6.spMin,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: KMoodText(
                      '${entries.length}/7',
                      variant: MoodTextVariant.small,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              Expanded(
                child: Panel(
                  child: entries.isEmpty
                      ? const EmptyState()
                      : Timeline(entries: entries),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}