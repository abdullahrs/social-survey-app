// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      surveyId: json['surveyId'] as String,
      location: UserLocation.fromJson(json['location'] as Map<String, dynamic>),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => UserAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'surveyId': instance.surveyId,
      'location': instance.location.toJson(),
      'answers': instance.answers.map((e) => e.toJson()).toList(),
    };

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) => UserLocation(
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
    );

Map<String, dynamic> _$UserLocationToJson(UserLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };

UserAnswer _$UserAnswerFromJson(Map<String, dynamic> json) => UserAnswer(
      questionType: $enumDecode(_$QuestionTypeEnumMap, json['questionType']),
      questionId: json['questionId'] as int,
      answer: json['answer'],
    );

Map<String, dynamic> _$UserAnswerToJson(UserAnswer instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      (instance.questionType == QuestionType.multipleChoice
          ? 'multipleChoiceValue'
          : instance.questionType == QuestionType.slider
              ? 'sliderValue'
              : 'rankingValue'): instance.answer,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.slider: 'slider',
  QuestionType.ranking: 'ranking',
  QuestionType.multipleChoice: 'multiple-choice',
};
