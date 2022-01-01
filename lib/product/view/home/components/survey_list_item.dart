import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../../core/extensions/color_extension.dart';
import '../../../constants/style/colors.dart';
import '../../../models/survey.dart';

class SurveyListItem extends StatelessWidget {
  final Survey surveyListModel;
  const SurveyListItem({Key? key, required this.surveyListModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: AppStyle.surveyListItemBackgroundColor,
        border: Border(
          left: BorderSide(
              width: 4,
              color: HexColor.fromHex(
                  "3a4c93") // TODO HexColor.fromHex(surveyListModel.color), 3a4c93
              ),
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
                        // TODO: surveyListModel.status
                        true ? 'completed'.tr() : 'uncompleted'.tr(),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text(surveyListModel.categoryId),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    Text(surveyListModel.submissionCount.toString()),
                    const Icon(Icons.check, color: Colors.green)
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              surveyListModel.name,
              style: context.appTextTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              surveyListModel.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: context.appTextTheme.subtitle1,
            ),
          )
        ],
      ),
    );
  }
}
