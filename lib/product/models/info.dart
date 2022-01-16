import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class Info {
  String? role;
  String? name;
  String? email;
  String? id;
  final bool isEmailVerified;
  final List<String>? submittedSurveys;

  Info({
    this.role,
    this.name,
    this.email,
    this.id,
    required this.isEmailVerified,
    this.submittedSurveys,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
