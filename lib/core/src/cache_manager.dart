import 'package:hive_flutter/adapters.dart';

abstract class ICacheManager<T> {
  static const String boxKey = "userStatusStorageKey";

  static Box? _box;

  Future<void> init() async {
    registerAdapters();
    _box = await Hive.openBox(boxKey);
  }

  void registerAdapters();

  Future<void> putItem(String key, T item) => _box!.put(key, item);

  T? getItem(String key) => _box!.get(key);

  Future<void> removeItem(String key) => _box!.delete(key);
  Future<void> clearAll() async => await _box?.clear();
}
