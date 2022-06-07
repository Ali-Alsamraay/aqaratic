import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/constants.dart';
import '../../../providers/Maps_Provider.dart';
import '../../../providers/Properties_provider.dart';

class CategoryOnMapItem extends StatelessWidget {
  const CategoryOnMapItem({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(
          left: 2.5.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 4.0.w,
        ),
        decoration: BoxDecoration(
          color: Provider.of<MapsProvider>(context).categoryOnMapIndex == index
              ? accentColorBlue
              : Colors.white,
          borderRadius: BorderRadius.circular(
            10.0.sp,
          ),
          border: Border.all(
            width: 0.8.sp,
            color: accentColorBrown,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Provider.of<PropertiesProvider>(context, listen: false)
                        .property_types_items![index!]['id'] ==
                    -1
                ? Icon(
                    Icons.border_all_rounded,
                    color: accentColorBrown,
                    size: 22.0.sp,
                  )
                : SvgPicture.asset(
                    Provider.of<PropertiesProvider>(context, listen: false)
                        .property_types_items![index!]['icon_path'],
                    height: 7.0.w,
                    width: 7.0.w,
                    semanticsLabel: '',
                  ),
            SizedBox(
              width: 1.5.w,
            ),
            Text(
              Provider.of<PropertiesProvider>(context, listen: false)
                  .property_types_items![index!]['title'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Provider.of<MapsProvider>(context).categoryOnMapIndex ==
                        index
                    ? Colors.white
                    : accentColorBlue,
                fontSize: 10.0.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
