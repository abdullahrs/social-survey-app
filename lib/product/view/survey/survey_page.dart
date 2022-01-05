import '../../models/survey.dart';
import 'package:flutter/material.dart';

class SurveyPage extends StatelessWidget {
  final Survey survey;
  const SurveyPage({Key? key, required this.survey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PageView(
        children: List<Widget>.generate(
            survey.questions.length,
            (index) => Column(
                  children: [
                    Text(survey.questions[index].questionText),
                    const SizedBox(height: 50),
                    ...List<Widget>.generate(
                        survey.questions[index].answers.length,
                        (ansIndex) => Text(survey
                            .questions[index].answers[ansIndex].answerText))
                  ],
                )),
      ),
    ));
  }
}
