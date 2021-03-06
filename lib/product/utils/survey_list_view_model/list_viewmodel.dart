import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../../models/survey.dart';
import '../../services/data_service.dart';
import '../custom_exception.dart';

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

  Future<void> loadMoreSurvey(int limit, int page) async {
    // emit(state.copyWith(state: ListStatus.loading));
    try {
      print("$limit $page");
      final surveys = await _dataService.getSurveys(
        categoryId: categoryID,
        limit: limit,
        page: page,
      );
      if (surveys.isNotEmpty) {
        emit(state.copyWith(
            state: ListStatus.loaded,
            surveys: [...state.surveys!, ...surveys]));
      }
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
