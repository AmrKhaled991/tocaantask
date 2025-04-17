import 'package:equatable/equatable.dart';
import 'package:tocaantask/features/home/data/models/intites/weather.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final Weather weather;
  WeatherSuccess(this.weather);
  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;
  final Weather? weather;
  WeatherError(this.message, this.weather);
  @override
  List<Object?> get props => [message];
}
