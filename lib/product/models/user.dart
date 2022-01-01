import 'package:json_annotation/json_annotation.dart';

import 'token.dart';
import 'info.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  Info? user;
  Tokens? tokens;

  User({required this.user, required this.tokens});

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
