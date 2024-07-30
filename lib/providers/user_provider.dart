import 'package:flutter/material.dart';
import 'package:jnvst_prep/controllers/firebase_controller.dart';
import 'package:jnvst_prep/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel user;
  void initProvider(UserModel user) async {
    this.user = user;
  }

  Future<UserModel?> getUserFromDatabase(String uid) async {
    UserModel? updatedUser =  await FirebaseController.getUser(uid);
    if (updatedUser != null) {
      user = updatedUser;
    }
    return updatedUser;
  }
}