import 'dart:developer';

import 'package:aqaratak/providers/main_provider.dart';
import 'package:aqaratak/screens/all_properities_screen.dart';
import 'package:aqaratak/screens/filtration/widgets/Drop_Down.dart';
import 'package:aqaratak/widgets/Custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helper/constants.dart';
import '../../models/FormValidator.dart';
import '../../providers/Properties_provider.dart';

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
        
        propertiesProvider.clear_filtration_prams();
        await propertiesProvider.get_properties_with_categories();
  

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
  void dispose() {
    if (_key != null && _key!.currentState != null) {
      _key!.currentState!.dispose();
    }
    super.dispose();
  }

  List<Map<String, dynamic>> get_cities_from_state(
    String state_id,
    MainProvider mainProvider,
    String title,
  ) {
    final List<dynamic> statesWithCities =
        mainProvider.main_properties["states"];
    final List<Map<String, dynamic>> cities = [];

    statesWithCities.forEach((element) {
      if (element["id"].toString() == state_id) {
        element["cities"].forEach((element) {
          final Map<String, dynamic> city = {
            'id': element["id"],
            'title': element["name"],
          };
          cities.add(city);
        });
        return;
      }
    });

    cities.insert(0, {
      "title": title,
      "id": "",
    });
    return cities;
  }

  List<Map<String, dynamic>> get_states(
    MainProvider mainProvider,
    String title,
  ) {
    final List<dynamic> statesWithCities =
        mainProvider.main_properties["states"];
    final List<Map<String, dynamic>> states = [];

    statesWithCities.forEach((element) {
      final Map<String, dynamic> state = {
        'id': element["id"],
        'title': element["name"],
      };
      states.add(state);
    });
    states.insert(0, {
      "title": title,
      "id": "",
    });
    return states;
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
    options.insert(
      0,
      {
        "title": title,
        "id": "",
      },
    );
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
                            vertical: 3.0.h,
                            horizontal: 3.0.w,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 1.0.h,
                            horizontal: 1.0.w,
                          ),
                          constraints: BoxConstraints(
                            minHeight: 7.0.h,
                            minWidth: 5.0.w,
                          ),
                          child: Image.asset(
                            "assets/icons/filter_icon.png",
                            width: 10.0.w,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.0.sp,
                            ),
                            color: accentColorBlue,
                          ),
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
                              "search_options".tr,
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
                                                  .set_filtration_prams(
                                                value.trim(),
                                                'search',
                                              );
                                            }
                                          },
                                          onValidateFunc: (value) {},
                                          label: "keywords".tr,
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
                                          label: "minimum_space".tr,
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
                                          label: "max_space".tr,
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
                                          label: "lowest_price".tr,
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
                                          label: "highest_price".tr,
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
                                          title: "country".tr,
                                          options: getOptionsFromMap(
                                            "countries",
                                            _mainProvider,
                                            "country".tr,
                                          ),
                                          field_key: "country",
                                        ),
                                        DropDownInFiltration(
                                          title: "المنطقة",
                                          options: get_states(
                                            _mainProvider,
                                           "city".tr,),
                                          
                                          field_key: "countryStats",
                                        ),
                                        DropDownInFiltration(
                                          title: "region".tr,
                                          options: getOptionsFromMap(
                                            "states",
                                            _mainProvider,
                                            "region".tr,
                                          ),
                                          field_key: "cityId",
                                        ),
                                        DropDownInFiltration(
                                          title: "payment_method".tr,
                                          options: getOptionsFromMap(
                                            "methods_types",
                                            _mainProvider,
                                            "payment_method".tr,
                                          ),
                                          field_key: "method_type",
                                        ),

                                        DropDownInFiltration(
                                          title: "purpose_of_validity".tr,
                                          options: getOptionsFromMap(
                                            "property_purposes",
                                            _mainProvider,
                                            "purpose_of_validity".tr,
                                          ),
                                          field_key: "propertyFor",
                                        ),

                                        DropDownInFiltration(
                                          title: "property_type".tr,
                                          options:
                                              get_Property_Options_From_Map(
                                            "propertyTypes",
                                            _mainProvider,
                                            "property_type".tr,
                                          ),
                                          field_key: "propertyTypeData",
                                        ),

                                        DropDownInFiltration(
                                          title: "floors".tr,
                                          options:
                                              get_Property_Options_with_index(
                                            "floors",
                                            _mainProvider,
                                            "floors".tr,
                                          ),
                                          field_key: "floors",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        DropDownInFiltration(
                                          title: "property_classification".tr,
                                          options: getOptionsFromMap(
                                            "property_classifications",
                                            _mainProvider,
                                            "property_classification".tr,
                                          ),
                                          field_key: "classification_id",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        DropDownInFiltration(
                                          title: "property_age".tr,
                                          options: getOptionsFromMap(
                                            "constructions_period",
                                            _mainProvider,
                                            "property_age".tr,
                                          ),
                                          field_key: "construction_period",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        DropDownInFiltration(
                                          title: "kitchens".tr,
                                          options:
                                              get_Property_Options_with_index(
                                            "kitchens",
                                            _mainProvider,
                                            "kitchens".tr,
                                          ),
                                          field_key: "kitchens",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        DropDownInFiltration(
                                          title: "bedrooms".tr,
                                          options:
                                              get_Property_Options_with_index(
                                            "bedrooms",
                                            _mainProvider,
                                            "bedrooms".tr,
                                          ),
                                          field_key: "numberOfBedroom",
                                          isEnabled: _propertiesProvider
                                                      .filtration_prams[
                                                  'propertyTypeData'] !=
                                              "1",
                                        ),

                                        // const AmenitiesBoxes(),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    accentColorBlue),
                                            padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                horizontal: 4.0.w,
                                                vertical: 1.0.h,
                                              ),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10.0.sp,
                                                ),
                                                side: BorderSide(
                                                  color: accentColorBrown,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              constraints: BoxConstraints(
                                                minHeight: 50.0.h,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10.0.sp,
                                                ),
                                              ),
                                              isScrollControlled:
                                                  true, // required for min/max child size
                                              context: context,

                                              builder: (ctx) {
                                                return Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: MultiSelectBottomSheet(
                                                    initialChildSize: 0.5,
                                                    maxChildSize: 0.7,
                                                    title: Text(
                                                      "مميزات العقار",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: accentColorBrown,
                                                      ),
                                                    ),
                                                    listType:
                                                        MultiSelectListType
                                                            .CHIP,
                                                    items: [
                                                      ..._propertiesProvider
                                                          .get_amenities_by_property_type(
                                                            _mainProvider
                                                                .main_properties[
                                                                    'propertyTypes']
                                                                .toList(),
                                                            _propertiesProvider
                                                                    .filtration_prams[
                                                                'propertyTypeData'],
                                                            "properties_type_active_ammonites_label",
                                                            _mainProvider
                                                                    .main_properties[
                                                                'property_aminities'],
                                                          )
                                                          .entries
                                                          .map(
                                                            (entry) =>
                                                                MultiSelectItem<
                                                                    String>(
                                                              entry.key
                                                                  .toString(),
                                                              entry.value
                                                                  .toString(),
                                                            ),
                                                          ),
                                                    ],

                                                    initialValue: [],
                                                    colorator: (value) =>
                                                        accentColorBrown,
                                                    onSelectionChanged: (
                                                      List<dynamic>
                                                          selectedValues,
                                                    ) {
                                                      _propertiesProvider
                                                          .set_amenities_filtration_prams(
                                                        selectedValues,
                                                      );
                                                    },
                                                    itemsTextStyle: TextStyle(
                                                      color: accentColorBlue,
                                                    ),
                                                    selectedItemsTextStyle:
                                                        TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    cancelText: Text(
                                                      "إلغاء",
                                                      style: TextStyle(
                                                        color: accentColorBrown,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    confirmText: Text(
                                                      "تم",
                                                      style: TextStyle(
                                                        color: accentColorBrown,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            "اختر من ميزات العقار",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0.sp,
                                            ),
                                          ),
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
                                          onPressed: loading
                                              ? null
                                              : () async {
                                                  _key!.currentState!.save();
                                                  if (mounted)
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                  log(_propertiesProvider
                                                      .filtration_prams
                                                      .toString());

                                                  await _propertiesProvider
                                                      .get_all_properties_with_prams();
                                                  if (mounted)
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
                                            'search'.tr,
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

  Widget maxMinPriceAndSizeFields(PropertiesProvider _propertiesProvider) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0.w,
                ),
                child: Text(
                  "المساحة الأدنى",
                  style: TextStyle(
                    fontSize: 10.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomTextField(
                textInputType: TextInputType.number,
                onSaveFunc: (value) {
                  _propertiesProvider.set_filtration_prams(
                    value!.trim(),
                    "min_size",
                  );
                },
                onValidateFunc: (value) {
                  return FormValidator().validateNumber(value);
                },
                label: "المساحة الأدنى",
                enabledBorderColor: accentColorBlue,
                focusedBorderColor: accentColorBlue,
                textStyle: TextStyle(color: accentColorBlue),
                hintTextColor: accentColorBlue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3.0.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0.w,
                ),
                child: Text(
                  "المساحة الأعلى",
                  style: TextStyle(
                    fontSize: 10.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomTextField(
                textInputType: TextInputType.number,
                onSaveFunc: (value) {
                  _propertiesProvider.set_filtration_prams(
                    value!.trim(),
                    "max_size",
                  );
                },
                onValidateFunc: (value) {
                  return FormValidator().validateNumber(value);
                },
                label: "المساحة الأعلى",
                enabledBorderColor: accentColorBlue,
                focusedBorderColor: accentColorBlue,
                textStyle: TextStyle(color: accentColorBlue),
                hintTextColor: accentColorBlue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3.0.h,
        ),
        Divider(
          height: 2.0.sp,
          color: greyColor,
        ),
        SizedBox(
          height: 3.0.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0.w,
                ),
                child: Text(
                  "السعر الأدنى",
                  style: TextStyle(
                    fontSize: 10.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomTextField(
                textInputType: TextInputType.number,
                onSaveFunc: (value) {
                  _propertiesProvider.set_filtration_prams(
                    value!.trim(),
                    "min_price",
                  );
                },
                onValidateFunc: (value) {
                  return FormValidator().validateNumber(value);
                },
                label: "السعر الأدنى",
                enabledBorderColor: accentColorBlue,
                focusedBorderColor: accentColorBlue,
                textStyle: TextStyle(color: accentColorBlue),
                hintTextColor: accentColorBlue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3.0.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0.w,
                ),
                child: Text(
                  "السعر الأعلى",
                  style: TextStyle(
                    fontSize: 10.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomTextField(
                textInputType: TextInputType.number,
                onSaveFunc: (value) {
                  _propertiesProvider.set_filtration_prams(
                    value!.trim(),
                    "max_price",
                  );
                },
                onValidateFunc: (value) {
                  return FormValidator().validateNumber(value);
                },
                label: "السعر الأعلى",
                enabledBorderColor: accentColorBlue,
                focusedBorderColor: accentColorBlue,
                textStyle: TextStyle(color: accentColorBlue),
                hintTextColor: accentColorBlue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3.0.h,
        ),
      ]);
}
