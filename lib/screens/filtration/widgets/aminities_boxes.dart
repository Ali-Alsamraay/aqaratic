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
    final MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);
    final dynamic aminities =
        mainProvider.main_properties['property_aminities'];
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2.0.h,
          ),
          ...aminities.entries.map((entry) {
            final String id = entry.key;
            final String value = entry.value;
            return CheckItem(
              title: value.toString(),
              id: id.toString(),
            );
          }),
        ],
      ),
    );
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
