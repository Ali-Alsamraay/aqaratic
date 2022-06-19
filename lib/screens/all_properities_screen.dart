import 'dart:developer';

import 'package:aqaratak/screens/unit_details_screen.dart';
import 'package:aqaratak/widgets/Title_Builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../models/property.dart';
import '../providers/Properties_provider.dart';
import '../widgets/Unit_Item.dart';

class AllPropertiesScreen extends StatefulWidget {
   const AllPropertiesScreen({Key? key, this.fromHome = false}) : super(key: key);

  final bool fromHome;
  @override
  State<AllPropertiesScreen> createState() => _AllPropertiesScreenState();
}

class _AllPropertiesScreenState extends State<AllPropertiesScreen> {
  final ScrollController? filtrationScrollController = ScrollController();
  bool isCalled = false;
  @override
  void initState() {
    super.initState();
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: false);

    filtrationScrollController!.addListener(() {
      if (isCalled) return;
      isCalled = true;
      log("message v2");
      if (filtrationScrollController!.position.pixels >=
          filtrationScrollController!.position.maxScrollExtent) {
        // propertiesProvider.gettingMoreData(true);
        propertiesProvider.get_more_properties_with_prams();
        isCalled = false;
        // propertiesProvider.gettingMoreData(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.fromHome ? Scaffold(
      body: Container(
        width: 100.0.w,
        height: 100.0.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: mainScreenProperties(),
      ),
    ) : mainScreenProperties();
  }

  Widget mainScreenProperties(){
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
            title: 'no_properties'.tr,
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
