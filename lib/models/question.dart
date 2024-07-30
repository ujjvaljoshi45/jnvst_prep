class Question {
  String id;
  String question;
  List<String> options;
  int correctOption;
  String subject;
  DateTime createdAt = DateTime.now();

  Question(
      {required this.id,
      required this.question,
      required this.options,
      required this.correctOption,
      required this.subject});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
      id: json[idKey],
      question: json[questionKey],
      options: List.generate(json[optionsKey].length, (index) => json[optionsKey].toString(),),
      correctOption: json[correctOptionKey],
      subject: json[subjectKey])
    ..createdAt = json[createdAtKey].toDate();

  Map<String,dynamic> toJson() => {
    idKey : id,
    questionKey: question,
    optionsKey: options,
    correctOptionKey: correctOption,
    subjectKey: subject,
    createdAtKey: createdAt
  };
}

String idKey = 'id';
String questionKey = 'question';
String optionsKey = 'options';
String correctOptionKey = 'correct_option';
String subjectKey = 'subject';
String createdAtKey = 'created_at';
