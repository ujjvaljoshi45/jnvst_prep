import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jnvst_prep/screens/chat/chat_screen.dart';
import 'package:jnvst_prep/screens/profile/profile_page.dart';

import 'home/home_page.dart';

class HomeScreen extends StatefulWidget {
  static String route = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  int _currentIndex = 0;
  _managePageChange(value) {
    if (value == -1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ));
    } else {
      _currentIndex = value;
      _pageController.jumpToPage(_currentIndex);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const Text('JNVST Navigator'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _managePageChange,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: 'Profile',
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            HomePage(goToPage: (index) => _managePageChange(index)),
            const ProfilePage(),
          ],
        ),
      ),
    );
  }
}
