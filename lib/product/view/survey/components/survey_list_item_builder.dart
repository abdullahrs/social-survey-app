import '../../../models/survey.dart';
import '../../../utils/survey_cache_manager.dart';

import 'package:flutter/material.dart';
import 'survey_list_item.dart';

class SurveyListBuilder extends StatefulWidget {
  final List<Survey> surveys;
  const SurveyListBuilder({Key? key, required this.surveys}) : super(key: key);

  @override
  _SurveyListBuilderState createState() => _SurveyListBuilderState();
}

class _SurveyListBuilderState extends State<SurveyListBuilder> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            widget.surveys.length,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SurveyListItem(
                      surveyModel: widget.surveys[index],
                      submitted: SurveyCacheManager
                              .instance.submittedSurveys.isNotEmpty
                          ? SurveyCacheManager.instance.submittedSurveys
                              .contains(widget.surveys[index].id)
                          : false),
                )));
  }
}
