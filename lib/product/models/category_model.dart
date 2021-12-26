class CategoryModel {
  late String id;
  late String name;
  late String color;
  late int rank;
  CategoryModel({required this.id, required this.name, required this.color, required this.rank});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['rank'] = rank;
    return data;
  }
}
