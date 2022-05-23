
import 'package:flutter/material.dart';

import '../helper/Utils.dart';
import 'CustomDropDown.dart';

class DropDownBuilder extends StatelessWidget {
  DropDownBuilder({
    Key? key,
    required this.heightAfterField,
    this.id = "id",
    required this.langKey,
    required this.langKey_fieldTitle,
    required this.optionTitle,
    required this.options,
    this.isListOfvalues = false,
  }) : super(key: key);
  final String? langKey_fieldTitle;
  final String? langKey;
  final double? heightAfterField;
  final String? optionTitle;
  final List<dynamic>? options;
  final String? id;
  final bool? isListOfvalues;

  final Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomDropDownMenu(
            title: langKey_fieldTitle,
            options: utils.drop_down_options_mapper(
              options!,
              optionTitle,
              id,
            )!,
            langKey: langKey,
          ),
          SizedBox(
            height: heightAfterField,
          ),
        ],
      ),
    );
  }
}