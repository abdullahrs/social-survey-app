import 'package:hive_flutter/adapters.dart';

import '../../core/src/cache_manager.dart';
import '../constants/app_constants/hive_model_constants.dart';
import '../constants/app_constants/hive_type_constants.dart';
import '../models/token.dart';

class TokenCacheManager extends ModelCacheManager<Tokens> {
  TokenCacheManager({String boxKey = HiveModelConstants.tokenStorageKey})
      : super(boxKey);

  static TokenCacheManager? _instance;

  static TokenCacheManager get instance {
    _instance ??= TokenCacheManager();
    return _instance!;
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.accessTypeID)) {
      Hive.registerAdapter(AccessAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveConstants.tokenTypeID)) {
      Hive.registerAdapter(TokensAdapter());
    }
  }

  bool? checkUserIsLogin() {
    Tokens? token = getToken();
    // Login olmasi gerekiyor
    if (token == null) return null;

    DateTime now = DateTime.now();
    DateTime expireDate = DateTime.parse(token.access.expires);
    if (!now.isBefore(expireDate)) {
      DateTime refreshDate = DateTime.parse(token.refresh.expires);
      if (!now.isBefore(refreshDate)) {
        // Tekrar login olmasi gerekiyor
        return null;
      } else {
        // Refresh token'i ile yeni access token'i almasi gerekiyor
        return false;
      }
    }
    // Sikinti yok
    return true;
  }

  Tokens? getToken() => getItem(HiveModelConstants.tokenKey);
}
