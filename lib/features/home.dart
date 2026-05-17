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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: Container(
              width: 26.r,
              height: 26.r,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.85),
                shape: BoxShape.circle,
                border: Border.all(
                  color: activeMood.color.withValues(alpha: 0.5),
                ),
              ),
              child: Center(
                child: MoodFaceWidget(
                  mood: activeMood,
                  size: 16.spMin,
                  faceColor: activeMood.color.withValues(alpha: 0.32),
                ),
              ),
            ),
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              activeMood.color.withValues(alpha: 0.24),
              AppColors.white.withValues(alpha: 0.78),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              16.spMin,
              8.spMin,
              16.spMin,
              400.spMin,
            ),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 18.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: activeMood.color.withValues(alpha: 0.55),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: activeMood.color.withValues(alpha: 0.22),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KMoodText(
                        'CURRENT MOOD',
                        variant: MoodTextVariant.normal,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.7,
                          color: AppColors.black54,
                        ),
                      ),
                      10.verticalSpace,
                      MoodFaceWidget(
                        mood: activeMood,
                        size: 200.spMin,
                        faceColor: activeMood.color.withValues(alpha: 0.40),
                      ),
                      10.verticalSpace,
                      KMoodText(
                        activeMood.label,
                        variant: MoodTextVariant.header,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40.sp,
                        ),
                      ),
                      2.verticalSpace,
                      KMoodText(
                        entries.isEmpty
                            ? 'Tap a mood to start tracking.'
                            : 'Latest check-in is active.',
                        variant: MoodTextVariant.normal,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                26.verticalSpace,
                MoodSelector(
                  selectedMood: activeMood,
                  onSelect: (mood) {
                    ref.read(moodNotifierProvider.notifier).addEntry(mood);
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      bottomSheet: Column(
        spacing: 12.spMin,
        mainAxisSize: MainAxisSize.min,
        children: [
          Panel(
            activeMood: activeMood,
            entries: entries,
            child: entries.isEmpty
                ? const EmptyState()
                : Timeline(entries: entries),
          ),
        ],
      ),
    );
  }
}
