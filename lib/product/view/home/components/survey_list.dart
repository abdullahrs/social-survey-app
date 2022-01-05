
import 'package:auto_route/annotations.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../models/survey.dart';
import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';
import '../../../utils/token_cache_manager.dart';
import 'survey_list_item.dart';
import 'package:flutter/material.dart';

class SurveyList extends StatefulWidget {
  final String categoryId;
  const SurveyList({
    Key? key,
    // @PathParam('categoryId') required this.categoryId,
    required this.categoryId,
  }) : super(key: key);

  @override
  _SurveyListState createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: DataService.instance.getSurveys(
            control: TokenCacheManager().checkUserIsLogin(),
            token: TokenCacheManager().getToken()!,
            categoryId: widget.categoryId,
            limit: 10,
          ),
          builder: (context, AsyncSnapshot<List<Survey>> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, int index) => SurveyListItem(
                      surveyModel: snapshot.data![index],
                      submitted: SurveyCacheManager
                              .instance.submittedSurveys.isNotEmpty
                          ? SurveyCacheManager.instance.submittedSurveys
                              .contains(snapshot.data![index].id)
                          : false));
            }
            return kLoadingWidget;
          }),
    );
  }
}
