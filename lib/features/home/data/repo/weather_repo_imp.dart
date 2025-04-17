import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tocaantask/core/errors/cust0m_errors.dart';
import 'package:tocaantask/core/utils/helpers/getItLocator.dart';
import 'package:tocaantask/features/home/data/models/hive_weather/hive_weather.dart';
import 'package:tocaantask/features/home/data/models/response/weather_respnse.dart';
import 'package:tocaantask/features/home/data/repo/remote_repo/weather_remote_repo.dart';
import 'package:tocaantask/features/home/data/repo/weather_repo.dart';

class WeatherRepoImp extends WeatherRepo {
  WeatherRepoRemote weatherRepoRemote;
  WeatherRepoImp({required this.weatherRepoRemote});
  @override
  Future<Either<Failure, WeatherResponse>> getWeather(String country) async {
    try {
      var res = await weatherRepoRemote.getWeather(country.trim());
      getit<Box<HiveWeather>>().put("weather", res.toHiveWeather()!);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      }
      return left(ServerError('sorry for this erorre,please try again later'));
    }
  }
}
