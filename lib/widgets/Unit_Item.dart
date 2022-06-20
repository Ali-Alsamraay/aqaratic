import 'package:aqaratak/models/property.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';
import 'package:sizer/sizer.dart';

import '../screens/unit_details_screen.dart';

class UnitItem extends StatefulWidget {
  @override
  State<UnitItem> createState() => _UnitItemState();
}

class _UnitItemState extends State<UnitItem> {
  bool? selectedAsFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final int? propertyId = Provider.of<Property>(
          context,
          listen: false,
        ).id;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UnitDetailsScreen(),
            settings: RouteSettings(
              arguments: propertyId,
            ),
          ),
        );
      },
      child: Container(
        width: 65.0.w,
        margin: EdgeInsets.symmetric(
          horizontal: 3.0.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            15.0.sp,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 2.0.w,
          vertical: 1.0.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Consumer<Property>(
                      builder: (context, value, child) => Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            10.0.sp,
                          ),
                          child: value.thumbnail_image == null
                              ? Center(
                                  child: Text("no_picture".tr),
                                )
                              : value.thumbnail_image!.isNotEmpty
                                  ? FadeInImage.assetNetwork(
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                              Center(
                                        child: Text("no_picture".tr),
                                      ),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      placeholder: imagePath + 'splash.png',
                                      image: baseUrl +
                                          "/" +
                                          value.thumbnail_image!,
                                    )
                                  : Image.asset(
                                      imagePath + 'background.png',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 8.0.w,
                          height: 8.0.w,
                          padding: EdgeInsets.all(1.0.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0.sp),
                            color: accentColorLightBlue.withOpacity(0.5),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 15.0.sp,
                            icon: Icon(
                              selectedAsFavorite!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedAsFavorite = !selectedAsFavorite!;
                              });
                            },
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Consumer<Property>(
                      builder: (context, value, child) => value.is_featured == 1
                          ? Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 15.0.w,
                                  height: 8.0.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.0.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0.sp),
                                    color: Colors.redAccent.withOpacity(0.8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "مميز",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.0.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                child: Consumer<Property>(
                  builder: (context, value, child) => Text(
                    value.title ?? '',
                    maxLines: 1,
                    style: TextStyle(
                      color: Color(0xff0c2757),
                      fontSize: 11.0.sp,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: accentColorBlue,
                      size: 12.0.sp,
                    ),
                    SizedBox(
                      width: 2.0.w,
                    ),
                    Consumer<Property>(
                      builder: (context, value, child) => Text(
                        value.address ?? '',
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 9.0.sp,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer<Property>(
                      builder: (context, value, child) => Text(
                        '${value.price!.toString()} ',
                        style: TextStyle(
                          color: Color(0xffb78457),
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Text(
                      'ريال',
                      style: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 7.0.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
