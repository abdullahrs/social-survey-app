import 'package:hive_flutter/hive_flutter.dart';

abstract class Preferences<T> {
  static const String _key = "userPreferencesStorageKey";
  Box<T>? _box;

  Preferences();
  Future<void> init() async {
    _box = await Hive.openBox(_key);
  }

  Future<void> putItem(String key, T item) => _box!.put(key, item);

  T? getItem(String key) => _box!.get(key);

  Future<void> removeItem(String key) => _box!.delete(key);
  Future<void> clearAll() async => await _box?.clear();
}
