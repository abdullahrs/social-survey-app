import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/core/extensions/color_extension.dart';
import 'package:anket/product/constants/style/colors.dart';
import 'package:anket/product/models/survey_model.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class SurveyListItem extends StatelessWidget {
  final SurveyModel surveyListModel;
  const SurveyListItem({Key? key, required this.surveyListModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: context.dynamicHeight(0.2),
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: AppStyle.surveyListItemBackgroundColor,
        border: Border(
          left: BorderSide(
            width: 4,
            color: HexColor.fromHex(surveyListModel.color),
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
                        surveyListModel.status
                            ? 'completed'.tr()
                            : 'uncompleted'.tr(),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text(surveyListModel.category),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    Text(surveyListModel.numberOfSolve.toString()),
                    const Icon(Icons.check, color: Colors.green)
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              surveyListModel.title,
              style: context.appTextTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              surveyListModel.desc,
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
