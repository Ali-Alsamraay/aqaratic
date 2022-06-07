import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/screens/adding_new_service_screen.dart';
import 'package:aqaratak/screens/home_screen.dart';
import 'package:aqaratak/screens/maps/map_screen.dart';
import 'package:aqaratak/screens/profile_screen.dart';
import 'package:aqaratak/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'filtration/filtration_screen.dart';

class MainScreen extends StatefulWidget {
  static const String screenName = "main-screen";
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int navigationBarIndex = 0;
  List<Widget> tabScreens = [
    HomeScreen(),
    FiltrationScreen(),
    AddingNewService(),
    MapsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: backgroundColor,
          body: Container(
            width: 100.0.w,
            height: 100.0.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home_background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: tabScreens[navigationBarIndex],
          ),
          bottomNavigationBar: _bottomBar(),
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      height: 7.3.h,
      margin: EdgeInsets.only(
        right: 3.5.w,
        left: 3.5.w,
        top: 1.5.h,
        bottom: 2.0.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0.sp),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        textDirection: TextDirection.rtl,
        children: [
          _bottomNavigationIcon(
            0,
            "home",
          ),
          _bottomNavigationIcon(
            1,
            "search",
          ),
          _bottomNavigationIcon(
            2,
            "plus",
          ),
          _bottomNavigationIcon(
            3,
            "maps",
          ),
          _bottomNavigationIcon(
            4,
            "person",
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationIcon(
    int index,
    String iconPath,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          navigationBarIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 2.0.w,
        ),
        height: 10.0.w,
        width: 10.0.w,
        child: Container(
          padding: EdgeInsets.all(4.0.sp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: navigationBarIndex == index ? accentColorBrown : null,
          ),
          child: Image.asset(
            "assets/icons/$iconPath.png",
            height: 2.0.w,
            width: 2.0.w,
            color: navigationBarIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
