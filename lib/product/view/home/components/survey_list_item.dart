import '../../../router/routes.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../../core/extensions/color_extension.dart';
import '../../../constants/style/colors.dart';
import '../../../models/survey.dart';
import '../../../utils/survey_cache_manager.dart';

class SurveyListItem extends StatelessWidget {
  final Survey surveyModel;
  final bool submitted;
  const SurveyListItem(
      {Key? key, required this.surveyModel, required this.submitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.push(SurveyRoute(survey: surveyModel)),
      child: Container(
        width: context.screenWidth,
        decoration: BoxDecoration(
          color: AppStyle.surveyListItemBackgroundColor,
          border: Border(
            left: BorderSide(
                width: 4,
                color: HexColor.fromHex(SurveyCacheManager.instance.categories
                    .where((element) => element.id == surveyModel.categoryId)
                    .first
                    .color)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        label: Text(
                          submitted ? 'completed'.tr() : 'uncompleted'.tr(),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        label: Text(SurveyCacheManager.instance.categories
                                .where((element) =>
                                    element.id == surveyModel.categoryId)
                                .first
                                .name)
                            .tr(),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Text(surveyModel.submissionCount.toString()),
                      const Icon(Icons.check, color: Colors.green)
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                surveyModel.name,
                style: context.appTextTheme.headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                surveyModel.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.appTextTheme.subtitle1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
