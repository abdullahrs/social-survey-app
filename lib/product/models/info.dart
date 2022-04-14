import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class Info {
  String? role;
  String? name;
  String? email;
  String? id;
  String? birthdate;
  String? gender;
  bool? isEmailVerified;
  List<String>? submittedSurveys;

  Info({
    this.role,
    this.name,
    this.email,
    this.id,
    this.isEmailVerified,
    this.submittedSurveys,
    this.birthdate,
    this.gender
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
