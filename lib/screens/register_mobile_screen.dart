import 'package:aqaratak/helper/endpoints.dart';
import 'package:aqaratak/models/get_register_info/get_register_info_model.dart';
import 'package:aqaratak/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../helper/networking.dart';

class RegisterMobileScreen extends StatefulWidget {
  const RegisterMobileScreen({Key? key}) : super(key: key);

  @override
  _RegisterMobileScreenState createState() => _RegisterMobileScreenState();
}

class _RegisterMobileScreenState extends State<RegisterMobileScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  GetRegisterInfo _getRegisterInfo = GetRegisterInfo();
  bool showLoader = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: LoadingOverlay(
              isLoading: showLoader,
              child: Material(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Text(
                        "أضف رقم هاتفك",
                        style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                                color: Color(0xfffefeff),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("فضلا أدخل رقم الهاتف",
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                                color: Color(0xffb78457),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          width: double.infinity,
                          height: 64,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    color: Color(0xfff5f5f4)),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/saudi_flag_icon.png',
                                          fit: BoxFit.contain,
                                          width: 35,
                                          height: 35,
                                        )),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("+966",
                                        style: GoogleFonts.cairo(
                                          textStyle: const TextStyle(
                                              color: Color(0xff6e7faa),
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                  child: TextFormField(
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'الرجاء إدخال رقم الجوال';
                                  } else if (text.length < 9) {
                                    return 'الرجاء إدخال 9 أرقام للجوال ';
                                  }
                                  return null;
                                },
                                controller: mobileNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                showLoader = true;
                              });
                              await registerMobile(mobileNumberController.text);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const OtpScreen()));
                            }
                          },
                          child: const Text(
                            'التالي',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffb78457)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future registerMobile(String mobile) async {
    Map<String, dynamic> requestBody = {
      'mobile': mobile,
    };
    NetworkHelper registerMobile = NetworkHelper(
        endpoint: registerMobileEndpoint,
        params: requestBody,
        context: context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataMap = await registerMobile.postRequest();
    if (dataMap != null) {
      _getRegisterInfo = GetRegisterInfo.fromJson(dataMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OtpScreen(mobile: mobileNumberController.text)));
    }
    setState(() {
      showLoader = false;
    });
  }
}
