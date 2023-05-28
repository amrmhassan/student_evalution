// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_accounts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedAccountModelAdapter extends TypeAdapter<SavedAccountModel> {
  @override
  final int typeId = 7;

  @override
  SavedAccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedAccountModel(
      userModel: fields[0] as UserModel,
      password: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedAccountModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userModel)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedAccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
