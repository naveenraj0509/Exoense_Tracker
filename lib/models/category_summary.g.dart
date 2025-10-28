// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategorySummaryAdapter extends TypeAdapter<CategorySummary> {
  @override
  final int typeId = 2;

  @override
  CategorySummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategorySummary(
      type: fields[0] as String,
      amount: fields[1] as int,
      percentage: fields[2] as int,
      colorValue: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CategorySummary obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.percentage)
      ..writeByte(3)
      ..write(obj.colorValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategorySummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
