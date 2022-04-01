import '../../../router/routes.dart';
import 'package:auto_route/src/router/auto_router_x.dart';

import '../../../utils/survey_list_view_model/list_viewmodel_export.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../utils/survey_list_view_model/list_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/survey_list.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../models/category.dart';
import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';
import '../components/categories_horizontal_list.dart';

class HomeMainPage extends StatelessWidget {
  HomeMainPage({Key? key}) : super(key: key);
  final DataService dataService = DataService.fromCache();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'categories'.tr(),
              style: context.appTextTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            horizontalCategoryField(context),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'surveys'.tr(),
                    style: context.appTextTheme.headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => context.router
                        .push(CategoryListRoute(categoryId: null)),
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
            Expanded(
              child: BlocProvider.value(
                  value: kSurveyListViewModel..fetchSurveys(null),
                  child: BlocBuilder<SurveyListViewModel, ListState>(
                      builder: (context, listState) {
                    switch (listState.state) {
                      case ListStatus.initial:
                      case ListStatus.loading:
                        return kLoadingWidget;
                      case ListStatus.error:
                        return Center(
                          child: Text(listState.message!),
                        );
                      case ListStatus.updated:
                      case ListStatus.loaded:
                        {
                          return SurveyListPage(
                            surveys: listState.surveys!,
                            scrollCallback: (int i) async {
                              return true;
                            },
                          );
                        }
                    }
                  })),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox horizontalCategoryField(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.125),
      width: context.screenWidth,
      child: SurveyCacheManager.instance.categories.isNotEmpty
          ? HorizontalCategories(data: SurveyCacheManager.instance.categories)
          : FutureBuilder(
              future: dataService.getCategories(),
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
}
