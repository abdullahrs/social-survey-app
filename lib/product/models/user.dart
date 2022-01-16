import 'package:json_annotation/json_annotation.dart';

import 'info.dart';
import 'token.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final Info? user;
  final Tokens? tokens;

  User({required this.user, required this.tokens});

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
