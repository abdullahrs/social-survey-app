import 'package:anket/core/src/cache_manager.dart';
import 'package:anket/product/models/token.dart';

class MockTokenCacheManager extends ModelCacheManager {
  MockTokenCacheManager() : super("box");

  static Tokens? token;

  @override
  void registerAdapters() {}

  @override
  Future<void> putItem(String key, item) async {
    token = item;
  }

  @override
  dynamic getItem(String key) {
    return token;
  }
}
