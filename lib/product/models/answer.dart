import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

// @JsonSerializable() //fieldRename: FieldRename.snake
// class Answer {
//   final int answerId;
//   final String answerText;

//   Answer({required this.answerId, required this.answerText});

//   factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

//   Map<String, dynamic> toJson() => _$AnswerToJson(this);
// }

@JsonSerializable()
class Answer {
  final int answerId;
  final String answerText;
  Answer({required this.answerId, required this.answerText});

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

@JsonSerializable()
class SliderAnswer extends Answer {
  final int sliderMin;
  final int sliderMax;
  SliderAnswer(
      {required int answerId,
      required String answerText,
      required this.sliderMin,
      required this.sliderMax})
      : super(answerId: answerId, answerText: answerText);

  factory SliderAnswer.fromJson(Map<String, dynamic> json) =>
      _$SliderAnswerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SliderAnswerToJson(this);
}
