import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/Utils.dart';
import '../models/FormValidator.dart';
import '../providers/Properties_provider.dart';
import 'Custom_TextField_Builder.dart';
import 'package:sizer/sizer.dart';

class OthersInfoFields extends StatelessWidget {
  OthersInfoFields({
    Key? key,
  }) : super(
          key: key,
        );
  final FormValidator? formValidator = FormValidator();

  final Utils utils = Utils();
  final List<Map<String, dynamic>>? fieldsBulders = [
    {
      "langKey": "total_area",
      "fieldType": TextInputType.number,
    },
    {
      "langKey": "total_unit",
      "fieldType": TextInputType.number,
    },
    {
      "langKey": "total_room",
      "fieldType": TextInputType.number,
    },
    {
      "langKey": "total_bedroom",
      "fieldType": TextInputType.number,
    },
    {
      "langKey": "total_bathroom",
      "fieldType": TextInputType.number,
    },
    {
      "langKey": "total_floor",
      "fieldType": TextInputType.number,
    },
    {
      "langKey": "total_kitchen",
      "fieldType": TextInputType.number,
    },
    {
      "langKey": "parking_place",
      "fieldType": TextInputType.number,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final PropertiesProvider? propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: false);
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 2.0.h,
          ),
          ...List.generate(
            fieldsBulders!.length,
            (index) {
              return CustomTextFieldBuilder(
                textInputHeight: 7.0.h,
                formValidator: formValidator,
                propertiesProvider: propertiesProvider,
                langKey: fieldsBulders![index]['langKey'],
                heightAfterField: 2.0.h,
                textInputType: fieldsBulders![index]['fieldType'],
              );
            },
          ),
        ],
      ),
    );
  }
}
