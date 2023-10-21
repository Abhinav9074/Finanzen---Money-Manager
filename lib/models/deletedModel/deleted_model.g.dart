// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeletedModelAdapter extends TypeAdapter<DeletedModel> {
  @override
  final int typeId = 4;

  @override
  DeletedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeletedModel(
      id: fields[0] as String,
      purpose: fields[1] as String,
      amount: fields[2] as String,
      date: fields[3] as DateTime,
      dateSum: fields[4] as int,
      recieptImage: fields[5] as String?,
      type: fields[6] as CategoryType,
      categorySubType: fields[7] as String,
      deleteDate: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DeletedModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.purpose)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.dateSum)
      ..writeByte(5)
      ..write(obj.recieptImage)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.categorySubType)
      ..writeByte(8)
      ..write(obj.deleteDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeletedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
