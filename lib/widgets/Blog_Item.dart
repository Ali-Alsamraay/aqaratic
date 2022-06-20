import 'package:aqaratak/models/Blog.dart';
import 'package:aqaratak/models/property.dart';
import 'package:aqaratak/screens/blog_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';
import 'package:sizer/sizer.dart';

import '../screens/unit_details_screen.dart';

class BlogItem extends StatefulWidget {
  @override
  State<BlogItem> createState() => _BlogItemState();
}

class _BlogItemState extends State<BlogItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final int? blogId = Provider.of<Blog>(
          context,
          listen: false,
        ).id;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlogDetailsScreen(),
            settings: RouteSettings(
              arguments: blogId,
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
          border: Border.all(width: 1.0.sp, color: Colors.grey),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 1.0.w,
          vertical: 1.0.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Consumer<Blog>(
                      builder: (context, value, child) => Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            10.0.sp,
                          ),
                          child: value.image == null
                              ? Center(
                                  child: Text("لا توجد صورة"),
                                )
                              : value.image!.isNotEmpty
                                  ? FadeInImage.assetNetwork(
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                              Center(
                                        child: Text("لا توجد صورة"),
                                      ),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      placeholder: imagePath + 'splash.png',
                                      image: baseUrl + "/" + value.image!,
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
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                child: Consumer<Blog>(
                  builder: (context, value, child) => Text(
                    '${value.title!.toString()} ',
                    style: TextStyle(
                      color: accentColorBlue,
                      fontSize: 11.0.sp,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                child: Consumer<Blog>(
                  builder: (context, value, child) => Text(
                    value.short_description ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xff0c2757),
                      fontSize: 10.0.sp,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.0.h,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                width: 20.0.w,
                height: 4.0.h,
                decoration: BoxDecoration(
                  color: accentColorBlue.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(
                    5.0.sp,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer<Blog>(
                      builder: (context, value, child) => Text(
                        value.view == null ? '' : value.view!.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chat_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1.0.h,
            ),
          ],
        ),
      ),
    );
  }
}
