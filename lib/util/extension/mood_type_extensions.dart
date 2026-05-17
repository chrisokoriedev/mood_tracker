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
}