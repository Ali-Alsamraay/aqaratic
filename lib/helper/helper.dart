import 'package:aqaratak/screens/unit_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aqaratak/helper/constants.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Future showAlert(String msg, BuildContext context) {
  // flutter defined function
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'تنبيه',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      ),
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(
                context); // dismisses only the dialog and returns nothing
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black54),
          ),
          child: const Align(alignment: Alignment.center, child: Text('موافق')),
        ),
      ],
    ),
  );
}

Future showUnitDetails(
    int id, String title, String desc, double price, BuildContext context) {
  // flutter defined function
  return showDialog(
    context: context,
    builder: (context) => Container(
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0.sp),
        ),
        child: SizedBox(
          height: 40.0.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(6.0.w, 2.0.w, 6.0.w, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.close, size: 30)),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UnitDetailsScreen(),
                                settings: RouteSettings(
                                  arguments: id,
                                ),
                              ),
                            );
                          },
                          child:
                              const Icon(Icons.location_on_outlined, size: 30)),
                    ],
                  ),
                ),
                SizedBox(height: 1.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.0.w,
                    vertical: 2.0.h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0.sp),
                      color: accentColorBrown,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.0.w,
                        vertical: 0.5.h,
                      ),
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Field(
                  title: "price".tr,
                  value: '$price ريال ',
                ),
                const Divider(),
                Field(
                  title: "description".tr,
                  value: desc,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

final spinkit = SpinKitFadingCube(
  itemBuilder: (context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? const Color(0xffd2f5e3) : const Color(0xff75cfb8),
      ),
    );
  },
);

// write(String text, String contactName) async {
//   final Directory directory = await getApplicationDocumentsDirectory();
//   final File file = File('${directory.path}/$contactName.vcf');
//   await file.writeAsString(text);
//   Share.shareFiles(['${directory.path}/$contactName.vcf']);
// }

extension nil on String {
  bool isNullOrEmpty() {
    if (this == null || this.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isNotNullOrEmpty() {
    if (this == null || this.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
