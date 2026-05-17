import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tracker/core/contants/app_colors.dart';
import 'package:mood_tracker/core/models/mood_entry.dart';
import 'package:mood_tracker/core/models/mood_type.dart';
import 'package:mood_tracker/util/extension/mood_type_extensions.dart';
import 'package:mood_tracker/util/widgets/mood_app_text.dart';

class Panel extends StatelessWidget {
  const Panel({
    super.key,
    required this.child,
    this.activeMood,
    this.entries,
    this.removeHeader = false,
  });

  final Widget child;
  final MoodType? activeMood;
  final List<MoodEntry>? entries;
  final bool? removeHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12.sp, right: 12.sp, top: 12.sp),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            offset: const Offset(0, 8),
            color: AppColors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (removeHeader != true)
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
                    color:
                        activeMood?.color.withValues(alpha: 0.18) ??
                        AppColors.black.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color:
                          activeMood?.color.withValues(alpha: 0.45) ??
                          AppColors.black.withValues(alpha: 0.45),
                    ),
                  ),
                  child: KMoodText(
                    '${entries?.length ?? 0}/7',
                    variant: MoodTextVariant.small,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          child,
        ],
      ),
    );
  }
}
