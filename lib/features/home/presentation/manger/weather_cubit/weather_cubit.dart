import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tocaantask/core/utils/constants/box_constants.dart';
import 'package:tocaantask/core/utils/helpers/getItLocator.dart';
import 'package:tocaantask/features/home/data/models/hive_weather/hive_weather.dart';
import 'package:tocaantask/features/home/data/repo/weather_repo.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit/weather_cubit_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepo weatherRepo;

  WeatherCubit(this.weatherRepo) : super(WeatherInitial());

  Future<void> getWeather(String country) async {
    emit(WeatherLoading());
    var res = await weatherRepo.getWeather(country);
    emit(
      res.fold(
        (l) {
          return WeatherError(
            l.message,
            getit<Box<HiveWeather>>().get("weather")?.toWeather(),
          );
        },
        (r) {
         
          return WeatherSuccess(r.toWeather()!);
        },
      ),
    );
  }
}
