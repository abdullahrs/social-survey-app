import 'package:json_annotation/json_annotation.dart';

import 'answer.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true,fieldRename: FieldRename.snake)
class Question {
  final int questionId;
  final String questionText;
  final List<Answer> answers;

  Question(
      {required this.questionId, required this.questionText, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
