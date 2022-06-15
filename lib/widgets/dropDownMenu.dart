import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import "package:sizer/sizer.dart";
import 'package:url_launcher/url_launcher.dart';

import '../helper/constants.dart';
import '../providers/main_provider.dart';

class DropDownMenu extends StatelessWidget {
  final List<Map<String, dynamic>> _dropDownButtons = [
    {
      "text": "home_page".tr,
      "value": "home",
    },
    {
      "text": "contract_forms".tr,
      "value": "contracts",
    },
    {
      "text": "properties".tr,
      "value": "properties",
    },
    {
      "text": "services".tr,
      "value": "services",
    },
    {
      "text": "prices_plan".tr,
      "value": "prices_plan",
    },
    {
      "text": "pages".tr,
      "value": "pages",
    },
    {
      "text": "contact_us".tr,
      "value": "contact_us",
    },
  ];

  Future<void> routtingToScreen(
    String menuName,
    BuildContext context,
  ) async {
    if (menuName == "contracts") {
      showContractPopUp(context);
    }
    if (menuName == "home") {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => WebViewScreen(urlLink: 'https://aqaratic.digitalfuture.sa/ar'),
      //   ),
      // );
    }
    if (menuName == "properties") {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => WebViewScreen(urlLink: 'https://aqaratic.digitalfuture.sa/ar/properties?page_type=list_view'),
      //   ),
      // );
    }
    if (menuName == "services") {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => WebViewScreen(urlLink: 'https://aqaratic.digitalfuture.sa/ar/user/form/service/1'),
      //   ),
      // );
    }
    if (menuName == "pages") {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => WebViewScreen(urlLink: 'https://aqaratic.digitalfuture.sa/ar/faq'),
      //   ),
      // );
    }
    if (menuName == "prices_plan") {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => WebViewScreen(urlLink: 'https://aqaratic.digitalfuture.sa/ar/pricing-plan'),
      //   ),
      // );
    }
    if (menuName == "contact_us") {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => WebViewScreen(urlLink: 'https://aqaratic.digitalfuture.sa/ar/contact-us'),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (menuName) => routtingToScreen(
        menuName,
        context,
      ),
      color: accentColorBlue,
      child: Container(
        margin: EdgeInsets.only(
          right: 2.0.w,
          left: 2.0.w,
        ),
        child: SvgPicture.asset(
          "assets/icons/menu_icon.svg",
          color: accentColorBlue,
          // height: 3.0.h,
          width: 7.0.w,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.0.sp,
          ),
        ),
      ),
      elevation: 3,
      offset: Offset(0, 4.0.h),
      padding: EdgeInsets.zero,
      itemBuilder: (context) {
        return [
          ...List.generate(
            _dropDownButtons.length,
            (index) => PopupMenuItem(
              value: _dropDownButtons[index]["value"],
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _dropDownButtons[index]["text"],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0.sp,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ];
      },
    );
  }

  void showContractPopUp(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Container(
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0.sp),
            ),
            child: SizedBox(
              width: 90.0.w,
              height: 50.0.h,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.0.h,
                  ),
                  child: ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        final String url =
                            Provider.of<MainProvider>(context, listen: false)
                                .contracts_file[index]['contract_file'];

                        try {
                          Navigator.pop(context);
                          await launchUrl(
                            Uri(
                              scheme: 'https',
                              host: "aqaratic.digitalfuture.sa",
                              path: url.substring(baseUrl.length),
                            ),
                            mode: LaunchMode.externalApplication,
                          );
                        } catch (e) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("contract_cannot_be_opened".tr),
                              duration: Duration(milliseconds: 800),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5.0.w,
                          vertical: 1.0.h,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.0.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.sp),
                            color: accentColorBrown.withOpacity(0.05),
                            border: Border.all(
                              width: 0.5.sp,
                              color: accentColorBrown,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0.h),
                            child: Text(
                              Provider.of<MainProvider>(context, listen: false)
                                  .contracts_file[index]['title_ar']
                                  .toString(),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: accentColorBrown,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: Provider.of<MainProvider>(context, listen: false)
                        .contracts_file
                        .length,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
