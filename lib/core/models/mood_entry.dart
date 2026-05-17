import 'package:hive/hive.dart';
import 'package:mood_tracker/core/models/mood_type.dart';

part 'mood_entry.g.dart';

@HiveType(typeId: 0)
class MoodEntry {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final MoodType mood;
  @HiveField(2)
  final DateTime date;

  MoodEntry({required this.id, required this.mood, required this.date});
}
