import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required GeolocatorPlatform geolocatorPlatform})
      : _geolocatorPlatform = geolocatorPlatform,
        super(const LocationState(LocatorState.initial));

  final GeolocatorPlatform _geolocatorPlatform;

  Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await _handlePermission();
      if (!hasPermission) {
        return null;
      }
      
      final position = await _geolocatorPlatform.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // show LocationServicesDisabledMessage
      return false;
    }
    
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Ikinci kere red edilirse UI uzerinden izin istemek gerekiyor
        return false;
      }
    }
    // Tamamen reddedilmisse sonuclari ve nasil tekrar acabilecegini
    // UI uzerinden anlatmak gerekiyor
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    // Eger buraya kadar indiyse servis acik ve gerekli izinler vardir
    return true;
  }
}
