import 'package:tocaantask/features/home/data/models/intites/weather.dart';

abstract class WeatherLocalRepo {
  Future<Weather> getWeather(String country);
}
