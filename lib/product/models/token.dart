import 'package:anket/product/constants/app_constants/hive_type_constants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: HiveConstants.tokenTypeID)
class Tokens {
  @HiveField(0)
  late final Access access;
  @HiveField(1)
  late final Access refresh;

  Tokens({required this.access, required this.refresh});

  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);

  Map<String, dynamic> toJson() => _$TokensToJson(this);
}

@JsonSerializable()
@HiveType(typeId: HiveConstants.accessTypeID)
class Access {
  @HiveField(0)
  late final String token;
  @HiveField(1)
  late final String expires;

  Access({required this.token, required this.expires});

  factory Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);

  Map<String, dynamic> toJson() => _$AccessToJson(this);
}
