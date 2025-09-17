import 'package:bunyo/screen/first_page.dart';
import 'package:bunyo/screen/posts_page/view/posts_page.dart';
import 'package:bunyo/screen/second_page.dart';
import 'package:bunyo/screen/third_page.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
    const PostsPage(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedIconTheme: const IconThemeData(size: 32),
        unselectedIconTheme: const IconThemeData(size: 24),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: 'Birinci',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.looks_two), label: 'İkinci'),
          BottomNavigationBarItem(icon: Icon(Icons.looks_3), label: 'Üçüncü'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'PostsPage'),

        ],
      ),
    );
  }
}
