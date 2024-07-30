import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jnvst_prep/models/user_model.dart';
import 'package:jnvst_prep/screens/home.dart';
import 'package:jnvst_prep/utils/tools.dart';


class LoginScreen extends StatefulWidget {
  static String route = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> _manageLogin() async {
    UserCredential userCredential = await _signInWithGoogle();
    if (userCredential.user == null) {
      return;
    } else {
      // Save User to State Manager And
      UserModel user = UserModel.fromFirebaseUser(userCredential.user!);
      getUserProvider(context).initProvider(user);
      Navigator.pushNamed(context, HomeScreen.route);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _manageLogin, child: const Text('Sign In With Google'))
            ],
          ),
        ),
      ),
    );
  }
}
