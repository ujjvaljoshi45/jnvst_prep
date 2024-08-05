import 'package:flutter/material.dart';
import 'package:jnvst_prep/models/question.dart';
import 'package:jnvst_prep/providers/test_data_provider.dart';
import 'package:jnvst_prep/utils/tools.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _selectedOption = -1;
  @override
  Widget build(BuildContext context) {
    double myWidth = getWidth(context) - 32;
    return Scaffold(
      backgroundColor: const Color(0XFF374898),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => getTDataProvider(context).previousQuestion(),
        ),
        backgroundColor: const Color(0XFF374898),
      ),
      body: Consumer<TestDataProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value.currentTestName,
                    style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[300])),
                const SizedBox(height: 16.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Stack(
                          children: [
                            Container(
                              height: 40,
                              width: myWidth,
                              color: const Color(0XFF2C3B7D),
                            ),
                            Container(
                              margin: const EdgeInsets.all(3.0),
                              padding: const EdgeInsets.only(left: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.teal,
                              ),
                              height: 40,
                              width: myWidth * value.percentageCompleted - 8,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Flexible(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Question ${getTDataProvider(context).currentQuestion + 1}/${getTDataProvider(context).questions!.length}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade500),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              value.questions![value.currentQuestion].question,
                              style: const TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16.0),
                            for (int index = 0;
                                index <
                                    value.questions![value.currentQuestion]
                                        .options.length;
                                index++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedOption = index;
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: _selectedOption == index
                                        ? Colors.green[50]
                                        : Colors.white,
                                    border: Border.all(
                                      color: _selectedOption == index
                                          ? Colors.green
                                          : Colors.grey,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      value.questions![value.currentQuestion]
                                          .options[index],
                                      style: TextStyle(
                                        color: _selectedOption == index
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    ),
                                    trailing: _selectedOption == index
                                        ? const Icon(Icons.check_circle,
                                            color: Colors.green)
                                        : null,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: InkWell(
          onTap: () {
            getTDataProvider(context).saveAnswer(_selectedOption+1);
            getTDataProvider(context).nextQuestion();},
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              color: Colors.pink,
            ),
            child: const Center(
              child: Text(
                'Next Question',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

getWidth(context) => MediaQuery.sizeOf(context).width;
getHeight(context) => MediaQuery.sizeOf(context).height;

class Option {
  final String text;
  Option(this.text);
}


