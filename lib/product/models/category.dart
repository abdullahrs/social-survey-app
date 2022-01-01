import '../constants/app_constants/hive_type_constants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConstants.categoriesTypeID)
class Category {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String color;
  @HiveField(3)
  final int rank;
  Category(
      {required this.id,
      required this.name,
      required this.color,
      required this.rank});
      
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
