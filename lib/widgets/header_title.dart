import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.0.w,
      padding: EdgeInsets.symmetric(horizontal: 2.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.0.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "whatever_you_are_looking_for".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "about_it_app".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
        ],
      ),
    );
  }
}
