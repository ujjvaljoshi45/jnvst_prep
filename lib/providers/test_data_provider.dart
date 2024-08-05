import 'package:flutter/foundation.dart';
import 'package:jnvst_prep/models/question.dart';
import 'package:jnvst_prep/utils/tools.dart';

class TestDataProvider extends ChangeNotifier {
  String currentTestName = 'Math Practice Test';
  List<Question>? questions;
  int currentQuestion = 0;
  List<int> selection = List.generate(10, (index) => -1,);
  double get percentageCompleted => currentQuestion/questions!.length > 0 ? currentQuestion/questions!.length : 0.1;

  bool get testInitDone => questions != null;
  bool get isLastQuestions => currentQuestion == questions!.length;
  Future<void> initTest(String testName) async {
    currentTestName = testName;
    // Load Questions from firebase
    questions = [];
    questions!.add(Question(id: 'id', question: 'If x, y are two consecutive even numbers and y = 3602, then x =', options: [
      '3600',
      '3604',
      '3606',
      '3600 or 3604',
    ], correctOption: 3, subject: 'math'));
    questions!.add(questions!.first);
    questions!.add(questions!.first);
    questions!.add(questions!.first);
    questions!.add(questions!.first);
    currentQuestion = 0;
    selection = List.generate(10, (index) => -1,);
  }

  void saveAnswer(int myAns) {
    selection[currentQuestion] = myAns;
  }

  void nextQuestion() async {
    if (questions != null) {
      if (questions!.length > currentQuestion) {
        currentQuestion++;
      } else {
        await uploadResult();
      }
    }
    notifyListeners();
  }
  void previousQuestion() {
    if(questions != null) {
      if (currentQuestion > 1) {
        currentQuestion--;
      }
    }
    notifyListeners();
  }
  Future<void> uploadResult() async {logEvent('Saved!');}
}