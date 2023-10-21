// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetModelAdapter extends TypeAdapter<BudgetModel> {
  @override
  final int typeId = 0;

  @override
  BudgetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BudgetModel(
      CategoryName: fields[0] as String,
      BudgetAmount: fields[1] as String,
      id: fields[2] as String,
      currentAmount: fields[3] as String,
      progress: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BudgetModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.CategoryName)
      ..writeByte(1)
      ..write(obj.BudgetAmount)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.currentAmount)
      ..writeByte(4)
      ..write(obj.progress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
