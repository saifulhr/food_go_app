import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
  
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 70.0,
        items: <CurvedNavigationBarItem>[
          CurvedNavigationBarItem(
            child: Icon(Icons.home, size: 27, color: Colors.white),
            label: '',
            labelStyle: TextStyle(color: Colors.white)
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person, size: 27, color: Colors.white),
            label: '',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add, size: 27, color: Colors.white),
            label: '',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.message_sharp, size: 27, color: Colors.white),
            label: '',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.favorite, size: 27, color: Colors.white),
            label: '',
          ),
        ],
        color: Color(0xFFE53E3E),
        buttonBackgroundColor: Color(0xFFE53E3E),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}