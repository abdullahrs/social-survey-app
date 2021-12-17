import 'package:hive_flutter/hive_flutter.dart';

abstract class Preferences<T> {
  
  final String boxKey;

  Box<T>? box;

  Preferences({required this.boxKey});
  
  Future<void> init() async {
    box = await Hive.openBox(boxKey);
  }

  Future<void> putItem(String key, T item) => box!.put(key, item);

  T? getItem(String key) => box!.get(key);

  Future<void> removeItem(String key) => box!.delete(key);
  Future<void> clearAll() async => await box?.clear();
}
