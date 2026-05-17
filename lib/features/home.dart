import 'package:flutter/material.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0, 
        title: KMoodText('Home', variant: MoodTextVariant.header)),
    );
  }
}
