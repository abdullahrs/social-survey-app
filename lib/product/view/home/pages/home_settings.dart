import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ListTile(
          title: Text('logout'.tr()),
        leading: const Icon(Icons.logout),
          onTap: () async {},
        ),
      ],
    ));
  }
}
