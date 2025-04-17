import 'package:hive/hive.dart';
import 'package:tocaantask/core/utils/constants/box_constants.dart';
import 'package:tocaantask/features/home/data/models/hive_weather/hive_weather.dart';
import 'package:tocaantask/features/home/data/models/intites/weather.dart';
import 'package:tocaantask/features/home/data/repo/local_repo/weather_local_repo.dart';

class WeatherLocalRepoeImp implements WeatherLocalRepo {
  @override
  Future<Weather> getWeather(String country) async {
   var res= await Hive.box<HiveWeather>(BoxConstants.weatherBox).get("weather")!;
    return res.toWeather()!;
  }
}
