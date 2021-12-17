import 'package:anket/core/src/cache_manager.dart';
import 'package:anket/product/constants/app_constants/hive_model_constants.dart';
import 'package:anket/product/constants/app_constants/hive_type_constants.dart';
import 'package:anket/product/models/token.dart';
import 'package:hive_flutter/adapters.dart';

class TokenCacheManager extends ModelCacheManager<Tokens> {
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
    Tokens? token = getItem(HiveModelConstants.tokenKey);
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
}
