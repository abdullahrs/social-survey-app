import 'package:hive_flutter/adapters.dart';

import '../../core/src/cache_manager.dart';
import '../constants/app_constants/hive_model_constants.dart';
import '../constants/app_constants/hive_type_constants.dart';
import '../models/token.dart';

class TokenCacheManager extends ModelCacheManager{
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
}
