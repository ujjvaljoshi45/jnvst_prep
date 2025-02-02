import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jnvst_prep/controllers/firebase_controller.dart';
import 'package:jnvst_prep/models/user_model.dart';
import 'package:jnvst_prep/screens/home.dart';
import 'package:jnvst_prep/utils/tools.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  static String route = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> _manageLogin() async {
    try {
      UserCredential userCredential = await _signInWithGoogle();
      if (userCredential.user == null) {
        return;
      } else {
        String uid = userCredential.user!.uid;
        UserModel? userModel = await FirebaseController.getUser(uid);
        if (userModel == null) {
          userModel ??= UserModel.fromFirebaseUser(userCredential.user!);
          FirebaseController.saveUser(userModel);
        }
        mounted ? getUserProvider(context).initProvider(userModel) : null;
        mounted ? Navigator.pushNamed(context, HomeScreen.route) : null;
      }
    } catch (e) {
      logError('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: getHeight(context) * 0.65,
                  width: getWidth(context),
                  child: Lottie.asset('assets/login_lottie.json')),
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(130, 150, 237, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 20,),
                        const Text(
                          'Ace Your Exams with Confidence',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                        const Text(
                          'Login to your account and start your journey to success.',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        space(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(9, 2, 96, 1),),

                                ),
                                onPressed: _manageLogin,
                                child:  const Text('Sign In With Google',style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
