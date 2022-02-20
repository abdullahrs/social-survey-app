import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../models/survey.dart';
import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';
import '../components/survey_list_item.dart';

class SurveyListPage extends StatefulWidget {
  final String categoryId;
  const SurveyListPage({
    Key? key,
    @PathParam() required this.categoryId,
    // required this.categoryId,
  }) : super(key: key);

  @override
  _SurveyListPageState createState() => _SurveyListPageState();
}

class _SurveyListPageState extends State<SurveyListPage> {
  final ScrollController _scrollController = ScrollController();
  final DataService _dataService = DataService.fromCache();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: FutureBuilder(
              future: _dataService.getSurveys(
                categoryId: widget.categoryId,
                limit: 10,
              ),
              builder: (context, AsyncSnapshot<List<Survey>> snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ValueListenableBuilder(
                    valueListenable:
                        SurveyCacheManager.instance.submittedSurveysListener,
                    builder: (BuildContext context, value, Widget? child) =>
                        ListView.builder(
                            controller: _scrollController,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, int index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: SurveyListItem(
                                      surveyModel: snapshot.data![index],
                                      submitted: SurveyCacheManager.instance
                                              .submittedSurveys.isNotEmpty
                                          ? SurveyCacheManager
                                              .instance.submittedSurveys
                                              .contains(
                                                  snapshot.data![index].id)
                                          : false),
                                )),
                  );
                }
                return kLoadingWidget;
              }),
        ),
      ),
    );
  }
}
