import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/get_lookups_info/get_lookups_info_model.dart';
import 'package:aqaratak/screens/unit_details_screen.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helper/endpoints.dart';
import '../helper/networking.dart';
import '../models/get_all_units_info/get_all_units_info_model.dart';

class UnitsList extends StatefulWidget {
  final int tabChosenIndex;

  const UnitsList({Key? key, required this.tabChosenIndex}) : super(key: key);

  @override
  _UnitsListState createState() => _UnitsListState();
}

class _UnitsListState extends State<UnitsList> {
  List<GetLookupsInfoModel> lookupsList = [];
  GetAllUnitsInfoModel _getlandsInfo = GetAllUnitsInfoModel();
  GetAllUnitsInfoModel _getBuildingsInfo = GetAllUnitsInfoModel();
  GetAllUnitsInfoModel _getVillasInfo = GetAllUnitsInfoModel();
  List<String> categories = ['أراضي', 'عماير', 'فيلا'];

  Future<bool> futureApiCall() async {
    Map<String, dynamic> lookupsParams = {'lookuptype': 'unit_type'};
    NetworkHelper userTypes = NetworkHelper(
        endpoint: lookupsEndpoint, params: lookupsParams, context: context);
    List lookupDataMap = await userTypes.getRequest();
    if (lookupDataMap != null) {
      for (int i = 0; i < lookupDataMap.length; i++) {
        lookupsList.add(GetLookupsInfoModel.fromJson(lookupDataMap[i]));
      }
      print(lookupsList);
    } else {
      return false;
    }
    await getLands();
    await getBuildings();
    await getVillas();

    return true;
  }

  Future getLands() async {
    Map<String, dynamic> categoriesUnitsInfoParams = {
      'unit_type': lookupsList[lookupsList
              .indexWhere((element) => element.lookupname == 'أراضي')]
          .id
    };
    NetworkHelper getAllUnits = NetworkHelper(
        endpoint: aqarUnitsEndpoint,
        params: categoriesUnitsInfoParams,
        context: context);
    var categoriesUnitsInfoDataMap = await getAllUnits.getRequest();

    if (categoriesUnitsInfoDataMap != null) {
      _getlandsInfo = GetAllUnitsInfoModel.fromJson(categoriesUnitsInfoDataMap);
    }
  }

  Future getBuildings() async {
    Map<String, dynamic> categoriesUnitsInfoParams = {
      'unit_type': lookupsList[lookupsList
              .indexWhere((element) => element.lookupname == 'عماير')]
          .id
    };
    NetworkHelper getAllUnits = NetworkHelper(
        endpoint: aqarUnitsEndpoint,
        params: categoriesUnitsInfoParams,
        context: context);
    var categoriesUnitsInfoDataMap = await getAllUnits.getRequest();

    if (categoriesUnitsInfoDataMap != null) {
      _getBuildingsInfo =
          GetAllUnitsInfoModel.fromJson(categoriesUnitsInfoDataMap);
    }
  }

