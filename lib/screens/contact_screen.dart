import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RawMaterialButton(
              elevation: 0.0,
              onPressed: () => Navigator.of(context).pop(),
              fillColor: Colors.white,
              padding: const EdgeInsets.only(right: 10),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text("contact_us".tr,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: Color(0xffb78457),
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.45,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: double.infinity,
                    height: 130,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x1f8483a9),
                              offset: Offset(0, 10),
                              blurRadius: 88,
                              spreadRadius: 0)
                        ],
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/card_icon.svg',
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.fill,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.call,
                                  color: accentColorBrown,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("+966500264333",
                                    textDirection: TextDirection.ltr,
                                    style: const TextStyle(
                                      color: Color(0xff242b35),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: accentColorBrown,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("s.alshahrani@aqaratic.com",
                                    style: const TextStyle(
                                      color: Color(0xff242b35),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "communication".tr,
                      style: TextStyle(
                          color: Color(0xff2e2e2e),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Cairo",
                          fontStyle: FontStyle.normal,
                          fontSize: 19.0),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          filled: true,
                          hintText: 'name'.tr,
                          hintStyle: const TextStyle(
                              color: const Color(0xffb3bbcb), fontSize: 20),
                        ),
                      )),
                  Container(
                      width: double.infinity,
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          filled: true,
                          hintText: 'email'.tr,
                          hintStyle: const TextStyle(
                              color: Color(0xffb3bbcb), fontSize: 20),
                        ),
                      )),
                  Container(
                      width: double.infinity,
                      height: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          filled: true,
                          hintText: 'message'.tr,
                          hintStyle: const TextStyle(
                              color: const Color(0xffb3bbcb), fontSize: 20),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      },
                      child: Text(
                        'send'.tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffb78457)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
