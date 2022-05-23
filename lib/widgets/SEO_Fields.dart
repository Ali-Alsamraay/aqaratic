import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/Utils.dart';
import '../models/FormValidator.dart';
import '../providers/Properties_provider.dart';
import 'Custom_TextField_Builder.dart';
import 'package:sizer/sizer.dart';

class SEOFields extends StatelessWidget {
  SEOFields({
    Key? key,
  }) : super(
          key: key,
        );
  final FormValidator? formValidator = FormValidator();
  final Utils utils = Utils();

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
          CustomTextFieldBuilder(
            formValidator: formValidator,
            propertiesProvider: propertiesProvider,
            langKey: "seo_title",
            heightAfterField: 2.0.h,
            textInputHeight: 9.0.h,
            textInputType: TextInputType.text,
            linesNumber: 4,
          ),
          CustomTextFieldBuilder(
            formValidator: formValidator,
            propertiesProvider: propertiesProvider,
            langKey: "seo_des",
            textInputHeight: 15.0.h,
            heightAfterField: 2.0.h,
            textInputType: TextInputType.text,
            linesNumber: 6,
          ),
        ],
      ),
    );
  }
}
