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
      options: List.generate(json[optionsKey].length, (index) => json[optionsKey][index].toString(),),
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
  
  factory Question.demoQuestion() => Question(id: 'rF0XgKmkWAXnucttCOoC', question: "Consider the following statements regarding Infrastructure Investment Trusts (InvITs). An InviTs, is a pooled investment vehicle like a mutual fund. InviTs are mostly structured as trusts, on behalf of unit-holders. Which of the statements given above is/are correct?"
  , options: [
        "1 Only","2 Only","Both 1 and 2","Neither 1 nor 2"
      ], correctOption: 2, subject: 'demo_test');
}

String idKey = 'id';
String questionKey = 'question';
String optionsKey = 'options';
String correctOptionKey = 'correct_option';
String subjectKey = 'subject';
String createdAtKey = 'created_at';
