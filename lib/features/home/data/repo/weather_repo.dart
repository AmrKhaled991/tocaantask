
import 'package:dartz/dartz.dart';
import 'package:tocaantask/core/errors/cust0m_errors.dart';
import 'package:tocaantask/features/home/data/models/response/weather_respnse.dart';

abstract class WeatherRepo {
  Future<Either<Failure, WeatherResponse>> getWeather(String country);
  
}