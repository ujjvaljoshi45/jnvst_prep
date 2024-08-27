import 'package:jnvst_prep/models/question.dart';

class ExamModel {
  String name;
  String id;
  List<Question> questions;
  int totalScore;
  int myScore;
  ExamModel(
      {required this.id,
      required this.name,
      required this.totalScore,
      required this.myScore,
      required this.questions});

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
        id: '-1',
        name: json['name'],
        totalScore: json['total_score'],
        myScore: json['my_score'],
        questions: List.generate(json['questions'].length, (index) => Question.fromJson(json['questions'][index] as Map<String,dynamic>),)
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'total_score': totalScore,
        'my_score': myScore,
        'questions': List.generate(
          10,
          (index) => questions[index].toJson(),
        )
      };
}
