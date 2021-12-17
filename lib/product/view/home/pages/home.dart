import 'package:anket/product/view/home/pages/home_categories.dart';
import 'package:anket/product/view/home/pages/home_main.dart';
import 'package:anket/product/view/home/pages/home_participated.dart';
import 'package:anket/product/view/home/pages/home_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

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
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: GNav(
          selectedIndex: selectedIndex,
          iconSize: 24,
          tabBackgroundColor: Colors.teal.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          duration: const Duration(milliseconds: 500),
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          tabs: tabs,
        ),
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: pages[selectedIndex],
        ));
  }
}
