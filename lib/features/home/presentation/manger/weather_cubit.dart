import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tocaantask/features/home/data/repo/weather_repo.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepo weatherRepo;

  WeatherCubit( this.weatherRepo) : super(WeatherInitial());

  Future<void> getWeather(String country) async {
    emit(WeatherLoading());
    var res = await weatherRepo.getWeather(country);
    emit(res.fold((l) => WeatherError(l.message), (r) => WeatherLoaded(r.toWeather()!)));
  }
}
