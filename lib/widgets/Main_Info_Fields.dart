import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/Utils.dart';
import '../models/FormValidator.dart';
import '../providers/Properties_provider.dart';
import 'Custom_TextField_Builder.dart';
import 'DropDwon_Builder.dart';
import 'package:sizer/sizer.dart';

class MainInfoFields extends StatelessWidget {
  MainInfoFields({
    Key? key,
  }) : super(
          key: key,
        );
  final FormValidator? formValidator = FormValidator();

  final Utils utils = Utils();
  final List<Map<String, dynamic>>? fieldsBulders = [
    {
      "langKey": "title",
      "fieldType": TextInputType.text,
    },
    // {
    //   "langKey": "slug",
    //   "fieldType": TextInputType.url,
    // },
    {
      "langKey": "address",
      "fieldType": TextInputType.streetAddress,
    },
    {
      "langKey": "email",
      "fieldType": TextInputType.emailAddress,
    },
    {
      "langKey": "phone",
      "fieldType": TextInputType.phone,
    },
    {
      "langKey": "price",
      "fieldType": TextInputType.number,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(
      context,
      listen: false,
    );
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
                formValidator: formValidator,
                textInputHeight: 7.0.h,
                propertiesProvider: propertiesProvider,
                langKey: fieldsBulders![index]['langKey'],
                heightAfterField: 2.0.h,
                textInputType: fieldsBulders![index]['fieldType'],
              );
            },
          ),

          // proprties types
          DropDownBuilder(
            langKey_fieldTitle: propertiesProvider.get_Label_Text_By_Lang_key(
              "select_property_type",
            ),
            langKey: "property_type",
            heightAfterField: 2.0.h,
            optionTitle: "type",
            options: propertiesProvider.propertyTypes_Objects,
          ),

          // cities
          DropDownBuilder(
            langKey_fieldTitle: propertiesProvider.get_Label_Text_By_Lang_key(
              "select_city",
            ),
            langKey: "city",
            heightAfterField: 2.0.h,
            optionTitle: "name",
            options: propertiesProvider.cities_Objects,
          ),

          // purposes
          DropDownBuilder(
            langKey_fieldTitle: "سبب البيع",
            langKey: "purpose",
            heightAfterField: 2.0.h,
            optionTitle: "custom_purpose",
            options: propertiesProvider.purposes_Objects,
          ),

          // period
          DropDownBuilder(
            langKey_fieldTitle:
                propertiesProvider.get_Label_Text_By_Lang_key("period"),
            langKey: "period",
            heightAfterField: 2.0.h,
            optionTitle: "custom_text",
            options: propertiesProvider.periods_Objects,
          ),
        ],
      ),
    );
  }
}
