import 'package:flutter/material.dart';
import 'package:jnvst_prep/controllers/firebase_controller.dart';
import 'package:jnvst_prep/models/exam_model.dart';
import 'package:jnvst_prep/models/question.dart';
import 'package:jnvst_prep/models/user_model.dart';
import 'package:jnvst_prep/screens/result_page.dart';
import 'package:jnvst_prep/utils/tools.dart';

class TestDataProvider extends ChangeNotifier {
  bool isDone = false;
  String currentTestName = 'Math Practice Test';
  UserModel? userModel;
  List<Question>? questions;
  int currentQuestion = 0;
  List<int> selection = List.generate(
    10,
    (index) => -1,
  );
  double get percentageCompleted => currentQuestion/questions!.length > 0 ? currentQuestion/questions!.length : 0.1;
  DateTime startTime = DateTime.now();

  bool get testInitDone => questions != null;
  bool get isLastQuestions => currentQuestion == questions!.length;
  Future<void> init(String subject, UserModel userModel) async {
    this.userModel = userModel;
    questions = await FirebaseController.getDemoQuestions();
    startTime = DateTime.now();
    currentQuestion = 0;

  }
  // Future<void> initTest(String testName) async {
  //   currentTestName = testName;
  //   // Load Questions from firebase
  //   questions = [];
  //   questions!.add(Question(
  //       id: 'id',
  //       question:
  //           'If x, y are two consecutive even numbers and y = 3602, then x =',
  //       options: [
  //         '3600',
  //         '3604',
  //         '3606',
  //         '3600 or 3604',
  //       ],
  //       correctOption: 3,
  //       subject: 'math'));
  //   questions!.add(questions!.first);
  //   questions!.add(questions!.first);
  //   questions!.add(questions!.first);
  //   questions!.add(questions!.first);
  //   currentQuestion = 0;
  //   selection = List.generate(
  //     10,
  //     (index) => -1,
  //   );
  // }

  void saveAnswer(int myAns) {
    selection[currentQuestion] = myAns;
  }

  void nextQuestion(context) async {
    if (questions != null) {
      if (questions!.length > currentQuestion + 1) {
        currentQuestion++;
      } else {
        await uploadResult(context);
      }
    }
    notifyListeners();
  }

  void previousQuestion() {
    if (questions != null) {
      if (currentQuestion >= 1) {
        currentQuestion--;
      }
    }
    notifyListeners();
  }

  Future<void> uploadResult(context) async {
    if (!isDone) {
      ExamModel examModel = ExamModel(id: 'test1', name: 'Test Name', totalScore: questions!.length, myScore: calculateScore(), questions: questions!);
      await FirebaseController.saveTest(userModel!.uid,examModel);
      logEvent('Saved!');
      isDone = true;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ResultPage(exam: ExamModel(id: '-1', name: 'demo', totalScore: 10, myScore: calculateScore(), questions: questions!),)));
    }
    notifyListeners();

  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions!.length; i++) {
      if (questions![i].correctOption == selection[i]) {
        score++;
      }
    }
    return score;
  }

  void clear() {
    isDone = false;
    questions = null;
    currentQuestion = 0;
    selection = List.generate(
      10,
          (index) => -1,
    );
  }
}
