// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveWeatherAdapter extends TypeAdapter<HiveWeather> {
  @override
  final int typeId = 0;

  @override
  HiveWeather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveWeather(
      id: fields[0] as String,
      city: fields[1] as String,
      wind: fields[2] as double,
      hum: fields[3] as double,
      temp: fields[4] as double,
      desc: fields[5] as String,
      iconImage: fields[6] as String,
      localTime: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveWeather obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.wind)
      ..writeByte(3)
      ..write(obj.hum)
      ..writeByte(4)
      ..write(obj.temp)
      ..writeByte(5)
      ..write(obj.desc)
      ..writeByte(6)
      ..write(obj.iconImage)
      ..writeByte(7)
      ..write(obj.localTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveWeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
