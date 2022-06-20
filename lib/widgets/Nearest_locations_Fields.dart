import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/providers/State_Manager_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/Utils.dart';
import '../models/FormValidator.dart';
import '../providers/Properties_provider.dart';
import 'Custom_TextField_Builder.dart';
import 'package:sizer/sizer.dart';

import 'DropDwon_Builder.dart';

class NearestLocationsFields extends StatelessWidget {
  NearestLocationsFields({
    Key? key,
  }) : super(key: key);
  final FormValidator? formValidator = FormValidator();

  final Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    final StateManagerProvider stateManagerProvider =
        Provider.of<StateManagerProvider>(
      context,
    );
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: false);
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 2.0.h,
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 1.0.h),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: accentColorBlue,
                width: 0.2.sp,
              ),
            ),
            child: Container(
              width: 85.0.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0.sp,
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 2.0.w,
                vertical: 1.0.h,
              ),
              child: Column(
                children: [
                  CustomTextFieldBuilder(
                    textInputHeight: 7.0.h,
                    formValidator: formValidator,
                    propertiesProvider: propertiesProvider,
                    langKey: "distance",
                    heightAfterField: 1.0.h,
                    textInputType: TextInputType.number,
                    isListOfvalues: true,
                  ),
                  DropDownBuilder(
                    langKey_fieldTitle:
                        propertiesProvider.get_Label_Text_By_Lang_key(
                      "select_nearest_loc",
                    ),
                    heightAfterField: 1.0.h,
                    langKey: "nearest_loc",
                    optionTitle: "location",
                    isListOfvalues: true,
                    options: propertiesProvider.nearest_locations_Objects,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<StateManagerProvider>(
                        context,
                        listen: false,
                      ).add_location_And_Distance_Block(
                        LocationAndDistanceBlock(
                          formValidator: formValidator,
                          propertiesProvider: propertiesProvider,
                          removable: true,
                          key: UniqueKey(),
                          index: stateManagerProvider
                                  .locationAndDistanceBlocks.length -
                              1,
                        ),
                      );
                    },
                    child: Container(
                      height: 6.0.h,
                      decoration: BoxDecoration(
                        color: accentColorBlue,
                        borderRadius: BorderRadius.circular(
                          10.0.sp,
                        ),
                        border: Border.all(
                          width: 1.sp,
                          color: accentColorBrown,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Consumer<StateManagerProvider>(
            builder: (context, value, child) => Column(
              children: [
                ...List.generate(
                  value.locationAndDistanceBlocks.length,
                  (index) {
                    value.locationAndDistanceBlocks[index].index = index;
                    return value.locationAndDistanceBlocks[index];
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
        ],
      ),
    );
  }
}

class LocationAndDistanceBlock extends StatelessWidget {
  LocationAndDistanceBlock({
    Key? key,
    required this.removable,
    required this.formValidator,
    required this.index,
    required this.propertiesProvider,
  }) : super(key: key);
  final bool? removable;
  final FormValidator? formValidator;
  final PropertiesProvider? propertiesProvider;
  int? index;
  @override
  Widget build(BuildContext context) {
    final StateManagerProvider stateManagerProvider =
        Provider.of<StateManagerProvider>(context, listen: false);
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 1.0.h),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: accentColorBlue,
            width: 0.2.sp,
          ),
        ),
        child: Container(
          width: 85.0.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0.sp,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 2.0.w,
            vertical: 1.0.h,
          ),
          child: Column(
            children: [
              CustomTextFieldBuilder(
                key: UniqueKey(),
                isListOfvalues: true,
                textInputHeight: 7.0.h,
                formValidator: formValidator,
                propertiesProvider: propertiesProvider,
                langKey: "distance",
                heightAfterField: 1.0.h,
                textInputType: TextInputType.number,
              ),
              DropDownBuilder(
                key: UniqueKey(),
                isListOfvalues: true,
                langKey_fieldTitle:
                    propertiesProvider!.get_Label_Text_By_Lang_key(
                  "select_nearest_loc",
                ),
                heightAfterField: 1.0.h,
                langKey: "nearest_loc",
                optionTitle: "location",
                options: propertiesProvider!.nearest_locations_Objects,
              ),
              GestureDetector(
                onTap: !removable!
                    ? () {
                        stateManagerProvider.add_location_And_Distance_Block(
                          LocationAndDistanceBlock(
                            formValidator: formValidator,
                            propertiesProvider: propertiesProvider,
                            removable: true,
                            key: UniqueKey(),
                            index: index,
                          ),
                        );
                      }
                    : () {
                        stateManagerProvider.remove_location_And_Distance_Block(
                          index!,
                        );
                      },
                child: Container(
                  height: 6.0.h,
                  decoration: BoxDecoration(
                    color: removable! ? Colors.red : accentColorBlue,
                    borderRadius: BorderRadius.circular(
                      10.0.sp,
                    ),
                    border: Border.all(
                      width: 1.sp,
                      color: accentColorBrown,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      removable! ? Icons.delete_forever_rounded : Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
