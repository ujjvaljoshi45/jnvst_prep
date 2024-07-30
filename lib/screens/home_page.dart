import 'package:flutter/material.dart';
import 'package:jnvst_prep/screens/test_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const TestPage(),)), child: const Text('Take Test'))
      ],
    );
  }
}
