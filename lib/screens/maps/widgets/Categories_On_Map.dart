import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/constants.dart';
import '../../../providers/Maps_Provider.dart';
import '../../../providers/Properties_provider.dart';
import 'Category_On_Map_Item.dart';
import 'SearchBar_On_Map.dart';

class CategoriesOnMap extends StatelessWidget {
  CategoriesOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(right: 5.0.w),
          height: 25.0.h,
          width: 100.0.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.0.h,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "real_estate_listing".tr,
                      style: TextStyle(
                        color: accentColorBlue,
                        fontSize: 17.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    SearchBarOnMap(),
                    SizedBox(
                      width: 2.0.w,
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 5.0.h),
                      child: Image.asset(
                        "assets/icons/filter_icon.png",
                        width: 8.0.w,
                      ),
                      padding: EdgeInsets.all(2.0.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5.sp,
                          color: accentColorBlue,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10.0.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Expanded(
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      Provider.of<PropertiesProvider>(context, listen: false)
                          .property_types_items!
                          .length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      Provider.of<MapsProvider>(context, listen: false)
                          .disposeMapController();
                      Provider.of<MapsProvider>(context, listen: false)
                          .setNavigationMapTabsIndex(
                        index,
                      );
                      Provider.of<MapsProvider>(context, listen: false)
                          .setCategoryOnMapIndex(
                        index,
                      );
                      final category_item = Provider.of<PropertiesProvider>(
                        context,
                        listen: false,
                      ).property_types_items![index];
                    },
                    child: CategoryOnMapItem(
                      index: index,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
