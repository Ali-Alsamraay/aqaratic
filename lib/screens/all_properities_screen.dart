import 'package:aqaratak/screens/unit_details_screen.dart';
import 'package:aqaratak/widgets/Title_Builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../models/property.dart';
import '../providers/Properties_provider.dart';
import '../widgets/Unit_Item.dart';

class AllPropertiesScreen extends StatefulWidget {
  const AllPropertiesScreen({Key? key}) : super(key: key);

  @override
  State<AllPropertiesScreen> createState() => _AllPropertiesScreenState();
}

class _AllPropertiesScreenState extends State<AllPropertiesScreen> {
  final ScrollController? filtrationScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: false);

    filtrationScrollController!.addListener(() {
      if (filtrationScrollController!.position.pixels >=
              filtrationScrollController!.position.maxScrollExtent &&
          !propertiesProvider.getting_more_data!) {
        propertiesProvider.get_more_properties_with_prams();
      }
    });
  }

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
            propertiesProviderData.filteredPropertiesWithPrams.length == 0
                ? Center(
                    child: TitleBuilder(
                      title: 'لا توجد عقارات بهذه المواصفات',
                    ),
                  )
                : ListView.builder(
                    itemCount: propertiesProviderData
                        .filteredPropertiesWithPrams.length,
                    scrollDirection: Axis.vertical,
                    controller: filtrationScrollController,
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
                          value: propertiesProviderData
                              .filteredPropertiesWithPrams[index],
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
