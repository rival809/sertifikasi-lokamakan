// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_restaurant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteRestaurantAdapter extends TypeAdapter<FavoriteRestaurant> {
  @override
  final int typeId = 10;

  @override
  FavoriteRestaurant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteRestaurant(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String?,
      city: fields[3] as String?,
      address: fields[4] as String?,
      pictureId: fields[5] as String?,
      rating: fields[6] as double?,
      addedAt: fields[7] as DateTime,
      userId: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteRestaurant obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.city)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.pictureId)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.addedAt)
      ..writeByte(8)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteRestaurantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
