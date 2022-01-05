import '../../../router/routes.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../../core/extensions/color_extension.dart';
import '../../../constants/app_constants/app_categories.dart';
import '../../../models/category.dart';

class CategoriyGrid extends StatelessWidget {
  final List<Category> data;
  const CategoriyGrid({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: kCategories.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (data.isEmpty) {
          return Container(
            color: Colors.red,
            child: const Text("Snapshot.data is empty"),
          );
        }
        String categoryName = data[index].name;
        return InkWell(
          onTap: () =>
              context.router.push(SurveyListRoute(categoryId: data[index].id)),
          child: Container(
            height: context.dynamicWidth(0.4),
            width: context.dynamicWidth(0.4),
            margin: const EdgeInsets.all(10),
            child: Card(
              color: HexColor.fromHex(data[index].color),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    kCategoryIcons.containsKey(categoryName)
                        ? kCategoryIcons[categoryName]!
                        : kDefaultIconPath,
                    height: context.dynamicWidth(0.2),
                    width: context.dynamicWidth(0.2),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    kCategories[index].tr(),
                    style: context.appTextTheme.headline4,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
