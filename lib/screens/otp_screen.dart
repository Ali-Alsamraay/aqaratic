import 'package:aqaratak/helper/endpoints.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:aqaratak/screens/registeration_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sms_autofill/sms_autofill.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../helper/networking.dart';

class OtpScreen extends StatefulWidget {
  final String? mobile;
  const OtpScreen({required this.mobile, Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool showloader = false;
  bool isResendOtpDisabled = true;
  CountDownController countDownController = CountDownController();
  TextEditingController pinTextField = TextEditingController();


  void initMethods() async {
    // SmsAutoFill().listenForCode;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: LoadingOverlay(
            isLoading: showloader,
            child: Material(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Text(
                        "التحقق من الدخول",
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "رمز التحقق المكون من 4 أرقام",
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                              color: Color(0xffb78457),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //     height: 85,
                      //     child: PinFieldAutoFill(
                      //       controller: pinTextField,
                      //       codeLength: 4,
                      //       decoration: BoxLooseDecoration(
                      //           textStyle: const TextStyle(
                      //               color: Colors.grey, fontSize: 20),
                      //           strokeColorBuilder: FixedColorBuilder(
                      //               Colors.grey.withOpacity(0.3)),
                      //           bgColorBuilder:
                      //               FixedColorBuilder(Colors.white)),
                      //       currentCode: '',
                      //       onCodeChanged: (code) async {
                      //         if (code?.length == 4) {
                      //           setState(() {
                      //             showloader = true;
                      //           });
                      //           await loginOtp(code!);

                      //           print('OTP Code : $code');
                      //         }
                      //       },
                      //     )),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'إعادة إرسال الكود',
                            style: const TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                            // ..onTap = () => isResendOtpDisabled
                            //     ? null
                            //     : registerDevice()),
                            ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      CircularCountDownTimer(
                        duration: 60,
                        initialDuration: 0,
                        controller: countDownController,
                        width: MediaQuery.of(context).size.width / 8,
                        height: MediaQuery.of(context).size.height / 8,
                        ringColor: const Color(0XFFDBDBDB),
                        ringGradient: null,
                        fillColor: const Color(0xff0c2757),
                        fillGradient: null,
                        backgroundColor: const Color(0XFFC4C6C6),
                        backgroundGradient: null,
                        strokeWidth: 20.0,
                        strokeCap: StrokeCap.round,
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffb78457),
                        ),
                        textFormat: CountdownTextFormat.S,
                        isReverse: false,
                        isReverseAnimation: false,
                        isTimerTextShown: true,
                        autoStart: true,
                        onStart: () {
                          print('Countdown Started');
                        },
                        onComplete: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  // Future loginOtp(String otp) async {
  //   Map<String, dynamic> requestBody = {"mobile": widget.mobile, "otp": otp};
  //   NetworkHelper login = NetworkHelper(
  //       endpoint: loginOtpEndpoint, params: requestBody, context: context);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var dataMap = await login.postRequest();
  //   if (dataMap != null) {
  //     _getLoginInfoModel = GetLoginInfoModel.fromJson(dataMap);
  //     String token = _getLoginInfoModel.tokens!.access!.token ?? '';
  //     await prefs.setString('token', token);
  //     if (_getLoginInfoModel.user!.regNumber == null ||
  //         _getLoginInfoModel.user!.regNumber == "")
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => RegisterationScreen(
  //                   userId: _getLoginInfoModel.user!.id ?? '')));
  //     else
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => MainScreen()));
  //     // print(_getRegisterInfo.user?.mobile);
  //   }
  //   setState(() {
  //     showloader = false;
  //   });
  // }
}
