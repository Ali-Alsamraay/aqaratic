import 'package:aqaratak/screens/unit_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../models/property.dart';
import '../providers/Properties_provider.dart';
import '../widgets/Title_Builder.dart';
import '../widgets/Unit_Item.dart';

class AllPropertiesScreen extends StatelessWidget {
  const AllPropertiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0.h,
      width: 100.0.w,
      child: Consumer<PropertiesProvider>(
        builder: (
          context,
          propertiesProviderData,
          child,
        ) =>
            ListView.builder(
          itemCount: propertiesProviderData.filteredPropertiesWithPrams.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UnitDetailsScreen(),
                  ),
                );
              },
              child: ChangeNotifierProvider<Property>.value(
                value:
                    propertiesProviderData.filteredPropertiesWithPrams[index],
                child: Container(
                    height: 30.0.h,
                    margin: EdgeInsets.symmetric(vertical: 1.0.h),
                    child: UnitItem()),
              ),
            );
          },
        ),
      ),
    );
  }
}
