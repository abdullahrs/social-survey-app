import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  final String surveyId;
  final UserLocation location;
  final List<UserAnswer> answers;

  Post({required this.surveyId, required this.location, required this.answers});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class UserLocation {
  final double lat;
  final double long;

  UserLocation({required this.lat, required this.long});

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserAnswer {
  final int questionId;
  final int answerId;

  UserAnswer({required this.questionId, required this.answerId});

  factory UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$UserAnswerToJson(this);
}
