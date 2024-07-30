import 'package:flutter/material.dart';
import 'package:jnvst_prep/screens/profile_page.dart';

import 'home_page.dart';

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
    _currentIndex = value;
    _pageController.jumpToPage(_currentIndex);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const Text('JNVST PREP'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _managePageChange,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home',activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: 'Profile',activeIcon:Icon(Icons.person)),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            HomePage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
