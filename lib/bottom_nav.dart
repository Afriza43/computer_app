import 'package:computer_app/cart.dart';
import 'package:computer_app/home.dart';
import 'package:computer_app/profil.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: [HomePage(), ProfilePage(), CartPage()],
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.black87,
        mainAxisAlignment: MainAxisAlignment.center,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentIndex = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.white : Colors.grey,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: _currentIndex == 0 ? Colors.white : Colors.grey,
              ),
            ),
            activeColor: Colors.transparent,
          ),
          BottomBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 1 ? Colors.white : Colors.grey,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: _currentIndex == 1 ? Colors.white : Colors.grey,
              ),
            ),
            activeColor: Colors.transparent,
          ),
          BottomBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: _currentIndex == 1 ? Colors.white : Colors.grey,
            ),
            title: Text(
              'Cart',
              style: TextStyle(
                color: _currentIndex == 1 ? Colors.white : Colors.grey,
              ),
            ),
            activeColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
