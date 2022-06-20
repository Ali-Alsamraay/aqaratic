import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.0.h,
      width: 88.0.w,
      margin: EdgeInsets.symmetric(horizontal: 2.0.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0.sp,
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 5.0.w,
          ),
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 25.0.sp,
          ),
          SizedBox(
            width: 5.0.w,
          ),
          Expanded(
            child: SizedBox(
              child: TextFormField(
                onChanged: (keyWors) {
                  Provider.of<PropertiesProvider>(context, listen: false)
                      .searchByTitle(keyWors);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'searching_for'.tr,
                  hintStyle: TextStyle(
                    color: Color(0xffb3bbcb),
                    fontSize: 17.0.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
