import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CheckBoxFields extends StatelessWidget {
  const CheckBoxFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: false);
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2.0.h,
          ),
          ...List.generate(
            propertiesProvider.aminities_Objects.length,
            (index) {
              return CheckItem(
                title: propertiesProvider.aminities_Objects[index]['aminity']!
                    .toString(),
                id: propertiesProvider.aminities_Objects[index]['id']!,
              );
            },
          ),
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
  final int? id;

  @override
  State<CheckItem> createState() => _CheckState();
}

class _CheckState extends State<CheckItem> {
  @override
  void initState() {
    super.initState();
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: false);
    propertiesProvider
        .get_Property_Field_By_Lang_key("aminities")!
        .values!
        .add(widget.id!);
  }

  bool? isChecked = true;
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
                        propertiesProvider
                            .get_Property_Field_By_Lang_key("aminities")!
                            .values!
                            .add(widget.id!);
                      } else {
                        propertiesProvider
                            .get_Property_Field_By_Lang_key("aminities")!
                            .values!
                            .removeWhere((item) => item! == widget.id!);
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
