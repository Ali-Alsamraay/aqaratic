import 'package:aqaratak/providers/main_provider.dart';
import 'package:aqaratak/screens/all_properities_screen.dart';
import 'package:aqaratak/screens/filtration/widgets/Drop_Down.dart';
import 'package:aqaratak/screens/filtration/widgets/aminities_boxes.dart';
import 'package:aqaratak/widgets/Custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helper/constants.dart';
import '../../providers/Properties_provider.dart';
import '../../widgets/Title_Builder.dart';

class FiltrationScreen extends StatefulWidget {
  FiltrationScreen({Key? key}) : super(key: key);

  @override
  State<FiltrationScreen> createState() => _FiltrationScreenState();
}

class _FiltrationScreenState extends State<FiltrationScreen> {
  final GlobalKey<FormState>? _key = new GlobalKey();

  bool loading = true;
  bool showPropertiesList = false;

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
        final MainProvider mainProvider = Provider.of<MainProvider>(
          context,
          listen: false,
        );

        await propertiesProvider.get_properties_with_categories();
        await mainProvider.get_main_properties();

        // propertiesProvider.setPriceRangeValues(
        //   SfRangeValues(
        //     0,
        //     propertiesProvider.getMaxPrice(),
        //   ),
        // );
        // propertiesProvider.setAreaRangeValues(
        //   SfRangeValues(
        //     0,
        //     propertiesProvider.getMaxArea(),
        //   ),
        // );
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

  List<Map<String, dynamic>> getOptionsFromMap(
    String key,
    MainProvider mainProvider,
    String title,
  ) {
    final Map<String, dynamic> propertyMap = mainProvider.main_properties[key];
    final List<Map<String, dynamic>> options = [];
    propertyMap.entries.forEach((element) {
      final Map<String, dynamic> option = {
        'id': element.key,
        'title': element.value,
      };
      options.add(option);
    });
    options.insert(0, {
      "title": title,
      "id": "",
    });
    return options;
  }

  List<Map<String, dynamic>> get_Property_Options_From_Map(
    String key,
    MainProvider mainProvider,
    String title,
  ) {
    final List<dynamic> propertyMap = mainProvider.main_properties[key];
    final List<Map<String, dynamic>> options = [];

    propertyMap.forEach((element) {
      final Map<String, dynamic> option = {
        'id': element['id'].toString(),
        'title': element['slug'].toString(),
      };
      options.add(option);
    });
    options.insert(0, {
      "title": title,
      "id": "",
    });
    return options;
  }

  List<Map<String, dynamic>> get_Property_Options_with_index(
    String key,
    MainProvider mainProvider,
    String title,
  ) {
    final List<dynamic> propertyMap = mainProvider.main_properties[key];
    final List<Map<String, dynamic>> options = [];

    propertyMap.asMap().forEach((index, value) {
      final Map<String, dynamic> option = {
        'id': index.toString(),
        'title': value.toString(),
      };
      options.add(option);
    });
    options.insert(0, {
      "title": title,
      "id": "",
    });
    return options;
  }

