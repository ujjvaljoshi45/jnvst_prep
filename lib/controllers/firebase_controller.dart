import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jnvst_prep/models/user_model.dart';
import 'package:jnvst_prep/utils/tools.dart';

abstract class FirebaseController {
  static CollectionReference users = FirebaseFirestore.instance.collection('users');

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
}