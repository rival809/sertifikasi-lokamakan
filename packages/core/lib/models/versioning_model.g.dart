// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versioning_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VersioningModelAdapter extends TypeAdapter<VersioningModel> {
  @override
  final int typeId = 41;

  @override
  VersioningModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VersioningModel(
      code: fields[0] as String?,
      success: fields[1] as bool?,
      data: fields[2] as DataVersioning?,
      message: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VersioningModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.success)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VersioningModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataVersioningAdapter extends TypeAdapter<DataVersioning> {
  @override
  final int typeId = 42;

  @override
  DataVersioning read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataVersioning(
      versionIdVersion: fields[0] as String?,
      versionDatetimeVersion: fields[1] as String?,
      versionTypeVersion: fields[2] as String?,
      versionLinkUrlVersion: fields[3] as String?,
      versionKet1Version: fields[4] as String?,
      versionKet2Version: fields[5] as String?,
      versionKet3Version: fields[6] as String?,
      versionActiveVersion: fields[7] as String?,
      versionVerVersion: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataVersioning obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.versionIdVersion)
      ..writeByte(1)
      ..write(obj.versionDatetimeVersion)
      ..writeByte(2)
      ..write(obj.versionTypeVersion)
      ..writeByte(3)
      ..write(obj.versionLinkUrlVersion)
      ..writeByte(4)
      ..write(obj.versionKet1Version)
      ..writeByte(5)
      ..write(obj.versionKet2Version)
      ..writeByte(6)
      ..write(obj.versionKet3Version)
      ..writeByte(7)
      ..write(obj.versionActiveVersion)
      ..writeByte(8)
      ..write(obj.versionVerVersion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataVersioningAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
