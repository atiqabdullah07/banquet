import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Views/Screens/Banquet/Banquet%20Dashboard/banquet_dashboard.dart';
import 'package:banquet/Views/Screens/Banquet/Banquet%20Profile/banquet_profile.dart';

import 'package:banquet/Views/Screens/Chats/conversations.dart';

import 'package:flutter/material.dart';

class BanquetHome extends StatefulWidget {
  const BanquetHome({super.key});

  @override
  State<BanquetHome> createState() => _HomeState();
}

class _HomeState extends State<BanquetHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BanquetDashboard(),
    Conversations(),
    BanquetProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.black.withOpacity(0.5),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
