import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../../models/survey.dart';
import '../custom_exception.dart';
import '../../services/data_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_state.dart';

class SurveyListViewModel extends Cubit<ListState> {
  SurveyListViewModel() : super(const ListState(state: ListStatus.initial));

  final DataService _dataService = DataService.fromCache();

  String? categoryID;

  void fetchSurveys(String? categoryID) async {
    emit(state.copyWith(state: ListStatus.loading));
    try {
      final surveys = await _dataService.getSurveys(
        categoryId: categoryID,
        limit: categoryID == null ? 5 : 10,
      );
      emit(state.copyWith(state: ListStatus.loaded, surveys: surveys));
    } catch (e) {
      if (e is FetchDataException) {
        emit(state.copyWith(state: ListStatus.loading, message: e.message));
      }
    }
  }

  void updateState() {
    emit(state.copyWith(state: ListStatus.updated));
  }
}
