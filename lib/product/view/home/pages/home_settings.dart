import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constants/hive_model_constants.dart';
import '../../../services/auth_service.dart';
import '../../../utils/token_cache_manager.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            title: Text('logout'.tr()),
            leading: const Icon(Icons.logout),
            onTap: () async {
              TokenCacheManager cacheManager = TokenCacheManager();
              var token = cacheManager.getItem(HiveModelConstants.tokenKey);
              await AuthService.instance.logout(refreshToken: token!.refresh.token)
                  .then((value) async {
                if (value) {
                  await cacheManager.removeItem(HiveModelConstants.tokenKey);
                  context.router.pop();
                }
              });
            },
          ),
        ],
      )),
    );
  }
}
