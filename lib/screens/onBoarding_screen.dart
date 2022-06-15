import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

import '../helper/constants.dart';
import 'main_screen.dart';

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "professional_search".tr,
      "text": "professional_search_subject".tr,
      "image": "assets/images/boarding_1.png"
    },
    {
      "title": "advertise_your_property".tr,
      "text": "advertise_your_property_subject".tr,
      "image": "assets/images/boarding_2.png"
    },
    {
      "title": "real_estate_services".tr,
      "text": "real_estate_services_subject".tr,
      "image": "assets/images/boarding_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 100.0.w,
            height: 100.0.h,
            child: PageView.builder(
              reverse: true,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      splashData[index]['image']!,
                    ),
                  ),
                ),
                child: SplashContent(
                  text: splashData[index]['text'],
                  title: splashData[index]["title"],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 100.0.w,
              margin: EdgeInsets.symmetric(horizontal: 0.0.w, vertical: 4.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 2.0.w),
                    height: 5.0.h,
                    child: Row(
                      children: [
                        ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              buildDot(index: index),
                          itemCount: splashData.length,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 5.0.h,
                    margin: EdgeInsets.only(right: 2.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();

                            await sharedPreferences.setBool(
                                "show-boarding", false);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 22.0.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.symmetric(
        horizontal: 1.5.w,
      ),
      padding: EdgeInsets.all(
        5.0.sp,
      ),
      width: 2.5.w,
      height: 2.5.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            currentPage == index ? accentColorBrown.withBlue(50) : Colors.white,
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    @required this.text,
    @required this.title,
  }) : super(key: key);
  final String? text, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title!,
          style: TextStyle(
            color: accentColorBrown,
            fontSize: 23.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8.0.h,
        ),
        Flexible(
          child: Container(
            width: 70.0.w,
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
