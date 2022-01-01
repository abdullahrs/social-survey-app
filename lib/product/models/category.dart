import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  late String id;
  late String name;
  late String color;
  late int rank;
  Category(
      {required this.id,
      required this.name,
      required this.color,
      required this.rank});
      
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
