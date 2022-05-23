import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:sizer/sizer.dart";

class CustomDropDownMenu extends StatefulWidget {
  final String? title;
  final List<dynamic>? options;
  final String? langKey;
  final bool? isListOfvalues;

  CustomDropDownMenu({
    this.title,
    this.options,
    this.langKey,
    this.isListOfvalues = false,
  });

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String? currentOption;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (selectedValue) {
        if (widget.isListOfvalues!)
          Provider.of<PropertiesProvider>(
            context,
            listen: false,
          )
              .get_Property_Field_By_Lang_key(
                widget.langKey,
              )!
              .values!
              .add(
                selectedValue,
              );
        else
          Provider.of<PropertiesProvider>(
            context,
            listen: false,
          )
              .get_Property_Field_By_Lang_key(
                widget.langKey,
              )!
              .value = selectedValue;
      },
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
                  textAlign: TextAlign.end,
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
              value: widget.options![index]["id"],
              onTap: () {
                setState(() {
                  currentOption = widget.options![index]['option-title'];
                });
              },
              child: Center(
                child: Container(
                  width: 200.0.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.options![index]["option-title"]!,
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
