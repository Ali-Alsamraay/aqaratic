import 'package:aqaratak/models/Service.dart';
import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/providers/services_provider.dart';
import 'package:aqaratak/screens/login_screen.dart';
import 'package:aqaratak/screens/service_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../helper/constants.dart';

class AddingNewService extends StatelessWidget {
  const AddingNewService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0.h,
      width: 100.0.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.0.w,
                  vertical: 0.5.h,
                ),
                decoration: BoxDecoration(
                  color: accentColorBlue.withOpacity(0.9),
                  border: Border.all(
                    width: 1.5.sp,
                    color: accentColorBrown,
                  ),
                  borderRadius: BorderRadius.circular(
                    12.0.sp,
                  ),
                ),
                child: Text(
                  "choose_type_service".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              width: 80.0.w,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0.sp),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: FutureBuilder(
                    future: Provider.of<ServicesProvider>(
                      context,
                      listen: false,
                    ).get_services_types(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text(
                            "unexpected_error".tr,
                            style: TextStyle(
                              fontSize: 14.0.sp,
                            ),
                          );
                        }
                        return Consumer<ServicesProvider>(
                          builder: (context, servicesProvider, child) =>
                              ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => SizedBox(
                              width: 2.0.w,
                              child: ChangeNotifierProvider<Service>.value(
                                value: servicesProvider.services![index],
                                child: ServiceTypeItem(
                                  index: index + 1,
                                ),
                              ),
                            ),
                            itemCount: servicesProvider.services!.length,
                          ),
                        );
                      }
                      return Text("no_data".tr);
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0.h,
          ),
        ],
      ),
    );
  }
}

class ServiceTypeItem extends StatelessWidget {
  const ServiceTypeItem({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Consumer<Service>(
      builder: (context, value, child) => GestureDetector(
        onTap: () async {
          if (!await authProvider.isCurrentUserLoggedIn()!) {
            Navigator.pushNamed(
              context,
              LoginScreen.screenName,
            );
            return;
          }

          showDialog(
            context: context,
            builder: (ctx) {
              return Container(
                width: 90.0.w,
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  child: ServiceForm(
                    service_id: value.id,
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 1.0.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0.sp),
              color: accentColorBrown.withOpacity(0.05),
              border: Border.all(
                width: 0.5.sp,
                color: accentColorBrown,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5.0.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColorBrown,
                  ),
                  child: Text(
                    index!.toString(),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Consumer<Service>(
                  builder: (context, value, child) => Text(
                    value.title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: accentColorBrown,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.0.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
