import 'package:flutter/material.dart';
import 'package:jnvst_prep/screens/test_page.dart';
import 'package:jnvst_prep/utils/tools.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () async {
          await getTDataProvider(context).init('demo',getUserProvider(context).user);
          Navigator.push(context,MaterialPageRoute(builder: (context) => const TestPage()));
    }, child: const Text('Take Test'))
      ],
    );
  }
}
