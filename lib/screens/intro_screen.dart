import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/screens/register_mobile_screen.dart';
import 'package:aqaratak/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../models/intro_screen_model.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  // Making list of pages needed to pass in IntroViewsFlutter constructor.

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(children: <Widget>[
            Image.asset(
              'assets/images/intro_background.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            IntroductionScreen(
              controlsPosition: Position(right: 0.0.w, bottom: 0, left: 50.0.w),
              globalBackgroundColor: Colors.transparent,
              pages: listPagesViewModel,
              onDone: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterMobileScreen()));
              },
              onSkip: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterMobileScreen()));
              },
              showSkipButton: true,
              skip: const Text(
                "إلغاء",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              next: const Icon(null),
              done: const Text(
                "تم",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
          

              dotsDecorator: DotsDecorator(
                size: Size(
                  2.0.w,
                  2.0.w,
                ),
                activeSize: Size(
                  2.0.w,
                  2.0.w,
                ),
                activeColor: accentColorBrown,
                color: Color.fromARGB(255, 40, 31, 31),
                spacing: EdgeInsets.symmetric(horizontal: 2.0.w),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0.sp),
                ),
              ),
            ),
          ]) //Material App

          ),
    );
  }
}
