// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      answerId: json['answerId'] as int,
      answerText: json['answerText'] as String,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'answerId': instance.answerId,
      'answerText': instance.answerText,
    };

SliderAnswer _$SliderAnswerFromJson(Map<String, dynamic> json) => SliderAnswer(
      answerId: json['answerId'] as int,
      answerText: json['answerText'] as String,
      sliderMin: json['sliderMin'] as int,
      sliderMax: json['sliderMax'] as int,
    );

Map<String, dynamic> _$SliderAnswerToJson(SliderAnswer instance) =>
    <String, dynamic>{
      'answerId': instance.answerId,
      'answerText': instance.answerText,
      'sliderMin': instance.sliderMin,
      'sliderMax': instance.sliderMax,
    };
