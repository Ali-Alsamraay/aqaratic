import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class CommentWidgetView extends StatelessWidget {
   CommentWidgetView({Key? key, required this.name,required this.image,required this.date,required this.subject,required this.rate}) : super(key: key);

  String image, name, date, subject;
  double rate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(7.0.w, 0, 7.0.w, 4.0.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0.sp),
          color: Colors.grey.shade300,
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.0.w,
              vertical: 1.0.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.cover))),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBarIndicator(
                          rating: rate,
                          itemCount: 5,
                          itemSize: 12.0,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Text(name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          date,
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                Text(subject)
              ],
            )),
      ),
    );
  }
}
