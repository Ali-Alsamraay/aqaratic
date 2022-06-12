import 'package:aqaratak/providers/Maps_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/constants.dart';
import '../../providers/Properties_provider.dart';
import 'package:sizer/sizer.dart';

import 'widgets/Map_Tab.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  void dispose() {
    // if (myMapController != null) myMapController!.dispose();
    super.dispose();
  }

  List<MapTab> mapsTabs = [];

  @override
  void initState() {
    super.initState();
    mapsTabs = Provider.of<PropertiesProvider>(context, listen: false)
        .property_types_items!
        .map(
          (e) => MapTab(
            categoryId: e['id'],
          ),
        )
        .toList();
  }

  int? categoryId = -1;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: backgroundColor,
          body: Container(
            width: 100.0.w,
            height: 100.0.h,
            child: mapsTabs[
                Provider.of<MapsProvider>(context).navigationMapTabsIndex],
          ),
        ),
      ),
    );
  }
}
