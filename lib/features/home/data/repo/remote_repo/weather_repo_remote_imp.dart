import 'package:hive/hive.dart';
import 'package:tocaantask/core/api/api_servieses.dart';
import 'package:tocaantask/core/utils/constants/box_constants.dart';
import 'package:tocaantask/features/home/data/models/hive_weather/hive_weather.dart';
import 'package:tocaantask/features/home/data/models/response/weather_respnse.dart';
import 'package:tocaantask/features/home/data/repo/remote_repo/weather_remote_repo.dart';

class WeatherRepoRemoteImp implements WeatherRepoRemote {
  ApiServices apiServices;
  WeatherRepoRemoteImp(this.apiServices);
  @override
  Future<WeatherResponse> getWeather(String country) async {
    var res = await apiServices.getWeather(country);
    Hive.box<HiveWeather>(BoxConstants.weatherBox).put("weather", res.toHiveWeather()!);
    return res;
  }
}
