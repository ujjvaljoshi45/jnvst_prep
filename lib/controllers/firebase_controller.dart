import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jnvst_prep/models/exam_model.dart';
import 'package:jnvst_prep/models/question.dart';
import 'package:jnvst_prep/models/user_model.dart';
import 'package:jnvst_prep/utils/tools.dart';

abstract class FirebaseController {
  static CollectionReference users = FirebaseFirestore.instance.collection('users');
  static CollectionReference questionsCollection = FirebaseFirestore.instance.collection('questions');

  static Future<void> saveUser(UserModel user) async {
    try{
      await users.doc(user.uid).set(user.toJson());
    } catch (e) {
      logError('saveUser()',e.toString());
    }
  }

  static Future<UserModel?> getUser(String uid) async {
    try{
      final response = await users.doc(uid).get();
      final data = response.data() as Map<String,dynamic>;
      return UserModel.fromJson(data);
    } catch (e) {
      logError('getUser()',e.toString());
      return null;
    }
  }

  static Future<List<Question>> getDemoQuestions() async {
    List<Question> questions = [];
    final response = await questionsCollection.doc('demo').get();
    Question question =  Question.fromJson(response.data() as Map<String,dynamic>);

    questions = List.generate(10, (index) => question,);
    return questions;
  }

  static Future<void> saveTest(String uid, ExamModel examModel) async {
    await users.doc(uid).collection('myTests').add(examModel.toJson());
  }
  
  static Future<List<ExamModel>> getTests(String uid) async {
    List<ExamModel> results = [];
    final response = await users.doc(uid).collection('myTests').get();
    for (int i = 0; i < response.docs.length; i++) {
      results.add(ExamModel.fromJson(response.docs[i].data() as Map<String, dynamic>));
      results.last.id = response.docs[i].id;
    }
    return results;
  }
}