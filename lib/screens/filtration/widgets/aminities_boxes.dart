import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:aqaratak/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AmenitiesBoxes extends StatelessWidget {
  const AmenitiesBoxes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = Provider.of<MainProvider>(
      context,
    );
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(
      context,
    );
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 2.0.h,
        ),
        ...propertiesProvider
            .get_amenities_by_property_type(
              mainProvider.main_properties['propertyTypes'].toList(),
              propertiesProvider.filtration_prams['propertyTypeData'],
              "properties_type_active_ammonites_label",
              mainProvider.main_properties['property_aminities'],
            )
            .entries
            .map((entry) {
          final String id = entry.key;
          final String value = entry.value;
          return CheckItem(
            title: value.toString(),
            id: id.toString(),
          );
        }),
      ],
    ));
  }
}

class CheckItem extends StatefulWidget {
  const CheckItem({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);
  final String? title;
  final String? id;

  @override
  State<CheckItem> createState() => _CheckState();
}

class _CheckState extends State<CheckItem> {
  @override
  void initState() {
    super.initState();
  }

  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: false);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: accentColorBrown,
                    fontSize: 12.0.sp,
                  ),
                ),
              ),
              Expanded(
                child: Transform.scale(
                  scale: 0.9.sp,
                  child: Checkbox(
                    value: isChecked,
                    activeColor: accentColorBrown,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
                      });
                      if (isChecked!) {
                        propertiesProvider.filtration_prams['aminity[]'].add(
                          widget.id,
                        );
                      } else {
                        propertiesProvider.filtration_prams['aminity[]']
                            .removeWhere(
                          (element) => element == widget.id,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: accentColorBrown,
          ),
          SizedBox(
            height: 2.0.h,
          )
        ],
      ),
    );
  }
}
