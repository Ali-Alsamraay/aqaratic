import 'dart:developer';

import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:sizer/sizer.dart";

class DropDownInFiltration extends StatefulWidget {
  final String? title;
  final List<Map<String, dynamic>>? options;
  final String? field_key;
  final bool isEnabled;
  final Color? dropDownColor;

  DropDownInFiltration({
    this.title,
    this.options,
    required this.field_key,
    this.isEnabled = true,
    this.dropDownColor,
  });

  @override
  State<DropDownInFiltration> createState() => _DropDownInFiltrationState();
}

class _DropDownInFiltrationState extends State<DropDownInFiltration> {
  String? currentOptionTitle;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(
      context,
      listen: false,
    );
    return widget.isEnabled
        ? Column(
            children: [
              PopupMenuButton(
                onSelected: (Map<String, dynamic> selectedValue) {
                  propertiesProvider.set_filtration_prams(
                    selectedValue['id'].toString(),
                    widget.field_key!,
                  );
                },
                color: widget.dropDownColor == null
                    ? accentColorBlue
                    : backgroundColor,
                child: Container(
                  width: 90.0.w,
                  height: 7.0.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      7.0.sp,
                    ),
                    border: Border.all(
                      width: 0.4.sp,
                      color: widget.dropDownColor == null
                          ? accentColorBlue
                          : backgroundColor,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.arrow_downward_rounded,
                            color: widget.dropDownColor == null
                                ? accentColorBlue
                                : backgroundColor,
                            size: 20.0.sp,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            currentOptionTitle == null
                                ? widget.title!
                                : currentOptionTitle!,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: widget.dropDownColor == null
                                  ? accentColorBlue
                                  : backgroundColor,
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
                            currentOptionTitle =
                                widget.options![index]['title'];
                          });
                        },
                        child: Center(
                          child: Container(
                            width: 200.0.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.options![index]['title'],
                                  style: TextStyle(
                                    color: widget.dropDownColor == null
                                        ? Colors.white
                                        : accentColorBlue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.0.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
              ),
              SizedBox(
                height: 3.0.h,
              ),
            ],
          )
        : SizedBox();
  }
}
