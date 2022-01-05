import '../components/categories_horizontal_list.dart';

import '../../../utils/survey_cache_manager.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../components/survey_list_item.dart';
import '../../../models/category.dart';
import '../../../models/survey.dart';
import '../../../services/data_service.dart';
import '../../../utils/token_cache_manager.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
            horizontalCategoryField(context),
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
            surveyField(),
          ],
        ),
      ),
    );
  }

  Container horizontalCategoryField(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.125),
      width: context.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SurveyCacheManager.instance.categories.isNotEmpty
          ? HorizontalCategories(data: SurveyCacheManager.instance.categories)
          : FutureBuilder(
              future: DataService.instance.getCategories(
                control: TokenCacheManager.instance.checkUserIsLogin(),
                token: TokenCacheManager.instance.getToken()!,
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Category>> snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return HorizontalCategories(data: snapshot.data!);
                }
                return const Center(child: CircularProgressIndicator());
              }),
    );
  }

  FutureBuilder<List<Survey>> surveyField() {
    return FutureBuilder(
        future: DataService.instance.getSurveys(
          control: TokenCacheManager.instance.checkUserIsLogin(),
          token: TokenCacheManager.instance.getToken()!,
        ),
        builder: (BuildContext context, AsyncSnapshot<List<Survey>> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Column(
                children: List<Widget>.generate(
                    snapshot.data!.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SurveyListItem(
                            surveyModel: snapshot.data![index],
                            submitted: SurveyCacheManager
                                    .instance.submittedSurveys.isNotEmpty
                                ? SurveyCacheManager.instance.submittedSurveys
                                    .contains(snapshot.data![index].id)
                                : false,
                          ),
                        )));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
