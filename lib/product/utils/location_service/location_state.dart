part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState(this.locatorState);
  final LocatorState locatorState;

  @override
  List<Object> get props => [locatorState];

  @override
  String toString() => 'LocationState(locatorState: ${locatorState.name})';

  LocationState copyWith({
    LocatorState? locatorState,
  }) {
    return LocationState(
      locatorState ?? this.locatorState,
    );
  }
}

enum LocatorState {
  initial,
  askPermission,
  permissionGranted,
  permissionDenied,
  permissionDeniedTwice,
  permissionDeniedForever,
  serviceActive,
  serviceDeactive,
  loading
}
