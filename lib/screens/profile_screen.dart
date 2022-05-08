import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/screens/contact_screen.dart';
import 'package:aqaratak/screens/units_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'about_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          color: Color(0xffE9EAEE),
          child: SafeArea(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 20,
                //     ),
                //     SvgPicture.asset('assets/images/person_icon.svg',
                //         height: 50.0, width: 50.0),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Text(
                //       'سعيد السلطان',
                //       style: TextStyle(
                //         color: Color(0xff3e404c),
                //         fontSize: 18,
                //         fontWeight: FontWeight.w700,
                //         fontStyle: FontStyle.normal,
                //       ),
                //     ),
                //     Spacer(),
                //     Icon(
                //       Icons.edit,
                //       color: accentColorBrown,
                //     ),
                //     SizedBox(
                //       width: 40,
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 30,
                ),
                // Container(
                //   height: 350,
                //   width: double.infinity,
                //   color: Colors.white,
                //   child: Column(
                //     children: [
                //       Container(
                //         height: 100,
                //         child: Row(
                //           children: [
                //             SizedBox(
                //               width: 30,
                //             ),
                //             SvgPicture.asset('assets/images/requests_icon.svg',
                //                 color: accentColorBrown,
                //                 height: 35.0,
                //                 width: 35.0),
                //             SizedBox(
                //               width: 30,
                //             ),
                //             Text("طلباتي",
                //                 style: TextStyle(
                //                   color: Color(0xff0c143d),
                //                   fontSize: 22,
                //                   fontWeight: FontWeight.w400,
                //                   fontStyle: FontStyle.normal,
                //                 )),
                //             Spacer(),
                //             Icon(
                //               Icons.arrow_forward_ios,
                //               color: Colors.grey,
                //             ),
                //             SizedBox(
                //               width: 30,
                //             )
                //           ],
                //         ),
                //       ),
                //       Divider(),
                //       Container(
                //         height: 100,
                //         child: Row(
                //           children: [
                //             SizedBox(
                //               width: 30,
                //             ),
                //             SvgPicture.asset('assets/images/fav_icon.svg',
                //                 color: accentColorBrown,
                //                 height: 35.0,
                //                 width: 35.0),
                //             SizedBox(
                //               width: 30,
                //             ),
                //             Text("المفضلة",
                //                 style: TextStyle(
                //                   color: Color(0xff0c143d),
                //                   fontSize: 22,
                //                   fontWeight: FontWeight.w400,
                //                   fontStyle: FontStyle.normal,
                //                 )),
                //             Spacer(),
                //             Icon(
                //               Icons.arrow_forward_ios,
                //               color: Colors.grey,
                //             ),
                //             SizedBox(
                //               width: 30,
                //             )
                //           ],
                //         ),
                //       ),
                //       Divider(),
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) =>
                //                       const UnitesList(tabChosenIndex: 0)));
                //         },
                //         child: Container(
                //           height: 100,
                //           child: Row(
                //             children: [
                //               SizedBox(
                //                 width: 30,
                //               ),
                //               SvgPicture.asset('assets/images/ads_icon.svg',
                //                   color: accentColorBrown,
                //                   height: 35.0,
                //                   width: 35.0),
                //               SizedBox(
                //                 width: 30,
                //               ),
                //               Text("إعلاناتي",
                //                   style: TextStyle(
                //                     color: Color(0xff0c143d),
                //                     fontSize: 22,
                //                     fontWeight: FontWeight.w400,
                //                     fontStyle: FontStyle.normal,
                //                   )),
                //               Spacer(),
                //               Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: Colors.grey,
                //               ),
                //               SizedBox(
                //                 width: 30,
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContactScreen()));
                        },
                        child: Container(
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              SvgPicture.asset('assets/images/contact_icon.svg',
                                  color: accentColorBrown,
                                  height: 35.0,
                                  width: 35.0),
                              SizedBox(
                                width: 30,
                              ),
                              Text("اتصل بنا",
                                  style: TextStyle(
                                    color: Color(0xff0c143d),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              SvgPicture.asset('assets/images/about_icon.svg',
                                  color: accentColorBrown,
                                  height: 35.0,
                                  width: 35.0),
                              SizedBox(
                                width: 30,
                              ),
                              Text("من نحن",
                                  style: TextStyle(
                                    color: Color(0xff0c143d),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   height: 100,
                //   width: double.infinity,
                //   color: Colors.white,
                //   child: Column(
                //     children: [
                //       Container(
                //         height: 100,
                //         child: Row(
                //           children: [
                //             SizedBox(
                //               width: 30,
                //             ),
                //             SvgPicture.asset('assets/images/logout_icon.svg',
                //                 color: accentColorBrown,
                //                 height: 27.0,
                //                 width: 27.0),
                //             SizedBox(
                //               width: 30,
                //             ),
                //             Text("تسجيل الخروج",
                //                 style: TextStyle(
                //                   color: Color(0xff0c143d),
                //                   fontSize: 22,
                //                   fontWeight: FontWeight.w400,
                //                   fontStyle: FontStyle.normal,
                //                 )),
                //             Spacer(),
                //             Icon(
                //               Icons.arrow_forward_ios,
                //               color: Colors.grey,
                //             ),
                //             SizedBox(
                //               width: 30,
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          )),
    );
  }
}
