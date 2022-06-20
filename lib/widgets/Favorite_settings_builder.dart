import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/FormValidator.dart';
import 'package:aqaratak/widgets/Custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../providers/Properties_provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/main_provider.dart';
import 'Drop_Down_favorite_settings.dart';

class FavoriteSettingsBuilder extends StatefulWidget {
  const FavoriteSettingsBuilder({Key? key}) : super(key: key);

  @override
  State<FavoriteSettingsBuilder> createState() =>
      _FavoriteSettingsBuilderState();
}

class _FavoriteSettingsBuilderState extends State<FavoriteSettingsBuilder> {
  final GlobalKey<FormState>? _form_key = new GlobalKey();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        Provider.of<FavoritesProvider>(
          context,
          listen: false,
        ).clear_favorites_prams();

        final PropertiesProvider propertiesProvider =
            Provider.of<PropertiesProvider>(
          context,
          listen: false,
        );
     

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
    if (_form_key != null && _form_key!.currentState != null) {
      _form_key!.currentState!.dispose();
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
    final MainProvider _mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    final FavoritesProvider _favoritesProvider = Provider.of<FavoritesProvider>(
      context,
    );

    return Container(
      width: 95.0.w,
      height: 60.0.h + MediaQuery.of(context).viewInsets.bottom,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            10.0.sp,
          ),
          topRight: Radius.circular(
            10.0.sp,
          ),
        ),
        color: accentColorBlue,
      ),
      child: loading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0.w,
                      vertical: 2.0.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Image.asset(
                            "assets/icons/cancel_icon.png",
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "الرجاء اختيار الاعدادات المفضلة",
                          style: GoogleFonts.getFont(
                            "Cairo",
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                              child: Form(
                                key: _form_key,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    maxMinPriceAndSizeFields(
                                      _favoritesProvider,
                                    ),
                                    SizedBox(
                                      height: 3.0.h,
                                    ),
                                    DropDownInFavorite(
                                      dropDownColor: Colors.white,
                                      title: "الدولة",
                                      options: getOptionsFromMap(
                                        "countries",
                                        _mainProvider,
                                        "الدولة",
                                      ),
                                      field_key: "country",
                                    ),
                                    DropDownInFavorite(
                                      dropDownColor: Colors.white,
                                      title: "المنطقة",
                                      options: get_states(
                                        _mainProvider,
                                        "المنطقة",
                                      ),
                                      field_key: "countryStats",
                                    ),
                                    DropDownInFavorite(
                                      dropDownColor: Colors.white,
                                      title: "المدينة",
                                      options: get_cities_from_state(
                                        _favoritesProvider
                                            .favorites_prams['countryStats'],
                                        _mainProvider,
                                        "المدينة",
                                      ),
                                      field_key: "cityId",
                                    ),
                                    DropDownInFavorite(
                                      dropDownColor: Colors.white,
                                      title: "الغرض من الصلاحية",
                                      options: getOptionsFromMap(
                                        "property_purposes",
                                        _mainProvider,
                                        "الغرض من الصلاحية",
                                      ),
                                      field_key: "propertyFor",
                                    ),
                                    DropDownInFavorite(
                                      dropDownColor: Colors.white,
                                      title: "نوع العقار",
                                      options: get_Property_Options_From_Map(
                                        "propertyTypes",
                                        _mainProvider,
                                        "نوع العقار",
                                      ),
                                      field_key: "propertyTypeData",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.0.h,
                          ),
                          SizedBox(
                            height: 10.0.h,
                            width: 90.0.w,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0.h),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    accentColorBrown,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0.sp),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: Text(
                                    "حفظ",
                                    style: GoogleFonts.getFont(
                                      "Cairo",
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: loading
                                    ? null
                                    : () async {
                                        if (_form_key!.currentState!
                                            .validate()) {
                                          _form_key!.currentState!.save();
                                          if (mounted)
                                            setState(
                                              () {
                                                loading = true;
                                              },
                                            );

                                          final message =
                                              await _favoritesProvider
                                                  .add_selected_favorites();
                                          final snackBar = SnackBar(
                                            elevation: 6.0,
                                            backgroundColor: accentColorBrown,
                                            behavior: SnackBarBehavior.floating,
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    message.toString(),
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.fade,
                                                    style: GoogleFonts.getFont(
                                                      "Cairo",
                                                      fontSize: 12.0.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.done_rounded,
                                                  color: Colors.white,
                                                  size: 15.0.sp,
                                                ),
                                              ],
                                            ),
                                          );
                                          if (mounted)
                                            setState(
                                              () {
                                                loading = false;
                                              },
                                            );
                                          Navigator.pop(context);
                                          await ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
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
              ],
            ),
    );
  }

  Widget maxMinPriceAndSizeFields(FavoritesProvider _favoritesProvider) =>
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomTextField(
                textInputType: TextInputType.number,
                onSaveFunc: (value) {
                  _favoritesProvider.set_favorites_prams(
                    value!.trim(),
                    "min_size",
                  );
                },
                onValidateFunc: (value) {
                  return FormValidator().validateNumber(value);
                },
                label: "المساحة الأدنى",
                enabledBorderColor: Colors.white,
                focusedBorderColor: Colors.white,
                textStyle: TextStyle(color: Colors.white),
                hintTextColor: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomTextField(
                textInputType: TextInputType.number,
                onSaveFunc: (value) {
                  _favoritesProvider.set_favorites_prams(
                    value!.trim(),
                    "max_size",
                  );
                },
                onValidateFunc: (value) {
                  return FormValidator().validateNumber(value);
                },
                label: "المساحة الأعلى",
                enabledBorderColor: Colors.white,
                focusedBorderColor: Colors.white,
                textStyle: TextStyle(color: Colors.white),
                hintTextColor: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomTextField(
                textInputType: TextInputType.number,
                onSaveFunc: (value) {
                  _favoritesProvider.set_favorites_prams(
                    value!.trim(),
                    "min_price",
                  );
                },
                onValidateFunc: (value) {
                  return FormValidator().validateNumber(value);
                },
                label: "السعر الأدنى",
                enabledBorderColor: Colors.white,
                focusedBorderColor: Colors.white,
                textStyle: TextStyle(color: Colors.white),
                hintTextColor: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomTextField(
                textInputType: TextInputType.number,
                onSaveFunc: (value) {
                  _favoritesProvider.set_favorites_prams(
                    value!.trim(),
                    "max_price",
                  );
                },
                onValidateFunc: (value) {
                  return FormValidator().validateNumber(value);
                },
                label: "السعر الأعلى",
                enabledBorderColor: Colors.white,
                focusedBorderColor: Colors.white,
                textStyle: TextStyle(color: Colors.white),
                hintTextColor: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3.0.h,
        ),
      ]);
}
