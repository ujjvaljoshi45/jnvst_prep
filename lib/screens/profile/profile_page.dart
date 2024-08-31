import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jnvst_prep/controllers/firebase_controller.dart';
import 'package:jnvst_prep/models/exam_model.dart';
import 'package:jnvst_prep/models/user_model.dart';
import 'package:jnvst_prep/screens/auth/login.dart';
import 'package:jnvst_prep/utils/tools.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserModel user;
  List<ExamModel> results = [];
  @override
  void initState() {
    user = getUserProvider(context).user;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    results = await FirebaseController.getTests(user.uid);
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context) - kToolbarHeight - kBottomNavigationBarHeight,
      width: getWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          space(20),
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.imageUrl),
            maxRadius: getWidth(context) * 0.15,
          ),
          space(20),
          Text(
            user.displayName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          space(20),
          SizedBox(
            height: getHeight(context) * 0.4,
              child: ListTile(
                title: const Text('Test Results',style: TextStyle(fontSize: 17),),
                subtitle: ScoreCard(
                            results: results,
                          ),
              )),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.2),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _manageSignOut,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          space(10),
        ],
      ),
    );
  }
  _manageSignOut() async {
    await FirebaseAuth.instance.signOut();
    mounted? Navigator.pushReplacementNamed(context, LoginScreen.route,) : null;
  }
}

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.results});
  final List<ExamModel> results;
  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(child: Text("No Tests Found!"));
    }
    return Card(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(results[index].name),
              subtitle: Text("My Score:${results[index].myScore}"),
            ),
          );
        },
        itemCount: results.length,
      ),
    );
  }
}

class PastExamScores extends StatelessWidget {
  const PastExamScores({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
