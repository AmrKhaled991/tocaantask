// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:tocaantask/features/home/data/models/intites/weather.dart';

part 'hive_weather.g.dart';

@HiveType(typeId: 0) // تأكد من تغيير typeId إذا كان في أكثر من model
class HiveWeather extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String city;

  @HiveField(2)
  final double wind;

  @HiveField(3)
  final double hum;

  @HiveField(4)
  final double temp;

  @HiveField(5)
  final String desc;

  @HiveField(6)
  final String iconImage;

  @HiveField(7)
  final String localTime;

  HiveWeather({
    required this.id,
    required this.city,
    required this.wind,
    required this.hum,
    required this.temp,
    required this.desc,
    required this.iconImage,
    required this.localTime,
  });

  Weather? toWeather() {
    return Weather(
      id: id,
      city: city,
      wind: wind,
      hum: hum,
      temp: temp,
      desc: desc,
      iconImage: iconImage,
      localTime: localTime,
    );
  }
}
