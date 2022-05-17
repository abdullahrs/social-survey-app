// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      questionType: $enumDecode(_$QuestionTypeEnumMap, json['questionType']),
      questionId: json['questionId'] as int,
      questionText: json['questionText'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => json['questionType'] != 'slider'
              ? Answer.fromJson(e as Map<String, dynamic>)
              : SliderAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'questionType': _$QuestionTypeEnumMap[instance.questionType],
      'questionId': instance.questionId,
      'questionText': instance.questionText,
      'answers': instance.answers.map((e) => e.toJson()).toList(),
    };

const _$QuestionTypeEnumMap = {
  QuestionType.slider: 'slider',
  QuestionType.ranking: 'ranking',
  QuestionType.multipleChoice: 'multiple-choice',
};
