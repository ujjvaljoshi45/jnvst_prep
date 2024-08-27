import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String uid;
  String displayName;
  String email;
  List<String> examIds = [];
  String imageUrl;

  UserModel(
      {required this.uid, required this.displayName, required this.email, required this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json[uidKey],
        displayName: json[displayNameKey],
        email: json[emailKey],imageUrl: json[imageUrlKey])
      ..examIds = List.generate(
        json[examIdsKey].length,
        (index) => json[examIdsKey][index].toString(),
      );

  factory UserModel.fromFirebaseUser(User user) => UserModel(uid: user.uid, displayName: user.displayName ?? 'User', email: user.email ?? 'null', imageUrl: user.photoURL ?? '');

  Map<String, dynamic> toJson() => {
        uidKey: uid,
        displayNameKey: displayName,
        emailKey: email,
        examIdsKey: examIds,
    imageUrlKey: imageUrl,
      };
}

String uidKey = 'uid';
String displayNameKey = 'display_name';
String emailKey = 'email';
String examIdsKey = 'exam_ids';
String imageUrlKey = 'image_url';