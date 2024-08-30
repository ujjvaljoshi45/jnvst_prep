import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jnvst_prep/screens/test_page.dart';
import 'package:jnvst_prep/utils/tools.dart';

class HomePage extends StatefulWidget {
  final Function(int) goToPage;

  const HomePage({super.key, required this.goToPage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String,dynamic>> data = [
    {
      'id':0,
      'title':'JNVST Math Test',
      'subtitle':'Based on Latest Pattern',
      'bullet':FontAwesomeIcons.solidCircleCheck,
      'features': [
        'Challenge yourself.','Assess your skills.','Get feedback.',
      ],
      'icon':FontAwesomeIcons.solidCirclePlay,
      'color':card1,
      'shadow':Colors.yellow,
    },
    {
      'id':2,
      'title':'Chat with AI',
      'subtitle':'Ask questions, get answers instantly.',
      'bullet':FontAwesomeIcons.solidCircleCheck,
      'features': [
        'Get instant answers.','Have natural conversations.','Learn new things.',
      ],
      'icon':FontAwesomeIcons.wandMagicSparkles,
      'color':card2,
      'shadow':Colors.greenAccent
    },
    {
      'id':1,
      'title':'Get Your Score',
      'subtitle':'Check your latest test results.',
      'bullet':FontAwesomeIcons.solidCircleCheck,
      'features': [
        'Track your progress ',
      ],
      'icon':FontAwesomeIcons.marker,
      'color':card3,
      'shadow':Colors.greenAccent
    },
  ];

  _startTest(context) async {
    await getTDataProvider(context).init('demo',getUserProvider(context).user);
    Navigator.push(context,MaterialPageRoute(builder: (context) => const TestPage()));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor.withOpacity(0.4),
      height: getHeight(context) - kToolbarHeight - kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var content in data)
            _buildTestCard(content),
        ],
      ),
    );
  }

  _buildTestCard(Map<String,dynamic> content) => Padding(
    padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 4.0),
    child: Card(
      color: content['color'],
      elevation: 1.5,
      shadowColor: content['shadow'],
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r)
      ),
      child:  Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          onTap: () => widget.goToPage(content['id']),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(content['title'],style:heading),
              Text(content['subtitle'],style: subheading,),
              space(5.0.h),
            ],
          ),
          subtitle: Column(children: [
            for (String str in content['features'])
            Row(children: [FaIcon(content['bullet'],size: 14.sp,), Text('\t\t\t\t$str', style: listText,),],),
          ],),
          trailing: FaIcon(content['icon']),
        ),
      ),
    ),
  );
}

Color myColor = const Color.fromRGBO(130, 150, 237, 1);
Color card1 = const Color.fromRGBO(240, 201, 93, 1);
Color card2 = const Color.fromRGBO(110, 185, 155, 1);
Color card3 = const Color.fromRGBO(150, 120, 250, 1);
TextStyle heading =  GoogleFonts.montserrat(
  fontSize: 22.sp,
  color: Colors.brown.shade700,
  fontWeight: FontWeight.w600,
);
TextStyle subheading = GoogleFonts.montserrat(
  fontSize: 16.sp,
  color: Colors.brown.shade700,
  fontWeight: FontWeight.w500,
);
TextStyle listText = GoogleFonts.montserrat(
  fontSize: 13.sp,
  color: Colors.brown.shade700,
  fontWeight: FontWeight.w500,
);