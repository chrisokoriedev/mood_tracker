import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mood_tracker/core/contants/app_strings.dart';
import 'package:mood_tracker/core/models/mood_entry.dart';
import 'package:mood_tracker/core/models/mood_type.dart';

class MoodNotifier extends Notifier<List<MoodEntry>> {
  @override
  List<MoodEntry> build() {
    final box = Hive.box<MoodEntry>(AppStrings.hiveBox);
    final entries = box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return entries.take(7).toList();
  }

  Future<void> addEntry(MoodType mood) async {
    final box = Hive.box<MoodEntry>(AppStrings.hiveBox);

    final entry = MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      mood: mood,
      date: DateTime.now(),
    );

    await box.add(entry);

    final entries = box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    state = entries.take(7).toList();
  }
}

final moodNotifierProvider = NotifierProvider<MoodNotifier, List<MoodEntry>>(
  MoodNotifier.new,
);
