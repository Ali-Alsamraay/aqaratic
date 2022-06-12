import 'package:flutter/material.dart';

import '../helper/constants.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.onSaveFunc,
    required this.onValidateFunc,
    required this.label,
    this.linesNumber = 1,
    this.removeBorder = false,
    this.icon = null,
    this.passwordField = false,
    this.labelTextSize,
    this.textFieldHeight,
    this.hintTextColor = Colors.black,
    this.textInputType = TextInputType.text,
    this.textStyle,
    this.focusedBorderColor = accentColorBrown,
    this.enabledBorderColor = Colors.white,
    this.errorBorderColor = accentColorBlue,
    this.initValue,
    this.disable = false,
    this.focusNode,
  }) : super(key: key);
  final Function(String?) onValidateFunc;
  final void Function(String?)? onSaveFunc;
  final String? label;
  final int? linesNumber;
  final bool? removeBorder;
  final Icon? icon;
  final bool? passwordField;
  final double? labelTextSize;
  final double? textFieldHeight;
  final TextInputType? textInputType;
  final Color? hintTextColor;
  final TextStyle? textStyle;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final dynamic initValue;
  final FocusNode? focusNode;
  final bool? disable;

  bool? isThereError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          enabled: !disable!,
          focusNode: focusNode,
          initialValue: initValue,
          style: textStyle,
          keyboardType: textInputType,
          textDirection: TextDirection.rtl,
          autofocus: true,
          obscureText: passwordField!,
          cursorColor: accentColorBrown,
          maxLines: linesNumber!,
          decoration: this.removeBorder!
              ? InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    color: hintTextColor,
                    fontSize: labelTextSize == null ? 10.0.sp : labelTextSize,
                  ),
                  contentPadding: icon == null
                      ? null
                      : EdgeInsets.symmetric(
                          horizontal: 5.0.w,
                          vertical: 1.0.h,
                        ),
                  hintText: label!,
                  prefixIcon: icon == null ? null : icon,
                )
              : InputDecoration(
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0.sp),
                    borderSide: BorderSide(
                      color: enabledBorderColor!,
                      width: 0.8.sp,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0.sp),
                    borderSide: BorderSide(
                      color: greyColor,
                      width: 0.8.sp,
                    ),
                  ),
                  focusColor: accentColorBrown,
                  hintText: label!,
                  hintStyle: TextStyle(
                    fontSize: labelTextSize == null ? 10.0.sp : labelTextSize,
                    color: hintTextColor,
                  ),
                  // prefixIcon: icon == null ? null : icon,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5.0.w,
                    vertical: 1.0.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12.0.sp,
                    ),
                    borderSide:
                        BorderSide(color: accentColorBlue, width: 0.8.sp),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12.0.sp,
                    ),
                    borderSide: BorderSide(
                      color: errorBorderColor!,
                      width: 0.8.sp,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: focusedBorderColor!,
                    ),
                    borderRadius: BorderRadius.circular(
                      12.0.sp,
                    ),
                  ),
                ),
          validator: (String? v) {
            final errorMsg = onValidateFunc(v);
            isThereError = errorMsg != null;
            return errorMsg;
          },
          onSaved: (value) => onSaveFunc!(value),
        ),
      ),
    );
  }
}
