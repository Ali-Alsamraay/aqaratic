import 'dart:developer';
import 'dart:ffi';

import 'package:aqaratak/screens/filtration/widgets/Drop_Down.dart';
import 'package:aqaratak/widgets/Custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helper/constants.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../providers/Properties_provider.dart';
import '../../widgets/CustomDropDown.dart';
import 'widgets/Custom_range.dart';

class FiltrationScreen extends StatefulWidget {
  FiltrationScreen({Key? key}) : super(key: key);

  @override
  State<FiltrationScreen> createState() => _FiltrationScreenState();
}

class _FiltrationScreenState extends State<FiltrationScreen> {
  final GlobalKey<FormState>? _key = new GlobalKey();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final PropertiesProvider propertiesProvider =
            Provider.of<PropertiesProvider>(
          context,
          listen: false,
        );
        await propertiesProvider.get_properties_with_categories();

        propertiesProvider.setPriceRangeValues(
          SfRangeValues(
            0,
            propertiesProvider.getMaxPrice(),
          ),
        );
        propertiesProvider.setAreaRangeValues(
          SfRangeValues(
            0,
            propertiesProvider.getMaxArea(),
          ),
        );
        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    if (_key != null && _key!.currentState != null) {
      _key!.currentState!.dispose();
    }
    super.dispose();
  }

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    final PropertiesProvider _propertiesProvider =
        Provider.of<PropertiesProvider>(context);
    return Container(
      height: 100.0.h,
      width: 100.0.w,
      child: loading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
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
                        "خيارات البحث",
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
                  flex: 5,
                  child: SizedBox(
                    width: 90.0.w,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0.sp),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                            child: Form(
                              key: _key!,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  CustomTextField(
                                    onSaveFunc: (value) {},
                                    onValidateFunc: (value) {},
                                    label: "كلمات مفتاحية",
                                    enabledBorderColor: accentColorBrown,
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  CustomRangeSlider(
                                    title: "السعر",
                                    min: 0,
                                    max: _propertiesProvider.getMaxPrice(),
                                    onChanged: (value) {
                                      _propertiesProvider.setPriceRangeValues(
                                        value,
                                      );
                                    },
                                    values:
                                        _propertiesProvider.priceRangeValues!,
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  CustomRangeSlider(
                                    title: "المساحة",
                                    min: 0,
                                    max: _propertiesProvider.getMaxArea(),
                                    onChanged: (value) {
                                      _propertiesProvider.setAreaRangeValues(
                                        value,
                                      );
                                    },
                                    values:
                                        _propertiesProvider.areaRangeValues!,
                                  ),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  DropDownInFiltration(
                                    title: "الدولة",
                                    options: [
                                      "الكويت",
                                      "الإريتريا",
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  DropDownInFiltration(
                                    title: "المدينة",
                                    options: [
                                      "الكويت",
                                      "الإريتريا",
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  DropDownInFiltration(
                                    title: "المنطقة",
                                    options: [
                                      "الكويت",
                                      "الإريتريا",
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  DropDownInFiltration(
                                    title: "نوع العقار",
                                    options: [
                                      "الكويت",
                                      "الإريتريا",
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  DropDownInFiltration(
                                    title: "الطوابق",
                                    options: [
                                      "الكويت",
                                      "الإريتريا",
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  DropDownInFiltration(
                                    title: "الغرض من الصلاحية",
                                    options: [
                                      "الكويت",
                                      "الإريتريا",
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  DropDownInFiltration(
                                    title: "مميزات العقار",
                                    options: [
                                      "الكويت",
                                      "الإريتريا",
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  DropDownInFiltration(
                                    title: "طريقة الدفع",
                                    options: [
                                      "الكويت",
                                      "الإريتريا",
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.0.h,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        15.0.sp,
                                      ),
                                    ),
                                    onPressed: loading ? null : () {},
                                    padding: EdgeInsets.all(
                                      7.0.sp,
                                    ),
                                    color: accentColorBrown,
                                    child: Text(
                                      'بحث',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0.h,
                )
              ],
            ),
    );
  }
}
