// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todoModels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      titolo: fields[0] as String,
      sottotitolo: fields[1] as String,
      data: fields[2] as DateTime,
      completato: fields[3] as bool,
      id: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.titolo)
      ..writeByte(1)
      ..write(obj.sottotitolo)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.completato)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
