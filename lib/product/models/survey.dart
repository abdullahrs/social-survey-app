import 'package:json_annotation/json_annotation.dart';

import 'question.dart';

part 'survey.g.dart';

@JsonSerializable(explicitToJson: true)
class Survey {
  final String id;
  final String name;
  final String description;
  // final bool status;
  final String categoryId;
  final int submissionCount;
  // final String color;
  final String? expireDate;
  final List<Question> questions;

  Survey({
    required this.id,
    required this.name,
    required this.description,
    // required this.status,
    required this.categoryId,
    required this.submissionCount,
    // required this.color,
    required this.questions,
    this.expireDate
  });

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyToJson(this);
}
