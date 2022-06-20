import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/Blog.dart';
import 'package:aqaratak/models/Order.dart';
import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/providers/main_provider.dart';
import 'package:aqaratak/screens/unit_details_screen.dart';
import 'package:aqaratak/widgets/Blog_Item.dart';
import 'package:aqaratak/widgets/Order_Item.dart';
import 'package:aqaratak/widgets/Title_Builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widgets/dropDownMenu.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);
  static const String screenName = "my-orders-screen";

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool? loading = true;
  bool isCalled = false;
  Map<String, dynamic>? userInfo = {};
  @override
  void initState() {
    super.initState();
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        userInfo = await authProvider.getUserInfo();
        if (mounted)
          setState(() {
            loading = false;
          });
      } catch (e) {
        if (mounted)
          setState(() {
            loading = false;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0.h),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: accentColorBlue,
                blurRadius: 10.0,
                spreadRadius: 0,
                offset: Offset(2.0, -2.0), // shadow direction: bottom right
              )
            ],
            color: accentColorBlue,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0.w,
                ),
                Text(
                  'طلباتي',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: 100.0.h,
        width: 100.0.w,
        child: loading!
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : userInfo!['user']['form_services'].toList().length == 0
                ? Center(
                    child: TitleBuilder(
                      title: 'لا توجد طلبات',
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 2.0.h),
                    itemCount:
                        userInfo!['user']['form_services'].toList().length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: ChangeNotifierProvider<Order>.value(
                          value: Order.fromJson(userInfo!['user']
                                  ['form_services']
                              .toList()[index]),
                          child: Container(
                            // height: 10.0.h,
                            margin: EdgeInsets.symmetric(vertical: 1.0.h),
                            child: OrderItem(),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
