import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tocaantask/features/home/presentation/manger/location_cubit/location_cubit_state.dart';

class LocationCubit extends Cubit<LocationState> {
  Position? _cachedPosition;

  LocationCubit() : super(LocationInitial());

  Future<void> getLocation(bool forceRefresh) async {
    if (_cachedPosition != null && !forceRefresh) {
      emit(LocationLoaded(_cachedPosition!));
      return;
    }

    emit(LocationLoading());

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationError('Location services are disabled.'));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(LocationError('Location permissions are denied.'));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(LocationError('Location permissions are permanently denied.'));
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _cachedPosition = pos;
      emit(LocationSuccess(pos));
    } catch (e) {
      emit(LocationError('Failed to get location: $e'));
    }
  }
}
