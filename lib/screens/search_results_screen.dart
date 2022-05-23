// import 'package:aqaratak/models/get_all_units_info/get_all_units_info_model.dart';
// import 'package:aqaratak/screens/unit_details_screen.dart';
// import 'package:flutter/material.dart';

// import '../helper/constants.dart';

// class SearchResultsScreen extends StatelessWidget {
//   final List<Results> searchResultModel;
//   const SearchResultsScreen({required this.searchResultModel, Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: RawMaterialButton(
//               elevation: 0.0,
//               onPressed: () => Navigator.of(context).pop(),
//               fillColor: Colors.white,
//               padding: const EdgeInsets.only(right: 10),
//               shape: const CircleBorder(),
//               child: const Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//         ),
//         body: ListView.builder(
//           itemCount: searchResultModel.length,
//           itemBuilder: (BuildContext context, int index) => GestureDetector(
//             onTap: () {
//               // Navigator.push(
//               //     context,
//               //     MaterialPageRoute(
//               //         builder: (context) =>
//               //             UnitDetails(unitInfo: searchResultModel[index])));
//             },
//             child: Container(
//               height: 150,
//               width: double.infinity,
//               margin: const EdgeInsets.all(10),
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(20)),
//                   color: Colors.grey[100]),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(20)),
//                       child: searchResultModel[index].images!.isNotEmpty
//                           ? Image.network(
//                               baseUrl +
//                                   searchResultModel[index].images![0],
//                               width: 170,
//                               height: 170,
//                               fit: BoxFit.fill,
//                             )
//                           : Image.asset(
//                               imagePath + 'background.png',
//                               width: 170,
//                               height: 170,
//                               fit: BoxFit.fill,
//                             )),
//                   Container(
//                     width: 180,
//                     margin: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(5.0),
//                           child: Text(searchResultModel[index].title ?? ''),
//                         ),
//                         Row(
//                           children: [
//                             const Icon(Icons.pin_drop_rounded),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               searchResultModel[index].address ?? '',
//                               style: TextStyle(color: Colors.black26),
//                             )
//                           ],
//                         ),
//                         // Row(
//                         //   children: [
//                         //     SvgPicture.asset(
//                         //         'assets/images/area_icon.svg',
//                         //         height: 20.0,
//                         //         width: 20.0,
//                         //         semanticsLabel: ''),
//                         //     const SizedBox(
//                         //       width: 2,
//                         //     ),
//                         //     const Text('850'),
//                         //     const SizedBox(
//                         //       width: 2,
//                         //     ),
//                         //     SvgPicture.asset(
//                         //         'assets/images/bath_icon.svg',
//                         //         height: 20.0,
//                         //         width: 20.0,
//                         //         semanticsLabel: ''),
//                         //     const SizedBox(
//                         //       width: 2,
//                         //     ),
//                         //     const Text('8'),
//                         //     const SizedBox(
//                         //       width: 2,
//                         //     ),
//                         //     SvgPicture.asset(
//                         //         'assets/images/rooms_icon.svg',
//                         //         height: 20.0,
//                         //         width: 20.0,
//                         //         semanticsLabel: ''),
//                         //     const SizedBox(
//                         //       width: 2,
//                         //     ),
//                         //     const Text('4'),
//                         //   ],
//                         // ),
//                         Padding(
//                           padding: EdgeInsets.all(5.0),
//                           child: Text(
//                             '${searchResultModel[index].price ?? 0}',
//                             style: TextStyle(color: accentColorBrown),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   // const Padding(
//                   //   padding: EdgeInsets.only(top: 10.0),
//                   //   child: Icon(Icons.favorite_border),
//                   // )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
