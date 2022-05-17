import '../models/survey.dart';
import '../utils/survey_cache_manager.dart';
import '../view/survey/components/survey_list_item.dart';

import 'package:flutter/material.dart';


typedef ParamFunction = Future<bool> Function(int x);
class SurveyListPage extends StatefulWidget {
  final List<Survey> surveys;
  final ParamFunction scrollCallback;
  final bool isSurveysAvaible;
  const SurveyListPage({
    Key? key,
    required this.surveys,
    required this.scrollCallback,
    this.isSurveysAvaible = true
  }) : super(key: key);

  @override
  _SurveyListPageState createState() => _SurveyListPageState();
}

class _SurveyListPageState extends State<SurveyListPage> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async{
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        var result = await widget.scrollCallback(_page);
        if(result){
          _page--;
        }
      }
      if (_scrollController.position.pixels ==
              _scrollController.position.minScrollExtent &&
          _page > 1) {
        _page--;
        widget.scrollCallback(_page);
      }
    });
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
        controller: _scrollController,
        itemCount: widget.surveys.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SurveyListItem(
                surveyModel: widget.surveys[index],
                isAvaible: widget.isSurveysAvaible,
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
