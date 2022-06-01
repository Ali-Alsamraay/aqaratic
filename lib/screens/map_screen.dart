import 'dart:async';
import 'dart:developer';

import 'package:aqaratak/providers/Maps_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';
import '../providers/Properties_provider.dart';
import 'package:sizer/sizer.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  void dispose() {
    if (myMapController != null) myMapController!.dispose();
    super.dispose();
  }

  bool? loading = true;
  bool? isThereError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await Provider.of<MapsProvider>(
          context,
          listen: false,
        ).get_markers_for_category_on_map(
          categoryId,
          Provider.of<PropertiesProvider>(
            context,
            listen: false,
          ).properties,
        );
        setState(() {
          loading = false;
          isThereError = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
          isThereError = true;
        });
      }
    });
  }

  GoogleMapController? myMapController;
  Completer<GoogleMapController> _controller = Completer();
  MapType? mapType = MapType.terrain;
  final LatLng _mainLocation = const LatLng(24.7136, 46.6753);
  int? categoryId = -1;
  CategoriesOnMap categoryOnMap = CategoriesOnMap();
  Map? map;

  GoogleMap? gm = null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
            backgroundColor: accentColorBrown,
            child: Icon(
              mapType == MapType.satellite
                  ? Icons.satellite_alt
                  : Icons.terrain,
            ),
            onPressed: () async {
              // categoryOnMap = CategoriesOnMap();

              if (mapType == MapType.terrain) {
                setState(() {
                  mapType = MapType.satellite;
                });
              } else {
                setState(() {
                  mapType = MapType.terrain;
                });
              }
            }),
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            FutureBuilder(
              future: Provider.of<MapsProvider>(context, listen: false)
                  .get_markers_for_category_on_map(
                categoryId,
                Provider.of<PropertiesProvider>(context, listen: false)
                    .properties,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.error == null) {
                    return Consumer<MapsProvider>(
                      builder: (context, MapsProvider mapsProvider, child) {
                        gm = null;
                        if (myMapController != null) myMapController!.dispose();
                        gm = GoogleMap(
                          mapToolbarEnabled: true,
                          trafficEnabled: true,
                          myLocationButtonEnabled: true,
                          onMapCreated: (controller) {
                            myMapController = controller;
                            _controller.complete(controller);
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(24.7136, 46.6753),
                            zoom: 3.5,
                          ),
                          markers: mapsProvider.markers,
                        );
                        return gm!;
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return Text("There is an error");
                  } else {
                    return AlertDialog(
                      content: Text('State: ${snapshot.connectionState}'),
                    );
                  }
                }
                return Text("no data");
              },
            ),
            categoryOnMap,

            // loading!
            //     ? Center(
            //         child: CircularProgressIndicator.adaptive(),
            //       )
            //     : Container(
            //         child: Align(
            //           alignment: Alignment.topCenter,
            //           child: Container(
            //             margin: EdgeInsets.only(right: 5.0.w),
            //             height: 25.0.h,
            //             width: 100.0.w,
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 SizedBox(
            //                   height: 3.0.h,
            //                 ),
            //                 Expanded(
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Text(
            //                         "قائمة العقارات",
            //                         style: TextStyle(
            //                           color: accentColorBlue,
            //                           fontSize: 17.0.sp,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Expanded(
            //                   child: Row(
            //                     children: [
            //                       SearchBarOnMap(),
            //                       SizedBox(
            //                         width: 2.0.w,
            //                       ),
            //                       Container(
            //                         constraints:
            //                             BoxConstraints(minHeight: 5.0.h),
            //                         child: Image.asset(
            //                           "assets/icons/filter_icon.png",
            //                           width: 8.0.w,
            //                         ),
            //                         padding: EdgeInsets.all(2.0.w),
            //                         decoration: BoxDecoration(
            //                           border: Border.all(
            //                             width: 0.5.sp,
            //                             color: accentColorBlue,
            //                           ),
            //                           color: Colors.white,
            //                           borderRadius: BorderRadius.circular(
            //                             10.0.sp,
            //                           ),
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 2.0.h,
            //                 ),
            //                 Expanded(
            //                   child: ListView.builder(
            //                     clipBehavior: Clip.none,
            //                     shrinkWrap: true,
            //                     scrollDirection: Axis.horizontal,
            //                     itemCount: Provider.of<PropertiesProvider>(
            //                             context,
            //                             listen: false)
            //                         .property_types_items!
            //                         .length,
            //                     itemBuilder: (context, index) =>
            //                         GestureDetector(
            //                       onTap: () async {
            //                         final category_item =
            //                             Provider.of<PropertiesProvider>(
            //                           context,
            //                           listen: false,
            //                         ).property_types_items![index];
            //                         // setState(() {
            //                         //   widget.selectedIndex = index;
            //                         // });
            //                         await Provider.of<PropertiesProvider>(
            //                           context,
            //                           listen: false,
            //                         ).get_markers_for_category_on_map(
            //                           category_item['id'],
            //                         );
            //                       },
            //                       child: Container(
            //                         child: CategoryOnMapItem(
            //                           index: index,
            //                           selectedIndex: -1,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
          ],
        ),
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({Key? key, this.markers}) : super(key: key);

  final Set<Marker>? markers;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapToolbarEnabled: true,
      trafficEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(24.7136, 46.6753),
        zoom: 3.5,
      ),
      markers: markers!,
    );
    // return Center(
    //   child: Text(propertiesProvider.markers.length.toString()),
    // );
  }
}

