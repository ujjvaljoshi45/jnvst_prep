import 'package:flutter/material.dart';
import 'package:jnvst_prep/models/question.dart';



class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _selectedOption = -1;
  Question question = Question(id: 'id', question: 'If x, y are two consecutive even numbers and y = 3602, then x =', options: [
    '3600',
    '3604',
     '3606',
    '3600 or 3604',
  ], correctOption: 3, subject: 'math');
  double _timeElapsed = 0.1;
  @override
  Widget build(BuildContext context) {
    double myWidth = getWidth(context) - 32;
    return Scaffold(
      backgroundColor: const Color(0XFF374898),
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded),onPressed: ()=>Navigator.pop(context),),
        backgroundColor: const Color(0XFF374898),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Maths Practice Test',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold,color: Colors.grey[300])),
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
                          width: myWidth * _timeElapsed - 8,
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
                          'Question 3/10',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          question.question,
                          style: const TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16.0),
                        for (int index = 0; index < question.options.length; index++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedOption = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
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
                                  question.options[index],
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
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
            color:  Colors.pink,
          ),
          child: const Center(child: Text('Next Question',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),),
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