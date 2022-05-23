import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../helper/constants.dart';

class TitleBuilder extends StatelessWidget {
  const TitleBuilder({Key? key,required this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        child: Container(
          width: 85.0.w,
          padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.5.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10.0.sp),
            border: Border.all(
              width: 1.0.sp,
              color: accentColorBrown,
            ),
          ),
          child: Center(
            child: Text(
              title!,
              style: TextStyle(
                color: accentColorBlue,
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
