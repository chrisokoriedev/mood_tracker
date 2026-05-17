import 'package:flutter/material.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const EmptyState()],
      ),
    );
  }
}
