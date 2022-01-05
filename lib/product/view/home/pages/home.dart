import '../../../utils/routes.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home_categories.dart';
import 'home_main.dart';
import 'home_participated.dart';
import 'home_settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GButton> get tabs => [
        GButton(
          icon: CupertinoIcons.home,
          text: ' ' + 'home'.tr(),
          borderRadius: BorderRadius.circular(10),
        ),
        GButton(
          icon: Icons.category_outlined,
          text: ' ' + 'categories'.tr(),
          borderRadius: BorderRadius.circular(10),
        ),
        GButton(
          icon: CupertinoIcons.add_circled,
          text: ' ' + 'participated'.tr(),
          borderRadius: BorderRadius.circular(10),
          margin: const EdgeInsets.all(4),
        ),
        GButton(
          icon: Icons.settings,
          text: ' ' + 'settings'.tr(),
          borderRadius: BorderRadius.circular(10),
        ),
      ];

  List<Widget> get pages => const [
        HomeMainPage(),
        CategoryPage(),
        ParticipatedPage(),
        SettingsPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      // appBar: AppBar(),
      routes: const [
        HomeMainRouter(),
        HomeCategoryRouter(),
        ParticipatedRouter(),
        SettingsRouter(),
      ],
      bottomNavigationBuilder: (context, router) => GNav(
        selectedIndex: router.activeIndex,
        iconSize: 24,
        tabBackgroundColor: Colors.teal.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        duration: const Duration(milliseconds: 500),
        onTabChange: router.setActiveIndex,
        tabs: tabs,
      ),
    );
  }
}
