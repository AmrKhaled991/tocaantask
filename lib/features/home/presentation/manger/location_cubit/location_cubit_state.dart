import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState {
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final Position position;

  LocationSuccess(this.position);

  @override
  List<Object?> get props => [position];
}

class LocationLoaded extends LocationState {
  final Position position;

  LocationLoaded(this.position);

  @override
  List<Object?> get props => [position];

  get message => null;
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);

  @override
  List<Object?> get props => [message];
}
