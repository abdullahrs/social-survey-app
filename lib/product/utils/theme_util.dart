import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_constants/hive_model_constants.dart';
import 'survey_cache_manager.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(bool isDark) : super(ThemeState(isDark));

  void changeTheme(bool val) {
    emit(ThemeState(val));
    SurveyCacheManager.instance.putItem(HiveModelConstants.darkMode, val);
  }

}

class ThemeState extends Equatable {
  final bool isDark;

  const ThemeState(this.isDark);

  @override
  List<Object?> get props => [isDark];
}
