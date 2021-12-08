import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/models/survey_item_model.dart';
import 'package:anket/product/view/home/components/survey_list_item.dart';
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

  List<Widget> pages() => [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'categories'.tr(),
                  style: context.appTextTheme.headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: context.dynamicHeight(0.125),
                width: context.screenWidth,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        height: context.dynamicHeight(0.125),
                        width: context.dynamicHeight(0.125),
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: Color.fromARGB(255, 29 * (index + 1),
                              26 * (index + 1), 27 * (index + 1)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'surveys'.tr(),
                      style: context.appTextTheme.headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'all'.tr(),
                            style: context.appTextTheme.headline6!
                                .copyWith(color: Colors.blue),
                          ),
                          const Icon(Icons.keyboard_arrow_right_outlined,
                              color: Colors.blue)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ...List<Widget>.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom:20.0),
                    child: SurveyListItem(
                          surveyListModel: SurveyListModel(
                              surveyID: 1,
                              title: "Birinci anket",
                              desc: "İlk deneme anketi",
                              status: false,
                              category: "Genel",
                              numberOfSolve: 21,
                              color: "3a4c93"),
                        ),
                  )),
            ],
          ),
        ),
        SingleChildScrollView(child: Column()),
        SingleChildScrollView(child: Column()),
        SingleChildScrollView(child: Column()),
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
          child: pages()[selectedIndex],
        ));
  }
}
