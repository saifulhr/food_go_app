import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_go_app/view/favourite/favourite_screen.dart';
import 'package:food_go_app/view/profile/profile_screen.dart';
import 'package:food_go_app/theme/all_images.dart';
import 'package:food_go_app/view/home/home_screen.dart';
import 'package:food_go_app/view/product/add_product_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomeScreen(),
    ProfileScreen(),
    AddProductScreen(),
    Center(child: Text("Messages Page")),
    FavouriteScreen()
  ];

  final List<String> icons = [
    AllImages.homeIcon,
    AllImages.userIcon,
    AllImages.addIcon,
    AllImages.chatIcon,
    AllImages.fieldfavouriteIcon,
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
        height: 75,
        backgroundColor: Colors.transparent,
        color: const Color(0xFFE53E3E),
        buttonBackgroundColor: const Color(0xFFE53E3E),
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: List.generate(icons.length, (index) {
          bool isSelected = index == _currentIndex;

          double containerSize = isSelected ? 43 : 25;

          return Container(
            width: containerSize,
            height: containerSize,
            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFE53E3E) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              icons[index],
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          );
        }),
      ),
    );
  }
}
