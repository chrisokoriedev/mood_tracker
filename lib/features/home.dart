import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tracker/core/contants/app_colors.dart';
import 'package:mood_tracker/core/contants/app_strings.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/core/providers/mood_notifier.dart';
import 'package:mood_tracker/util/extension/mood_type_extensions.dart';
import 'package:mood_tracker/util/widgets/empty_state.dart';
import 'package:mood_tracker/util/widgets/mood_face_widget.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';
import 'package:mood_tracker/util/widgets/mood_selector.dart';
import 'package:mood_tracker/util/widgets/panel.dart';
import 'package:mood_tracker/util/widgets/time_line.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(moodNotifierProvider);
    final activeMood = entries.isEmpty ? MoodType.neutral : entries.first.mood;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const KMoodText(
          AppStrings.appName,
          variant: MoodTextVariant.header,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              activeMood.color.withValues(alpha: 0.28),
              activeMood.color.withValues(alpha: 0.08),
              AppColors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.spMin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const KMoodText(
                  AppStrings.moodEntryTitle,
                  variant: MoodTextVariant.header,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                6.verticalSpace,
                KMoodText(
                  'Pick one mood to paint your day.',
                  variant: MoodTextVariant.small,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.black54),
                ),
                14.verticalSpace,
                AnimatedContainer(
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOut,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        activeMood.color.withValues(alpha: 0.30),
                        activeMood.color.withValues(alpha: 0.14),
                      ],
                    ),
                    border: Border.all(color: activeMood.color.withValues(alpha: 0.55)),
                    boxShadow: [
                      BoxShadow(
                        color: activeMood.color.withValues(alpha: 0.22),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      MoodFaceWidget(
                        mood: activeMood,
                        size: 78.spMin,
                        faceColor: activeMood.color.withValues(alpha: 0.40),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const KMoodText(
                              'Current Mood',
                              variant: MoodTextVariant.small,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            4.verticalSpace,
                            KMoodText(
                              activeMood.label,
                              variant: MoodTextVariant.header,
                              style: const TextStyle(fontWeight: FontWeight.w800),
                            ),
                            2.verticalSpace,
                            KMoodText(
                              entries.isEmpty
                                  ? 'Tap a mood to start tracking.'
                                  : 'Latest check-in is active.',
                              variant: MoodTextVariant.small,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                Panel(
                  child: MoodSelector(
                    selectedMood: activeMood,
                    onSelect: (mood) {
                      ref.read(moodNotifierProvider.notifier).addEntry(mood);
                    },
                  ),
                ),
                18.verticalSpace,
                Row(
                  children: [
                    const KMoodText(
                      'Last 7 moods',
                      variant: MoodTextVariant.normal,
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.spMin,
                        vertical: 6.spMin,
                      ),
                      decoration: BoxDecoration(
                        color: activeMood.color.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: activeMood.color.withValues(alpha: 0.45)),
                      ),
                      child: KMoodText(
                        '${entries.length}/7',
                        variant: MoodTextVariant.small,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                Panel(
                  child: entries.isEmpty
                      ? const EmptyState()
                      : Timeline(entries: entries),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
