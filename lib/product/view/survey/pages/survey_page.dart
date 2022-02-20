import 'dart:developer';

import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';

import '../../../models/post.dart' show Post, UserAnswer, UserLocation;
import 'package:auto_route/src/router/auto_router_x.dart';

import '../../../constants/style/colors.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import 'package:easy_localization/src/public_ext.dart';
import '../../../models/survey.dart';
import 'package:flutter/material.dart';

import '../components/answer_button.dart';
import '../components/question_field.dart';
import '../components/step_bars.dart';

class SurveyPage extends StatefulWidget {
  final Survey survey;
  const SurveyPage({Key? key, required this.survey}) : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final PageController _pageController = PageController();
  late final int numberOfPages;
  @override
  void initState() {
    super.initState();
    numberOfPages = widget.survey.questions.length;
  }

  int pageIndex = 0;
  int? answerIndex;
  int? answerUIIndex;
  // [[questionId,answerId],[...]]
  List<List<int>> answerIDs = [];
  @override
  Widget build(BuildContext context) {
    widget.survey;
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
            child: StepBars(numberOfPages: numberOfPages, pageIndex: pageIndex),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int? index) {
                  if (index != null) {
                    pageIndex = index;
                    answerIndex = null;
                    setState(() {});
                  }
                },
                children: List<Widget>.generate(
                    numberOfPages,
                    (index) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 20),
                              child: QuestionField(
                                  questionText: widget
                                      .survey.questions[index].questionText),
                            ),
                            const SizedBox(height: 50),
                            ...List<Widget>.generate(
                                widget.survey.questions[index].answers.length,
                                (ansIndex) => AnswerButton(
                                      text: widget.survey.questions[index]
                                          .answers[ansIndex].answerText,
                                      borderColor: answerUIIndex == ansIndex
                                          ? AppStyle.customButtonColor
                                          : AppStyle.textButtonColor,
                                      textColor: answerUIIndex == ansIndex
                                          ? Colors.white
                                          : AppStyle.textButtonColor,
                                      backgroundColor: answerUIIndex == ansIndex
                                          ? AppStyle.customButtonColor
                                          : null,
                                      callback: () {
                                        setState(() {
                                          answerUIIndex = ansIndex;
                                          answerIndex = widget
                                              .survey
                                              .questions[index]
                                              .answers[ansIndex]
                                              .answerId;
                                        });
                                      },
                                    ))
                          ],
                        )),
              ),
            ),
          ),
          SizedBox(
            width: context.screenWidth,
            height: context.dynamicHeight(0.1),
            child: ElevatedButton(
              onPressed: () async {
                final DataService _dataService = DataService.fromCache();
                if (pageIndex == numberOfPages - 1) {
                  answerIDs.add([
                    widget.survey.questions[pageIndex].questionId,
                    answerIndex!
                  ]);
                  try {
                    Post post = Post(
                      surveyId: widget.survey.id,
                      answers: List<UserAnswer>.generate(
                          answerIDs.length,
                          (index) => UserAnswer(
                              questionId: answerIDs[index][0],
                              answerId: answerIDs[index][1])),
                      location: UserLocation(lat: 1.0, long: 1.0),
                    );
                    await _dataService.sendSurveyAnswers(post);
                    await SurveyCacheManager.instance
                        .submitSurvey(post.surveyId);
                  } catch (e) {
                    log("$e");
                  }
                  context.router.pop();
                } else {
                  answerIDs.add([
                    widget.survey.questions[pageIndex].questionId,
                    answerIndex!
                  ]);
                  answerIndex = null;
                  answerUIIndex = null;
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.bounceIn);
                }
              },
              child: Text(
                (pageIndex == numberOfPages - 1)
                    ? 'end-survey'.tr()
                    : 'continue'.tr(),
                style: context.appTextTheme.headline4!
                    .copyWith(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppStyle.customButtonColor),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.zero),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
