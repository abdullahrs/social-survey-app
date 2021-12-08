class SurveyListModel {
  late int surveyID;
  late String title;
  late String desc;
  late bool status;
  late String category;
  late int numberOfSolve;
  late String color;

  SurveyListModel(
      {required this.surveyID,
      required this.title,
      required this.desc,
      required this.status,
      required this.category,
      required this.numberOfSolve,
      required this.color});

  SurveyListModel.fromJson(Map<String, dynamic> json) {
    surveyID = json['surveyID'];
    title = json['title'];
    desc = json['desc'];
    status = json['status'];
    category = json['category'];
    numberOfSolve = json['numberOfSolve'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['surveyID'] = surveyID;
    data['title'] = title;
    data['desc'] = desc;
    data['status'] = status;
    data['category'] = category;
    data['numberOfSolve'] = numberOfSolve;
    data['color'] = color;
    return data;
  }
}
