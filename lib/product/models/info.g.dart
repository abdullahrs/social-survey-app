// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      role: json['role'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      id: json['id'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool,
      submittedSurveys: (json['submittedSurveys'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'role': instance.role,
      'name': instance.name,
      'email': instance.email,
      'id': instance.id,
      'isEmailVerified': instance.isEmailVerified,
      'submittedSurveys': instance.submittedSurveys,
    };