class CategoriesOnMap extends StatefulWidget {
  CategoriesOnMap({Key? key}) : super(key: key);
  int? selectedIndex = 0;

  @override
  State<CategoriesOnMap> createState() => _CategoriesOnMapState();
}

class _CategoriesOnMapState extends State<CategoriesOnMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(right: 5.0.w),
          height: 25.0.h,
          width: 100.0.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.0.h,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "قائمة العقارات",
                      style: TextStyle(
                        color: accentColorBlue,
                        fontSize: 17.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    SearchBarOnMap(),
                    SizedBox(
                      width: 2.0.w,
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 5.0.h),
                      child: Image.asset(
                        "assets/icons/filter_icon.png",
                        width: 8.0.w,
                      ),
                      padding: EdgeInsets.all(2.0.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5.sp,
                          color: accentColorBlue,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10.0.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Expanded(
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      Provider.of<PropertiesProvider>(context, listen: false)
                          .property_types_items!
                          .length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      final category_item = Provider.of<PropertiesProvider>(
                        context,
                        listen: false,
                      ).property_types_items![index];
                      setState(() {
                        widget.selectedIndex = index;
                      });
                      log(category_item['id'].toString());
                      await Provider.of<MapsProvider>(context, listen: false)
                          .get_markers_for_category_on_map(
                        category_item['id'],
                        Provider.of<PropertiesProvider>(context, listen: false)
                            .properties,
                      );
                    },
                    child: CategoryOnMapItem(
                      index: index,
                      selectedIndex: widget.selectedIndex,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarOnMap extends StatelessWidget {
  const SearchBarOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78.0.w,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.sp,
          color: accentColorBlue,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0.sp,
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 2.0.w,
          ),
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 25.0.sp,
          ),
          SizedBox(
            width: 5.0.w,
          ),
          Expanded(
            child: SizedBox(
              child: TextFormField(
                onChanged: (keyWors) {
                  Provider.of<PropertiesProvider>(context, listen: false)
                      .searchByTitle(keyWors);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'عما تبحث',
                  hintStyle: TextStyle(
                    color: Color(0xffb3bbcb),
                    fontSize: 17.0.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryOnMapItem extends StatelessWidget {
  const CategoryOnMapItem({
    Key? key,
    required this.index,
    required this.selectedIndex,
  }) : super(key: key);
  final int? index;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(
          left: 2.5.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 4.0.w,
        ),
        decoration: BoxDecoration(
          color: selectedIndex == index ? accentColorBlue : Colors.white,
          borderRadius: BorderRadius.circular(
            10.0.sp,
          ),
          border: Border.all(
            width: 0.8.sp,
            color: accentColorBrown,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Provider.of<PropertiesProvider>(context, listen: false)
                        .property_types_items![index!]['id'] ==
                    -1
                ? Icon(
                    Icons.border_all_rounded,
                    color: accentColorBrown,
                    size: 22.0.sp,
                  )
                : SvgPicture.asset(
                    Provider.of<PropertiesProvider>(context, listen: false)
                        .property_types_items![index!]['icon_path'],
                    height: 7.0.w,
                    width: 7.0.w,
                    semanticsLabel: '',
                  ),
            SizedBox(
              width: 1.5.w,
            ),
            Text(
              Provider.of<PropertiesProvider>(context, listen: false)
                  .property_types_items![index!]['title'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selectedIndex == index ? Colors.white : accentColorBlue,
                fontSize: 10.0.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
