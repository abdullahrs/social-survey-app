import '../../../utils/survey_list_view_model/list_viewmodel_export.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../utils/survey_list_view_model/list_viewmodel.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/survey_list.dart';
import 'package:flutter/material.dart';

class CategoryListPage extends StatefulWidget {
  final String categoryId;
  const CategoryListPage({
    Key? key,
    @PathParam() required this.categoryId,
  }) : super(key: key);

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  void initState() {
    super.initState();
    kSurveyListViewModel.fetchSurveys(widget.categoryId);
  }

  @override
  void dispose() {
    kSurveyListViewModel.fetchSurveys(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocProvider.value(
            value: kSurveyListViewModel,
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
                  return SurveyListPage(
                    surveys: listState.surveys!,
                    scrollCallback: (int i) {
                      //TODO
                    },
                  );
              }
            })),
      ),
    );
  }
}
