import 'dart:ui';

import 'package:mood_tracker/core/contants/app_colors.dart';
import 'package:mood_tracker/core/contants/app_strings.dart';
import 'package:mood_tracker/core/models/mood_type.dart';

extension MoodTypeX on MoodType {
  String get label {
    switch (this) {
      case MoodType.happy:
        return AppStrings.happyLabel;
      case MoodType.neutral:
        return AppStrings.neutralLabel;
      case MoodType.sad:
        return AppStrings.sadLabel;
      case MoodType.excited:
        return AppStrings.excitedLabel;
      case MoodType.anxious:
        return AppStrings.anxiousLabel;
    }
  }

  String get initial {
    switch (this) {
      case MoodType.happy:
        return AppStrings.happyInitial;
      case MoodType.neutral:
        return AppStrings.neutralInitial;
      case MoodType.sad:
        return AppStrings.sadInitial;
      case MoodType.excited:
        return AppStrings.excitedInitial;
      case MoodType.anxious:
        return AppStrings.anxiousInitial;
    }
  }

  Color get color {
    switch (this) {
      case MoodType.happy:
        return AppColors.happy;
      case MoodType.neutral:
        return AppColors.neutral;
      case MoodType.sad:
        return AppColors.sad;
      case MoodType.excited:
        return AppColors.excited;
      case MoodType.anxious:
        return AppColors.anxious;
    }
  }

  String get supportiveMessage {
    switch (this) {
      case MoodType.happy:
        return 'Keep riding this wave of positivity! Share a smile today. 😊';
      case MoodType.neutral:
        return 'A calm day is a beautiful day. Take it easy and just be. 🍃';
      case MoodType.sad:
        return "It's completely okay to not be okay. Be gentle with yourself. 🤍";
      case MoodType.excited:
        return "Love this vibrant energy! What's making you sparkle today? ✨";
      case MoodType.anxious:
        return "Take a slow, deep breath in... and let it go. You've got this. 🫂";
    }
  }
}