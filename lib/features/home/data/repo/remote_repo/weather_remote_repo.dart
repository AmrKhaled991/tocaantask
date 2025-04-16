import 'package:tocaantask/features/home/data/models/response/weather_respnse.dart';

abstract class WeatherRepoRemote {
  Future<WeatherResponse> getWeather(String country);
}
