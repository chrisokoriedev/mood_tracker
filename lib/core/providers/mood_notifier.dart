import 'package:hive/hive.dart';
import 'package:mood_tracker/core/contants/app_strings.dart';
import 'package:mood_tracker/core/models/mood_entry.dart';

class MoodNotifier extends Notifier<List<MoodEntry>> {
  @override
  List<MoodEntry> build() {
    final box = Hive.box<MoodEntry>(AppStrings.hiveBox);
    final entries = box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return entries.take(7).toList();
  }
}
