import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  static const routeName = '/home-screen';

  const NavBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _current_index = 0;
  double bottomNavigationBarWidth = 42;
  double bottomNavigationBarBorderWidth = 1;
  final AuthService authService = AuthService();

  void _onTapIcon(int index) {
    setState(() {
      _current_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current_index,
        onTap: _onTapIcon,
        selectedItemColor: globalV.selectedNavBarColor,
        unselectedItemColor: globalV.unselectedNavBarColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavigationBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _current_index == 0
                          ? globalV.selectedNavBarColor
                          : globalV.unselectedNavBarColor,
                      width: bottomNavigationBarBorderWidth),
                ),
              ),
              child: GestureDetector(
                child: const Icon(Icons.home_outlined),
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavigationBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _current_index == 1
                          ? globalV.selectedNavBarColor
                          : globalV.unselectedNavBarColor,
                      width: bottomNavigationBarBorderWidth),
                ),
              ),
              child: GestureDetector(
                child: const Icon(Icons.add),
              ),
            ),
            label: "Add feeds",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavigationBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _current_index == 2
                          ? globalV.selectedNavBarColor
                          : globalV.unselectedNavBarColor,
                      width: bottomNavigationBarBorderWidth),
                ),
              ),
              child: GestureDetector(
                child: const Icon(Icons.logout),
                onTap: () => authService.logoutUser(context),
              ),
            ),
            label: "Logout",
          ),
        ],
      ),
    );
  }
}
