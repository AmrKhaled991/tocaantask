import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:tocaantask/core/api/api_servieses.dart';
import 'package:tocaantask/core/utils/constants/box_constants.dart';
import 'package:tocaantask/features/home/data/models/hive_weather/hive_weather.dart';
import 'package:tocaantask/features/home/data/repo/remote_repo/weather_repo_remote_imp.dart';
import 'package:tocaantask/features/home/data/repo/weather_repo.dart';
import 'package:tocaantask/features/home/data/repo/weather_repo_imp.dart';

final getit = GetIt.instance;
void setupGitItLocator() {
  getit.registerSingleton<ApiServices>(ApiServices(Dio()));
  getit.registerSingleton<WeatherRepo>(
    WeatherRepoImp(weatherRepoRemote: WeatherRepoRemoteImp(getit.get())),
  );
  getit.registerSingleton<Box<HiveWeather>>(
    Hive.box<HiveWeather>(BoxConstants.weatherBox),
  );
}
