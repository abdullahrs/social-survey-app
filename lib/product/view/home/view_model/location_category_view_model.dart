import 'package:anket/product/models/survey.dart';
import 'package:anket/product/services/data_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class LocationCategoryCubit extends Cubit<LocationCategoryState> {
  LocationCategoryCubit() : super(const LocationCategoryState());

  Future<List<Survey>> getLocationSurvey(Position position) async {
    try {
      DataService dataService = DataService.fromCache();
      List<Survey> surveys = await dataService.getLocationSurveys(
          position.latitude, position.longitude);
      return surveys;
    } catch (e) {
      rethrow;
    }
  }
}

class LocationCategoryState extends Equatable {
  const LocationCategoryState();

  @override
  List<Object?> get props => [];
}
