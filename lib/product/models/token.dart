import 'package:anket/product/constants/app_constants/hive_type_constants.dart';
import 'package:hive_flutter/adapters.dart';

part 'token.g.dart';

// dart run build_runner build

@HiveType(typeId: HiveConstants.tokenTypeID)
class Tokens {
  @HiveField(0)
  late final Access access;
  @HiveField(1)
  late final Access refresh;

  Tokens({required this.access, required this.refresh});

  Tokens.fromJson(Map<String, dynamic> json) {
    access = (json['access'] != null ? Access.fromJson(json['access']) : null)!;
    refresh =
        (json['refresh'] != null ? Access.fromJson(json['refresh']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['access'] = access.toJson();
    data['refresh'] = refresh.toJson();
    return data;
  }
}

@HiveType(typeId: HiveConstants.accessTypeID)
class Access {
  @HiveField(0)
  late final String token;
  @HiveField(1)
  late final String expires;

  Access({required this.token, required this.expires});

  Access.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['token'] = token;
    data['expires'] = expires;
    return data;
  }
}
