import '../models/survey.dart';
import '../utils/survey_cache_manager.dart';
import '../view/survey/components/survey_list_item.dart';

import 'package:flutter/material.dart';

class SurveyListPage extends StatefulWidget {
  final List<Survey> surveys;
  final Function(int) scrollCallback;
  const SurveyListPage({
    Key? key,
    required this.surveys,
    required this.scrollCallback,
  }) : super(key: key);

  @override
  _SurveyListPageState createState() => _SurveyListPageState();
}

class _SurveyListPageState extends State<SurveyListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ListView.builder(
        itemCount: widget.surveys.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SurveyListItem(
                surveyModel: widget.surveys[index],
                submitted:
                    SurveyCacheManager.instance.submittedSurveys.isNotEmpty
                        ? SurveyCacheManager.instance.submittedSurveys
                            .contains(widget.surveys[index].id)
                        : false),
          );
        },
      ),
    );
  }
}
