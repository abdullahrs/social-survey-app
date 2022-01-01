import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Answer {
  final int answerId;
  final String answerText;

  Answer({required this.answerId, required this.answerText});

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
