// import 'package:aqaratak/helper/constants.dart';
// import 'package:aqaratak/screens/search_results_screen.dart';
// import 'package:aqaratak/screens/units_list_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';

// import '../helper/endpoints.dart';
// import '../helper/networking.dart';


// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   SfRangeValues _priceSliderRange = const SfRangeValues(50000.0, 200000.0);
//   SfRangeValues _areaSliderRange = const SfRangeValues(80.0, 800.0);
//   List<bool> isSelected = [true, false, false];
//   List<bool> isSelectedDistance = [true, false, false, false, false, false];
//   List<bool> isSelectedRooms = [true, false, false, false];
//   Map<String, SvgPicture> categories = {
//     'أراضي': SvgPicture.asset(
//       'assets/images/land_icon.svg',
//       height: 50.0,
//       width: 50.0,
//     ),
//     'عماير': SvgPicture.asset('assets/images/building_icon.svg',
//         height: 50.0, width: 50.0),
//     'فيلا': SvgPicture.asset('assets/images/villa_icon.svg',
//         height: 50.0, width: 50.0),
//   };
//   List<String> distanceList = [
//     '10 KM ',
//     '30 KM',
//     '60 KM',
//     '90 KM',
//     '100 KM',
//     '150 KM'
//   ];
//   List<String> roomList = [
//     '1 ',
//     '2',
//     '3',
//     '4',
//     '5',
//   ];
//   GetAllUnitsInfoModel _getAllUnitsInfoModel = GetAllUnitsInfoModel();
//   bool showLoader = false;
//   Future<GetAllUnitsInfoModel> getAllUnits() async {
//     Map<String, dynamic> paramaters = {};
//     NetworkHelper getAllUnits = NetworkHelper(
//         endpoint: aqarUnitsEndpoint, params: paramaters, context: context);
//     var dataMap = await getAllUnits.getRequest();

//     if (dataMap != null) {
//       _getAllUnitsInfoModel = GetAllUnitsInfoModel.fromJson(dataMap);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => SearchResultsScreen(
//                     searchResultModel: _getAllUnitsInfoModel.results!,
//                   )));
//     }
//     showLoader = false;

