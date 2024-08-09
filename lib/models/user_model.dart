import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String uid;
  String displayName;
  String email;
  List<String> examIds = [];

  UserModel(
      {required this.uid, required this.displayName, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json[uidKey],
        displayName: json[displayNameKey],
        email: json[emailKey])
      ..examIds = List.generate(
        json[examIdsKey].length,
        (index) => json[examIdsKey][index].toString(),
      );

  factory UserModel.fromFirebaseUser(User user) => UserModel(uid: user.uid, displayName: user.displayName ?? 'User', email: user.email ?? 'null');

  Map<String, dynamic> toJson() => {
        uidKey: uid,
        displayNameKey: displayName,
        emailKey: email,
        examIdsKey: examIds,
      };
}

String uidKey = 'uid';
String displayNameKey = 'display_name';
String emailKey = 'email';
String examIdsKey = 'exam_ids';