  @override
  Widget build(BuildContext context) {
    final PropertiesProvider _propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: true);
    final MainProvider _mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        if (FocusManager.instance.primaryFocus!.hasFocus)
          FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Container(
        height: 100.0.h,
        width: 100.0.w,
        child: loading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : showPropertiesList
                ? Stack(
                    children: [
                      AllPropertiesScreen(),
                      InkWell(
                        onTap: () {
                          _propertiesProvider.clear_filtration_prams();
                          setState(() {
                            showPropertiesList = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 3.0.h, horizontal: 3.0.w),
                          constraints: BoxConstraints(minHeight: 5.0.h),
                          child: Image.asset(
                            "assets/icons/filter_icon.png",
                            width: 8.0.w,
                            color: Colors.white,
                          ),
                          color: accentColorBlue,
                          // borderRadius: BorderRadius.circular(
                          //   10.0.sp,
                          // ),
                        ),
                      ),
                    ],
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0.w),
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
                                          onSaveFunc: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              _propertiesProvider
                                                      .filtration_prams[
                                                  'search'] = value.trim();
                                            }
                                          },
                                          onValidateFunc: (value) {},
                                          label: "كلمات مفتاحية",
                                          enabledBorderColor: accentColorBrown,
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        CustomTextField(
                                          textInputType: TextInputType.number,
                                          onSaveFunc: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              _propertiesProvider
                                                      .filtration_prams[
                                                  'min_size'] = value.trim();
                                            }
                                          },
                                          onValidateFunc: (value) {},
                                          label: "االمساحة الأدنى",
                                          enabledBorderColor: accentColorBrown,
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        CustomTextField(
                                          textInputType: TextInputType.number,
                                          onSaveFunc: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              _propertiesProvider
                                                      .filtration_prams[
                                                  'max_size'] = value.trim();
                                            }
                                          },
                                          onValidateFunc: (value) {},
                                          label: "المساحة الأعلى",
                                          enabledBorderColor: accentColorBrown,
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        CustomTextField(
                                          textInputType: TextInputType.number,
                                          onSaveFunc: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              _propertiesProvider
                                                      .filtration_prams[
                                                  'min_price'] = value.trim();
                                            }
                                          },
                                          onValidateFunc: (value) {},
                                          label: "السعر الأدنى",
                                          enabledBorderColor: accentColorBrown,
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        CustomTextField(
                                          textInputType: TextInputType.number,
                                          onSaveFunc: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              _propertiesProvider
                                                      .filtration_prams[
                                                  'max_price'] = value.trim();
                                            }
                                          },
                                          onValidateFunc: (value) {},
                                          label: "السعر الأعلى",
                                          enabledBorderColor: accentColorBrown,
                                        ),
                                        // Consumer<PropertiesProvider>(
                                        //   builder: (context,
                                        //           PropertiesProvider
                                        //               propertiesProvider,
                                        //           child) =>
                                        //       CustomRangeSlider(
                                        //     title: "السعر",
                                        //     min: 0,
                                        //     max: propertiesProvider.getMaxPrice(),
                                        //     onChanged: (SfRangeValues value) {
                                        //       propertiesProvider
                                        //           .setPriceRangeValues(
                                        //         value,
                                        //       );
                                        //     },
                                        //     values: _propertiesProvider
                                        //         .priceRangeValues!,
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   height: 3.0.h,
                                        // ),
                                        // Consumer<PropertiesProvider>(
                                        //   builder: (context,
                                        //           PropertiesProvider
                                        //               propertiesProvider,
                                        //           child) =>
                                        //       CustomRangeSlider(
                                        //     title: "المساحة",
                                        //     min: 0,
                                        //     max: propertiesProvider.getMaxArea(),
                                        //     onChanged: (SfRangeValues value) {
                                        //       propertiesProvider.setAreaRangeValues(
                                        //         value,
                                        //       );
                                        //     },
                                        //     values: _propertiesProvider
                                        //         .areaRangeValues!,
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 5.0.h,
                                        ),
                                        DropDownInFiltration(
                                          title: "الدولة",
                                          options: getOptionsFromMap(
                                            "countries",
                                            _mainProvider,
                                            "الدولة",
                                          ),
                                          field_key: "country",
                                        ),

                                        DropDownInFiltration(
                                          title: "المدينة",
                                          options: getOptionsFromMap(
                                            "cities",
                                            _mainProvider,
                                            "المدينة",
                                          ),
                                          field_key: "cityId",
                                        ),

                                        DropDownInFiltration(
                                          title: "المنطقة",
                                          options: getOptionsFromMap(
                                            "states",
                                            _mainProvider,
                                            "المنطقة",
                                          ),
                                          field_key: "countryStats",
                                        ),

                                        DropDownInFiltration(
                                          title: "طريقة الدفع",
                                          options: getOptionsFromMap(
                                            "methods_types",
                                            _mainProvider,
                                            "طريقة الدفع",
                                          ),
                                          field_key: "method_type",
                                        ),

                                        DropDownInFiltration(
                                          title: "الغرض من الصلاحية",
                                          options: getOptionsFromMap(
                                            "property_purposes",
                                            _mainProvider,
                                            "الغرض من الصلاحية",
                                          ),
                                          field_key: "propertyFor",
                                        ),

                                        DropDownInFiltration(
                                          title: "نوع العقار",
                                          options:
                                              get_Property_Options_From_Map(
                                            "propertyTypes",
                                            _mainProvider,
                                            "نوع العقار",
                                          ),
                                          field_key: "propertyTypeData",
                                        ),

                                        DropDownInFiltration(
                                          title: "الطوابق",
                                          options:
                                              get_Property_Options_with_index(
                                            "floors",
                                            _mainProvider,
                                            "الطوابق",
                                          ),
                                          field_key: "floors",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        DropDownInFiltration(
                                          title: "تنصيف العقار",
                                          options: getOptionsFromMap(
                                            "property_classifications",
                                            _mainProvider,
                                            "تنصيف العقار",
                                          ),
                                          field_key: "classification_id",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        DropDownInFiltration(
                                          title: "عمر العقار",
                                          options: getOptionsFromMap(
                                            "constructions_period",
                                            _mainProvider,
                                            "عمر العقار",
                                          ),
                                          field_key: "construction_period",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        DropDownInFiltration(
                                          title: "المطابخ",
                                          options:
                                              get_Property_Options_with_index(
                                            "kitchens",
                                            _mainProvider,
                                            "المطابخ",
                                          ),
                                          field_key: "kitchens",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        DropDownInFiltration(
                                          title: "غرف النوم",
                                          options:
                                              get_Property_Options_with_index(
                                            "bedrooms",
                                            _mainProvider,
                                            "غرف النوم",
                                          ),
                                          field_key: "numberOfBedroom",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        TitleBuilder(
                                          title: "مميزات العقار",
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        const AmenitiesBoxes(),
                                        SizedBox(
                                          height: 4.0.h,
                                        ),
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15.0.sp,
                                            ),
                                          ),
                                          onPressed: loading
                                              ? null
                                              : () async {
                                                  _key!.currentState!.save();
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  // // area range values
                                                  // _propertiesProvider
                                                  //             .filtration_prams[
                                                  //         'min_size'] =
                                                  //     _propertiesProvider
                                                  //         .areaRangeValues!
                                                  //         .start;
                                                  // _propertiesProvider
                                                  //             .filtration_prams[
                                                  //         'max_size'] =
                                                  //     _propertiesProvider
                                                  //         .areaRangeValues!.end;

                                                  // // price range values
                                                  // _propertiesProvider
                                                  //             .filtration_prams[
                                                  //         'min_price'] =
                                                  //     _propertiesProvider
                                                  //         .priceRangeValues!
                                                  //         .start;
                                                  // _propertiesProvider
                                                  //             .filtration_prams[
                                                  //         'max_price'] =
                                                  //     _propertiesProvider
                                                  //         .priceRangeValues!
                                                  //         .end;
                                                  await _propertiesProvider
                                                      .get_all_properties_with_prams();

                                                  setState(() {
                                                    loading = false;
                                                    showPropertiesList = true;
                                                    // _priceRangeValues =
                                                    //     SfRangeValues(
                                                    //         0,
                                                    //         _propertiesProvider
                                                    //             .getMaxPrice());
                                                    // _areaRangeValues =
                                                    //     SfRangeValues(
                                                    //         0,
                                                    //         _propertiesProvider
                                                    //             .getMaxArea());
                                                  });
                                                },
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
      ),
    );
  }
}