  Future getVillas() async {
    Map<String, dynamic> categoriesUnitsInfoParams = {
      'unit_type': lookupsList[
              lookupsList.indexWhere((element) => element.lookupname == 'فيلا')]
          .id
    };
    NetworkHelper getAllUnits = NetworkHelper(
        endpoint: aqarUnitsEndpoint,
        params: categoriesUnitsInfoParams,
        context: context);
    var categoriesUnitsInfoDataMap = await getAllUnits.getRequest();

    if (categoriesUnitsInfoDataMap != null) {
      _getVillasInfo =
          GetAllUnitsInfoModel.fromJson(categoriesUnitsInfoDataMap);
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: futureApiCall(),
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                    leading: BackButton(color: Colors.black),
                    backgroundColor: Colors.white38,
                    elevation: 0.0),
                body: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(imagePath + 'white_background.png'),
                    fit: BoxFit.cover,
                  )),
                  child: SafeArea(
                    child: DefaultTabController(
                      length: 3,
                      initialIndex: widget.tabChosenIndex,
                      child: Column(
                        children: <Widget>[
                          ButtonsTabBar(
                            backgroundColor: const Color(0xff0c2757),
                            unselectedBorderColor: Colors.grey,
                            unselectedBackgroundColor: Colors.white,
                            unselectedLabelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            borderWidth: 2,
                            height: 56,
                            labelSpacing: 15,
                            tabs: [
                              Tab(
                                icon: SvgPicture.asset(
                                    'assets/images/land_icon.svg',
                                    height: 30.0,
                                    width: 30.0),
                                text: 'أراضي',
                              ),
                              Tab(
                                icon: SvgPicture.asset(
                                    'assets/images/building_icon.svg',
                                    height: 30.0,
                                    width: 30.0),
                                text: 'عمائر',
                              ),
                              Tab(
                                icon: SvgPicture.asset(
                                    'assets/images/villa_icon.svg',
                                    height: 30.0,
                                    width: 30.0),
                                text: 'فيلا',
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: TabBarView(
                              children: <Widget>[
                                ListView.builder(
                                  itemCount: _getlandsInfo.results?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => UnitDetails(
                                      //             unitInfo: _getlandsInfo
                                      //                 .results![index])));
                                    },
                                    child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.grey[100]),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              child: _getlandsInfo
                                                      .results![index]
                                                      .images!
                                                      .isNotEmpty
                                                  ? Image.network(
                                                      imageBaseUrl +
                                                          _getlandsInfo
                                                              .results![index]
                                                              .images![0],
                                                      width: 170,
                                                      height: 170,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.asset(
                                                      imagePath +
                                                          'background.png',
                                                      width: 170,
                                                      height: 170,
                                                      fit: BoxFit.fill,
                                                    )),
                                          Container(
                                            width: 180,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(_getlandsInfo
                                                          .results![index]
                                                          .title ??
                                                      ''),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.pin_drop_rounded),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      _getlandsInfo
                                                              .results![index]
                                                              .address ??
                                                          '',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black26),
                                                    )
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     SvgPicture.asset(
                                                //         'assets/images/area_icon.svg',
                                                //         height: 20.0,
                                                //         width: 20.0,
                                                //         semanticsLabel: ''),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     const Text('850'),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     SvgPicture.asset(
                                                //         'assets/images/bath_icon.svg',
                                                //         height: 20.0,
                                                //         width: 20.0,
                                                //         semanticsLabel: ''),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     const Text('8'),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     SvgPicture.asset(
                                                //         'assets/images/rooms_icon.svg',
                                                //         height: 20.0,
                                                //         width: 20.0,
                                                //         semanticsLabel: ''),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     const Text('4'),
                                                //   ],
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '${_getlandsInfo.results![index].price ?? 0} ريال ',
                                                    style: TextStyle(
                                                        color:
                                                            accentColorBrown),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // const Padding(
                                          //   padding: EdgeInsets.only(top: 10.0),
                                          //   child: Icon(Icons.favorite_border),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  itemCount: _getBuildingsInfo.results!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => UnitDetails(
                                      //             unitInfo: _getBuildingsInfo
                                      //                 .results![index])));
                                    },
                                    child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.grey[100]),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              child: _getBuildingsInfo
                                                      .results![index]
                                                      .images!
                                                      .isNotEmpty
                                                  ? Image.network(
                                                      imageBaseUrl +
                                                          _getBuildingsInfo
                                                              .results![index]
                                                              .images![0],
                                                      width: 170,
                                                      height: 170,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.asset(
                                                      imagePath +
                                                          'background.png',
                                                      width: 170,
                                                      height: 170,
                                                      fit: BoxFit.fill,
                                                    )),
                                          Container(
                                            width: 180,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(_getBuildingsInfo
                                                          .results![index]
                                                          .title ??
                                                      ''),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.pin_drop_rounded),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      _getBuildingsInfo
                                                              .results![index]
                                                              .address ??
                                                          '',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black26),
                                                    )
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     SvgPicture.asset(
                                                //         'assets/images/area_icon.svg',
                                                //         height: 20.0,
                                                //         width: 20.0,
                                                //         semanticsLabel: ''),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     const Text('850'),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     SvgPicture.asset(
                                                //         'assets/images/bath_icon.svg',
                                                //         height: 20.0,
                                                //         width: 20.0,
                                                //         semanticsLabel: ''),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     const Text('8'),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     SvgPicture.asset(
                                                //         'assets/images/rooms_icon.svg',
                                                //         height: 20.0,
                                                //         width: 20.0,
                                                //         semanticsLabel: ''),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     const Text('4'),
                                                //   ],
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '${_getBuildingsInfo.results![index].price ?? 0} ريال  ',
                                                    style: TextStyle(
                                                        color:
                                                            accentColorBrown),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // const Padding(
                                          //   padding: EdgeInsets.only(top: 10.0),
                                          //   child: Icon(Icons.favorite_border),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  itemCount: _getVillasInfo.results!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => UnitDetails(
                                      //             unitInfo: _getVillasInfo
                                      //                 .results![index])));
                                    },
                                    child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.grey[100]),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              child: _getVillasInfo
                                                      .results![index]
                                                      .images!
                                                      .isNotEmpty
                                                  ? Image.network(
                                                      imageBaseUrl +
                                                          _getVillasInfo
                                                              .results![index]
                                                              .images![0],
                                                      width: 170,
                                                      height: 170,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.asset(
                                                      imagePath +
                                                          'background.png',
                                                      width: 170,
                                                      height: 170,
                                                      fit: BoxFit.fill,
                                                    )),
                                          Container(
                                            width: 180,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(_getVillasInfo
                                                          .results![index]
                                                          .title ??
                                                      ''),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.pin_drop_rounded),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      _getVillasInfo
                                                              .results![index]
                                                              .address ??
                                                          '',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black26),
                                                    )
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     SvgPicture.asset(
                                                //         'assets/images/area_icon.svg',
                                                //         height: 20.0,
                                                //         width: 20.0,
                                                //         semanticsLabel: ''),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     const Text('850'),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     SvgPicture.asset(
                                                //         'assets/images/bath_icon.svg',
                                                //         height: 20.0,
                                                //         width: 20.0,
                                                //         semanticsLabel: ''),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     const Text('8'),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     SvgPicture.asset(
                                                //         'assets/images/rooms_icon.svg',
                                                //         height: 20.0,
                                                //         width: 20.0,
                                                //         semanticsLabel: ''),
                                                //     const SizedBox(
                                                //       width: 2,
                                                //     ),
                                                //     const Text('4'),
                                                //   ],
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '${_getVillasInfo.results![index].price ?? 0} ريال  ',
                                                    style: TextStyle(
                                                        color:
                                                            accentColorBrown),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // const Padding(
                                          //   padding: EdgeInsets.only(top: 10.0),
                                          //   child: Icon(Icons.favorite_border),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            // empty data case
            return Container();
          }
        } else {
          return AlertDialog(
            content: Text('State: ${snapshot.connectionState}'),
          );
        }
      });
}
