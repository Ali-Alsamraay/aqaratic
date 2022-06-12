import 'package:aqaratak/helper/constants.dart';
import 'package:flutter/material.dart';
import "package:sizer/sizer.dart";

class GeneralDropDownMenu extends StatefulWidget {
  final String? title;
  final List<dynamic>? options;
  final Function(dynamic)? onSelected;

  GeneralDropDownMenu({
    this.title,
    this.options,
    this.onSelected,
  });

  @override
  State<GeneralDropDownMenu> createState() => _GeneralDropDownMenuState();
}

class _GeneralDropDownMenuState extends State<GeneralDropDownMenu> {
  dynamic currentOption;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        widget.onSelected!(value);
      },
      color: backgroundColor,
      child: Container(
        width: 90.0.w,
        height: 7.0.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            7.0.sp,
          ),
          border: Border.all(
            width: 1.0.sp,
            color: backgroundColor,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: backgroundColor,
                  size: 20.0.sp,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  currentOption == null
                      ? widget.title!
                      : currentOption['title']!,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: 12.0.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 2.0.w,
              ),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.0.sp,
          ),
        ),
      ),
      elevation: 8,
      offset: Offset(0.0, 7.0.h),
      padding: EdgeInsets.zero,
      itemBuilder: (context) {
        return [
          ...List.generate(
            widget.options!.length,
            (int index) => PopupMenuItem<dynamic>(
              padding: EdgeInsets.symmetric(
                horizontal: 1.0.w,
              ),
              value: widget.options![index],
              onTap: () {
                setState(() {
                  currentOption = widget.options![index];
                });
              },
              child: Center(
                child: Container(
                  width: 200.0.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.options![index]['title'].toString(),
                        style: TextStyle(
                          color: accentColorBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ];
      },
    );
  }
}
