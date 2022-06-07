import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:sizer/sizer.dart";

class DropDownInFiltration extends StatefulWidget {
  final String? title;
  final List<dynamic>? options;

  DropDownInFiltration({
    this.title,
    this.options,
  });

  @override
  State<DropDownInFiltration> createState() => _DropDownInFiltrationState();
}

class _DropDownInFiltrationState extends State<DropDownInFiltration> {
  String? currentOption;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (selectedValue) {},
      color: accentColorBlue,
      child: Container(
        width: 90.0.w,
        height: 7.0.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            7.0.sp,
          ),
          border: Border.all(
            width: 0.4.sp,
            color: accentColorBlue,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: accentColorBlue,
                  size: 20.0.sp,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  currentOption == null ? widget.title! : currentOption!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: accentColorBlue,
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
            (index) => PopupMenuItem(
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
                        widget.options![index]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0.sp,
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