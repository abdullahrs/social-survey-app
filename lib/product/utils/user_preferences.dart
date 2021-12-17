import 'package:anket/core/src/preferences.dart';

class UserPreferences extends Preferences {
  static const String _boxKey = "userPreferencesBoxKey";

  UserPreferences() : super(boxKey: _boxKey);
  
}
