import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tracker/core/contants/app_strings.dart';
import 'package:mood_tracker/util/widgets/empty_state.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: KMoodText(AppStrings.home, variant: MoodTextVariant.header),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.spMin),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6.sp,
              children: [
                const KMoodText(
                  'How are you feeling today?',
                  variant: MoodTextVariant.header,
                ),
                KMoodText(
                  'Pick one mood to log your current state.',
                  variant: MoodTextVariant.small,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),

                const EmptyState(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
