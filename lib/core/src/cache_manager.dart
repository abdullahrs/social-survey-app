import 'package:hive_flutter/adapters.dart';

abstract class ModelCacheManager {
  final String boxKey;

  ModelCacheManager(this.boxKey);

  static Box? _box;

  Future<void> init() async {
    registerAdapters();
    _box = await Hive.openBox(boxKey);
  }

  void registerAdapters();

  Future<void> putItem(String key, item) => _box!.put(key, item);

  dynamic getItem(String key) => _box!.get(key);

  Future<void> removeItem(String key) => _box!.delete(key);

  listen() => _box!.listenable();
}
