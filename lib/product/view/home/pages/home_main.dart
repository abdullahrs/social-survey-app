import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/models/survey_item_model.dart';
import 'package:anket/product/view/home/components/survey_list_item.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                    padding: const EdgeInsets.only(bottom: 20.0),
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
    );
  }
}
