import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tocaantask/features/home/data/models/response/weather_respnse.dart';

class ApiServices {
  static const url = "https://api.weatherapi.com/v1/current.json";
  static const apiKey = "5117ca2d9eee44cbb00104423251604 ";
  final _controller = StreamController<WeatherResponse>.broadcast();


  ApiServices(this.dio);
  Dio dio;
  //
  Future<WeatherResponse> getWeather(String country) async {
    final response = await dio.get(
      url,
      queryParameters: {"key": apiKey, "q": country},
    );

    final res = WeatherResponse.fromJson(response.data);
    return res;
  }
}
