import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CategoriesBar extends StatefulWidget {
  CategoriesBar({Key? key}) : super(key: key);

  @override
  State<CategoriesBar> createState() => _CategoriesBarState();
}

class _CategoriesBarState extends State<CategoriesBar> {
  static int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17.0.h,
      width: 88.0.w,
      margin: EdgeInsets.symmetric(
        horizontal: 3.0.w,
      ),
      padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 4.0.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0.sp,
          ),
        ),
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.center,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: Provider.of<PropertiesProvider>(context, listen: false)
              .property_types_items!
              .length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              final category_item =
                  Provider.of<PropertiesProvider>(context, listen: false)
                      .property_types_items![index];
              Provider.of<PropertiesProvider>(context, listen: false)
                  .selectedCategoryId = category_item['id'];
              setState(() {
                selectedIndex = index;
              });
              Provider.of<PropertiesProvider>(context, listen: false)
                  .selectCategory(category_item['id']);
            },
            child: SizedBox(
              width: 23.w,
              height: 10.0.h,
              child: LayoutBuilder(
                builder: (context, constraints) => Container(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth,
                  ),
                  child: CategoryItem(
                    index: index,
                    selectedIndex: selectedIndex,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.index,
    required this.selectedIndex,
  }) : super(key: key);
  final int? index;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4.0.w,
        vertical: 1.0.w,
      ),
      decoration: BoxDecoration(
        color: selectedIndex == index ? greyColor.withOpacity(0.17) : null,
        borderRadius: BorderRadius.circular(
          10.0.sp,
        ),
        border: selectedIndex == index
            ? Border.all(
                width: 1.0.sp,
                color: accentColorBrown,
              )
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Text(
            Provider.of<PropertiesProvider>(context, listen: false)
                .property_types_items![index!]['title'],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11.0.sp,
            ),
          )
        ],
      ),
    );
  }
}
