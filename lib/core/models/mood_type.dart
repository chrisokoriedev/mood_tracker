import 'package:hive/hive.dart';
part 'mood_type.g.dart';

@HiveType(typeId: 1)
enum MoodType {
  @HiveField(0)
  happy,
  @HiveField(1)
  neutral,
  @HiveField(2)
  sad,
  @HiveField(3)
  excited,
  @HiveField(4)
  anxious,
}