//     return _getAllUnitsInfoModel;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: LoadingOverlay(
//           isLoading: showLoader,
//           child: Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/white_background.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: SafeArea(
//               child: Container(
//                 padding: EdgeInsets.only(right: 20, left: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Container(
//                     //     width: double.infinity,
//                     //     height: 50,
//                     //     margin: EdgeInsets.only(top: 10),
//                     //     child: TextFormField(
//                     //       decoration: InputDecoration(
//                     //         contentPadding: EdgeInsets.all(10.0),
//                     //         border: OutlineInputBorder(
//                     //           borderRadius: BorderRadius.circular(15.0),
//                     //         ),
//                     //         filled: true,
//                     //         hintText: 'المكان',
//                     //         hintStyle:
//                     //             TextStyle(color: Color(0xffb3bbcb), fontSize: 20),
//                     //         suffixIcon: UnconstrainedBox(
//                     //           child: SvgPicture.asset(
//                     //             'assets/images/target_icon.svg',
//                     //             width: 25,
//                     //             height: 25,
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     )),
//                     const Text("الفئات",
//                         style: TextStyle(
//                             color: Color(0xff0c2757),
//                             fontWeight: FontWeight.w700,
//                             fontStyle: FontStyle.normal,
//                             fontSize: 14.0),
//                         textAlign: TextAlign.left),
//                     Ink(
//                       width: 400,
//                       height: 140,
//                       color: Colors.white,
//                       child: GridView.count(
//                         primary: true,
//                         crossAxisCount: 3, //set the number of buttons in a row
//                         crossAxisSpacing:
//                             8, //set the spacing between the buttons
//                         childAspectRatio:
//                             1, //set the width-to-height ratio of the button,
//                         //>1 is a horizontal rectangle
//                         children: List.generate(isSelected.length, (index) {
//                           //using Inkwell widget to create a button
//                           return InkWell(
//                               //the default splashColor is grey
//                               onTap: () {
//                                 //set the toggle logic
//                                 setState(() {
//                                   for (int indexBtn = 0;
//                                       indexBtn < isSelected.length;
//                                       indexBtn++) {
//                                     if (indexBtn == index) {
//                                       isSelected[indexBtn] = true;
//                                     } else {
//                                       isSelected[indexBtn] = false;
//                                     }
//                                   }
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: isSelected[index]
//                                         ? accentColorBlue
//                                         : Colors.white,
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(10)),
//                                     border: Border.all(color: Colors.black12)),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     categories.values.elementAt(index),
//                                     Text(
//                                       '${categories.keys.elementAt(index)}',
//                                       style: TextStyle(
//                                           color: isSelected[index]
//                                               ? Colors.white
//                                               : accentColorBlue),
//                                     )
//                                   ],
//                                 ),
//                               ));
//                         }),
//                       ),
//                     ),
//                     Text("النطاق السعرى",
//                         style: TextStyle(
//                           color: accentColorBlue,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         )),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     SfRangeSlider(
//                       min: 1000.0,
//                       max: 1000000.0,
//                       inactiveColor: primaryColor,
//                       activeColor: accentColorBrown,
//                       values: _priceSliderRange,
//                       tooltipTextFormatterCallback:
//                           (dynamic actualValue, String formattedText) {
//                         return actualValue.toStringAsFixed(0);
//                       },
//                       showTicks: false,
//                       showLabels: false,
//                       shouldAlwaysShowTooltip: true,
//                       minorTicksPerInterval: 0,
//                       onChanged: (SfRangeValues values) {
//                         setState(() {
//                           _priceSliderRange = values;
//                         });
//                       },
//                     ),
//                     const Text("المسافة لوسط المدينة",
//                         style: TextStyle(
//                           color: accentColorBlue,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                         )),
//                     Ink(
//                       width: 400,
//                       height: 75,
//                       color: Colors.white,
//                       child: GridView.count(
//                         primary: true,
//                         crossAxisCount: 6, //set the number of buttons in a row
//                         crossAxisSpacing:
//                             8, //set the spacing between the buttons
//                         childAspectRatio:
//                             1, //set the width-to-height ratio of the button,
//                         //>1 is a horizontal rectangle
//                         children:
//                             List.generate(isSelectedDistance.length, (index) {
//                           //using Inkwell widget to create a button
//                           return InkWell(
//                               //the default splashColor is grey
//                               onTap: () {
//                                 //set the toggle logic
//                                 setState(() {
//                                   for (int indexBtn = 0;
//                                       indexBtn < isSelectedDistance.length;
//                                       indexBtn++) {
//                                     if (indexBtn == index) {
//                                       isSelectedDistance[indexBtn] = true;
//                                     } else {
//                                       isSelectedDistance[indexBtn] = false;
//                                     }
//                                   }
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   //set the background color of the button when it is selected/ not selected
//                                   color: isSelectedDistance[index]
//                                       ? accentColorBlue
//                                       : Colors.white,
//                                   // here is where we set the rounded corner
//                                   borderRadius: BorderRadius.circular(8),
//                                   //don't forget to set the border,
//                                   //otherwise there will be no rounded corner
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     distanceList[index],
//                                     textDirection: TextDirection.ltr,
//                                     style: TextStyle(
//                                         color: isSelectedDistance[index]
//                                             ? Colors.white
//                                             : accentColorBlue),
//                                     //set the color of the icon when it is selected/ not selected
//                                   ),
//                                 ),
//                               ));
//                         }),
//                       ),
//                     ),
//                     const Text("غرف",
//                         style: TextStyle(
//                           color: accentColorBlue,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                         )),
//                     Ink(
//                       width: 400,
//                       height: 75,
//                       color: Colors.white,
//                       child: GridView.count(
//                         primary: true,
//                         crossAxisCount: 6, //set the number of buttons in a row
//                         crossAxisSpacing:
//                             8, //set the spacing between the buttons
//                         childAspectRatio:
//                             1, //set the width-to-height ratio of the button,
//                         //>1 is a horizontal rectangle
//                         children:
//                             List.generate(isSelectedRooms.length, (index) {
//                           //using Inkwell widget to create a button
//                           return InkWell(
//                               //the default splashColor is grey
//                               onTap: () {
//                                 //set the toggle logic
//                                 setState(() {
//                                   for (int indexBtn = 0;
//                                       indexBtn < isSelectedRooms.length;
//                                       indexBtn++) {
//                                     if (indexBtn == index) {
//                                       isSelectedRooms[indexBtn] = true;
//                                     } else {
//                                       isSelectedRooms[indexBtn] = false;
//                                     }
//                                   }
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   //set the background color of the button when it is selected/ not selected
//                                   color: isSelectedRooms[index]
//                                       ? accentColorBlue
//                                       : Colors.white,
//                                   // here is where we set the rounded corner
//                                   borderRadius: BorderRadius.circular(8),
//                                   //don't forget to set the border,
//                                   //otherwise there will be no rounded corner
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     roomList[index],
//                                     textDirection: TextDirection.ltr,
//                                     style: TextStyle(
//                                         color: isSelectedRooms[index]
//                                             ? Colors.white
//                                             : accentColorBlue),
//                                     //set the color of the icon when it is selected/ not selected
//                                   ),
//                                 ),
//                               ));
//                         }),
//                       ),
//                     ),
//                     Text("المساحة",
//                         style: TextStyle(
//                           color: accentColorBlue,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         )),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     SfRangeSlider(
//                       min: 0.0,
//                       max: 1000.0,
//                       inactiveColor: primaryColor,
//                       activeColor: accentColorBrown,
//                       values: _areaSliderRange,
//                       tooltipTextFormatterCallback:
//                           (dynamic actualValue, String formattedText) {
//                         return actualValue.toStringAsFixed(0);
//                       },
//                       showTicks: false,
//                       showLabels: false,
//                       shouldAlwaysShowTooltip: true,
//                       minorTicksPerInterval: 0,
//                       onChanged: (SfRangeValues values) {
//                         setState(() {
//                           _areaSliderRange = values;
//                         });
//                       },
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(bottom: 25),
//                       width: double.infinity,
//                       height: 60,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           showLoader = true;
//                           await getAllUnits();
//                         },
//                         child: const Text(
//                           'بحث',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               const Color(0xffb78457)),
//                           shape: MaterialStateProperty.all(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.0))),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
