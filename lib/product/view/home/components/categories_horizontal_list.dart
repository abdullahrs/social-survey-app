import 'package:auto_route/src/router/auto_router_x.dart';

import '../../../models/category.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../../core/extensions/color_extension.dart';
import '../../../constants/app_constants/app_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'survey_list.dart';

class HorizontalCategories extends StatelessWidget {
  final List<Category> data;
  const HorizontalCategories({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        String categoryName = data[index].name;
        return InkWell(
          onTap: () {
            context.router.pushWidget(SurveyList(categoryId: data[index].id));
          },
          child: Container(
            height: context.dynamicHeight(0.125),
            width: context.dynamicHeight(0.125),
            padding: const EdgeInsets.all(10),
            child: Card(
              color: HexColor.fromHex(data[index].color),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  kCategoryIcons.containsKey(categoryName)
                      ? kCategoryIcons[categoryName]!
                      : kDefaultIconPath,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
