import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:jnvst_prep/models/exam_model.dart';
import 'package:jnvst_prep/test_page.dart';
import 'package:ticket_widget/ticket_widget.dart';

class ResultPage extends StatelessWidget {
  final ExamModel exam;

  const ResultPage({super.key, required this.exam,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 16.0),
        child: TicketWidget(
            width: getWidth(context),
            height: 250,
            isCornerRounded: true,
            color: const Color(0XFF374898),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             const Text('You Have Scored',style: TextStyle(
              fontSize: 24, color: Colors.white,fontWeight: FontWeight.w600
            ),),
            const DottedLine(dashColor: Colors.white,lineThickness: 2,),
            Text("${(exam.myScore/exam.totalScore)*100}%", style: const TextStyle(
                fontSize: 24, color: Colors.white,fontWeight: FontWeight.w600
            )),
          ],
        )),
      ),
    ));
  }
}
