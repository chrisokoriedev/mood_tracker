// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodTypeAdapter extends TypeAdapter<MoodType> {
  @override
  final int typeId = 1;

  @override
  MoodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MoodType.happy;
      case 1:
        return MoodType.neutral;
      case 2:
        return MoodType.sad;
      case 3:
        return MoodType.excited;
      case 4:
        return MoodType.anxious;
      default:
        return MoodType.happy;
    }
  }

  @override
  void write(BinaryWriter writer, MoodType obj) {
    switch (obj) {
      case MoodType.happy:
        writer.writeByte(0);
        break;
      case MoodType.neutral:
        writer.writeByte(1);
        break;
      case MoodType.sad:
        writer.writeByte(2);
        break;
      case MoodType.excited:
        writer.writeByte(3);
        break;
      case MoodType.anxious:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
