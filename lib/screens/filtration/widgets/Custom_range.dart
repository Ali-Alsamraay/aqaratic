import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../helper/constants.dart';
import '../../../providers/Properties_provider.dart';

class CustomRangeSlider extends StatelessWidget {
  const CustomRangeSlider({
    Key? key,
    required this.title,
    required this.max,
    required this.min,
    required this.values,
    required this.onChanged,
  }) : super(key: key);
  final String title;
  final double min;
  final double max;
  final SfRangeValues values;
  final Function(SfRangeValues) onChanged;

  @override
  Widget build(BuildContext context) {
    final PropertiesProvider _propertiesProvider =
        Provider.of<PropertiesProvider>(context);
    return Column(
      children: [
        Text(
          this.title,
          style: TextStyle(
            fontSize: 12.0.sp,
            fontWeight: FontWeight.bold,
            color: accentColorBrown,
          ),
        ),
        SfRangeSlider(
          activeColor: accentColorBrown,
          min: this.min,
          max: this.max,
          values:values,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
