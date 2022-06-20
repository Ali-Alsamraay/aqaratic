import 'package:aqaratak/models/Order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';
import 'package:sizer/sizer.dart';

class OrderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final int? orderId = Provider.of<Order>(
          context,
          listen: false,
        ).id;
      },
      child: Container(
        width: 65.0.w,
        // height: 60.0.h,
        margin: EdgeInsets.symmetric(
          horizontal: 3.0.w,
        ),
        decoration: BoxDecoration(
          color: accentColorBlue.withOpacity(0.07),
          borderRadius: BorderRadius.circular(
            10.0.sp,
          ),
          border: Border.all(width: 1.0.sp, color: Colors.grey),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 1.0.w,
          vertical: 1.0.h,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 11.0.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 2.0.w,
                  ),
                  Consumer<Order>(
                    builder: (context, order, child) => Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 3.0.h,
                          horizontal: 1.0.w,
                        ),
                        decoration: BoxDecoration(
                          color: order.status == "pending"
                              ? Color.fromARGB(207, 218, 178, 0)
                              : order.status == "canceled"
                                  ? Color.fromARGB(255, 252, 60, 60)
                                  : Color.fromARGB(255, 24, 104, 14),
                          borderRadius: BorderRadius.circular(
                            10.0.sp,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            order.status == "pending"
                                ? "قيد الانتظار"
                                : order.status == "canceled"
                                    ? "مرفوض"
                                    : "تم التأكيد",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.0.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.0.w,
                  ),
                  Consumer<Order>(
                    builder: (context, order, child) => Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              order.first_name.toString() +
                                  ' ' +
                                  order.last_name.toString(),
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: accentColorBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              order.email.toString(),
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: accentColorBlue,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              order.phone.toString(),
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: accentColorBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.0.w,
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              child: Consumer<Order>(
                builder: (context, order, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 2.0.w,
                      ),
                      child: Text(
                        order.regarding_info == null
                            ? "لا يوجد وصف"
                            : order.regarding_info.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          color: Color.fromARGB(255, 125, 129, 136),
                          fontWeight: FontWeight.normal,
                        ),
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
