import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../models/FormValidator.dart';
import '../providers/Properties_provider.dart';
import 'Custom_TextField.dart';
import 'package:sizer/sizer.dart';

class CustomTextFieldBuilder extends StatelessWidget {
  const CustomTextFieldBuilder({
    Key? key,
    required this.formValidator,
    required this.propertiesProvider,
    required this.langKey,
    required this.heightAfterField,
    required this.textInputType,
    this.isListOfvalues = false,
    this.linesNumber = 1,
    this.textInputHeight,
  }) : super(key: key);

  final FormValidator? formValidator;
  final PropertiesProvider? propertiesProvider;
  final String? langKey;
  final double? heightAfterField;
  final TextInputType? textInputType;
  final int? linesNumber;
  final double? textInputHeight;
  final bool? isListOfvalues;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          linesNumber: linesNumber,
          textFieldHeight: textInputHeight,
          textInputType: textInputType,
          onValidateFunc: (value) {
            return formValidator!.validateTextField(value!.trim());
          },
          onSaveFunc: (value) {
            if (isListOfvalues!)
              propertiesProvider!
                  .get_Property_Field_By_Lang_key(langKey)!
                  .values!
                  .add(
                    value!.trim(),
                  );
            else
              propertiesProvider!
                  .get_Property_Field_By_Lang_key(langKey)!
                  .value = value!.trim();
          },
          label: propertiesProvider!.get_Label_Text_By_Lang_key(
            langKey,
          ),
          labelTextSize: 11.0.sp,
          enabledBorderColor: accentColorBlue,
          initValue: propertiesProvider!
              .get_Property_Field_By_Lang_key(langKey)!
              .value,
        ),
        SizedBox(
          height: heightAfterField,
        ),
      ],
    );
  }
}
