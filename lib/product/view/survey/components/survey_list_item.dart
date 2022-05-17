import '../../../components/countdown_widget.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../../core/extensions/color_extension.dart';
import '../../../components/dialog/warning_dialog.dart';
import '../../../constants/strings/svg_paths.dart';
import '../../../utils/survey_cache_manager.dart';
import '../../../models/survey.dart';
import '../../../router/routes.dart';

class SurveyListItem extends StatelessWidget {
  final Survey surveyModel;
  final bool submitted;
  final bool isAvaible;
  const SurveyListItem(
      {Key? key,
      required this.surveyModel,
      required this.submitted,
      this.isAvaible = true})
      : super(key: key);

  Future<void> onClickItem(BuildContext context) async {
    if (!isAvaible) {
      if (surveyModel.expireDate != null &&
          !DateTime.parse(surveyModel.expireDate!).isBefore(DateTime.now())) {
        await showWarningDialog(context,
            text: "survey-still-active".tr(), imagePath: SvgPaths.expired);
        return;
      }
      context.router.push(ResultRoute(
          url:
              "https://socialsurveyapp.software/results/#/?surveyId=${surveyModel.id}"));
    }
    if (!submitted) {
      if (surveyModel.expireDate != null &&
          DateTime.parse(surveyModel.expireDate!).isBefore(DateTime.now())) {
        context.router.push(ResultRoute(
            url:
                "https://socialsurveyapp.software/results/#/?surveyId=${surveyModel.id}"));
      } else {
        context.router.push(SurveyRoute(survey: surveyModel));
      }
    } else {
      context.router.push(ResultRoute(
          url:
              "https://socialsurveyapp.software/results/#/?surveyId=${surveyModel.id}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await onClickItem(context),
      child: Container(
        width: context.screenWidth,
        decoration: BoxDecoration(
          color: context.appTheme.cardColor,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 9,
                  child: Wrap(
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
                      if (surveyModel.expireDate != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Chip(
                            label: Text("time-limited".tr()),
                            backgroundColor: Colors.green,
                          ),
                        ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 16.0),
                    child: Row(
                      children: [
                        Text(surveyModel.submissionCount.toString()),
                        const Flexible(
                            child: Icon(Icons.check, color: Colors.green))
                      ],
                    ),
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
            ),
            if (surveyModel.expireDate != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: CountdownWidget(
                    expireDate: DateTime.parse(surveyModel.expireDate!)),
              ),
          ],
        ),
      ),
    );
  }
}
