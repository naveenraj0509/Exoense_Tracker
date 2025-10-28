// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomeModelAdapter extends TypeAdapter<IncomeModel> {
  @override
  final int typeId = 1;

  @override
  IncomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IncomeModel(
      id: fields[0] as int,
      source: fields[1] as String,
      amount: fields[2] as int,
      iconCode: fields[3] as int,
      iconColorValue: fields[4] as int,
      date: fields[5] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IncomeModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.source)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.iconCode)
      ..writeByte(4)
      ..write(obj.iconColorValue)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
