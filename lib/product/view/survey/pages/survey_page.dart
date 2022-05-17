import '../../../components/custom_slider.dart';
import '../../../components/dialog/warning_dialog.dart';
import '../../../constants/strings/svg_paths.dart';
import '../../../models/answer.dart';
import '../../../models/question.dart';
import '../../../utils/custom_exception.dart';
import '../../../utils/survey_list_view_model/list_viewmodel_export.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';

import '../../../models/post.dart' show Post, UserAnswer, UserLocation;

import '../../../constants/style/colors.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import 'package:easy_localization/src/public_ext.dart';
import '../../../models/survey.dart';
import 'package:flutter/material.dart';

import '../components/answer_button.dart';
import '../components/question_field.dart';
import '../components/step_bars.dart';

class SurveyPage extends StatefulWidget {
  // implements AutoRouteWrapper
  final Survey survey;
  const SurveyPage({Key? key, required this.survey}) : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();

  // @override
  // Widget wrappedRoute(BuildContext context) {
  //   return BlocProvider<SurveyListViewModel>.value(
  //     value: value,
  //     child: this,
  //   );
  // }
}

class _SurveyPageState extends State<SurveyPage> {
  final PageController _pageController = PageController();
  late final int numberOfPages;
  int pageIndex = 0;
  // MultipleChocie question variables
  int? answerIndex;
  int? answerUIIndex;
  List<Map<String, dynamic>> userAnswers = [];
  // Slider question variables
  int sliderValue = 0;
  // Ranking question variables
  List<Answer> rankingAnswers = [];

  void decideAnswer(Question question) {
    switch (question.questionType) {
      case QuestionType.multipleChoice:
        userAnswers.add({
          "questionId": question.questionId,
          "multipleChoiceValue": answerIndex!
        });
        answerIndex = null;
        answerUIIndex = null;
        break;
      case QuestionType.slider:
        userAnswers.add(
            {"questionId": question.questionId, "sliderValue": sliderValue});
        sliderValue = 0;
        break;
      case QuestionType.ranking:
        userAnswers.add({
          "questionId": question.questionId,
          "rankingValue": [for (var answer in rankingAnswers) answer.answerId]
        });
        rankingAnswers = [];
        break;
    }
  }

  Future<void> onNext() async {
    final DataService _dataService = DataService.fromCache();
    if (pageIndex == numberOfPages - 1) {
      decideAnswer(widget.survey.questions[pageIndex]);
      try {
        Post post = Post(
          surveyId: widget.survey.id,
          answers: List<UserAnswer>.generate(userAnswers.length, (index) {
            String answerKey =
                userAnswers.elementAt(index).keys.last == "rankingValue"
                    ? "rankingValue"
                    : userAnswers.elementAt(index).keys.last == "sliderValue"
                        ? "sliderValue"
                        : "multipleChoiceValue";
            return UserAnswer(
                questionType:
                    widget.survey.questions.elementAt(index).questionType,
                questionId: userAnswers[index]['questionId'],
                answer: userAnswers[index][answerKey]);
          }),
          location: UserLocation(lat: 1.0, long: 1.0),
        );
        await _dataService.sendSurveyAnswers(post);
        await SurveyCacheManager.instance.submitSurvey(post.surveyId);
        kSurveyListViewModel.updateState();
      } catch (e) {
        await showWarningDialog(context,
            imagePath: SvgPaths.expired,
            text: '${e is FetchDataException ? e.message : e}');
      }
      context.router.pop();
    } else {
      decideAnswer(widget.survey.questions[pageIndex]);
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
    }
  }

  @override
  void initState() {
    super.initState();
    numberOfPages = widget.survey.questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: BlocProvider.value(
        value: kSurveyListViewModel,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
              child:
                  StepBars(numberOfPages: numberOfPages, pageIndex: pageIndex),
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
                                    vertical: 20, horizontal: 15),
                                child: QuestionField(
                                    questionText: widget
                                        .survey.questions[index].questionText),
                              ),
                              const SizedBox(height: 32),
                              Expanded(
                                  child: buildQuestionField(
                                      widget.survey.questions[index]))
                            ],
                          )),
                ),
              ),
            ),
            SizedBox(
              width: context.screenWidth,
              height: context.dynamicHeight(0.1),
              child: ElevatedButton(
                onPressed: () async => await onNext(),
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
      ),
    ));
  }

  Widget buildQuestionField(Question question) {
    switch (question.questionType) {
      case QuestionType.multipleChoice:
        return multipleChoiceBuilder(question);

      case QuestionType.slider:
        SliderAnswer sliderAnswer = (question.answers.first as SliderAnswer);
        if (sliderValue == 0) {
          sliderAnswer.sliderMin;
        }
        return SliderTheme(
          data:
              const SliderThemeData(trackShape: GradientRectSliderTrackShape()),
          child: Slider(
            value: sliderValue.toDouble(),
            label: "$sliderValue",
            divisions: sliderAnswer.sliderMax,
            min: sliderAnswer.sliderMin.toDouble() - 1,
            max: sliderAnswer.sliderMax.toDouble(),
            activeColor: AppStyle.persianGreenColor,
            onChanged: (double value) {
              setState(() {
                sliderValue = value.round();
              });
            },
          ),
        );
      case QuestionType.ranking:
        if (rankingAnswers.isEmpty) rankingAnswers = question.answers;
        return ReorderableListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rankingAnswers.length,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex--;
              final item = rankingAnswers.removeAt(oldIndex);
              rankingAnswers.insert(newIndex, item);
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              key: ValueKey(rankingAnswers.elementAt(index)),
              title: Text(rankingAnswers.elementAt(index).answerText),
              trailing: const Icon(Icons.reorder),
              onTap: () {},
            );
          },
        );
    }
  }

  Column multipleChoiceBuilder(Question question) {
    return Column(
      children: List<Widget>.generate(
        question.answers.length,
        (ansIndex) => AnswerButton(
          text: question.answers[ansIndex].answerText,
          borderColor: answerUIIndex == ansIndex
              ? AppStyle.customButtonColor
              : AppStyle.textButtonColor,
          textColor: answerUIIndex == ansIndex
              ? Colors.white
              : AppStyle.textButtonColor,
          backgroundColor:
              answerUIIndex == ansIndex ? AppStyle.customButtonColor : null,
          callback: () {
            setState(() {
              answerUIIndex = ansIndex;
              answerIndex = question.answers[ansIndex].answerId;
            });
          },
        ),
      ),
    );
  }
}
