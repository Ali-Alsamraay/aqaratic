import 'dart:ffi';
import 'dart:ui';

import 'package:aqaratak/helper/Utils.dart';
import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/screens/Register_screen.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../helper/constants.dart';
import '../models/FormValidator.dart';
import '../models/User.dart';
import '../widgets/Custom_TextField.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String screenName = "login-screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumberController = TextEditingController();

  final FocusNode? focusNode = FocusNode();

  final User _user = User();

  bool showLoader = true;
  bool usingPhoneNumber = true;

  final GlobalKey<FormState>? _formKey = new GlobalKey();
  final FormValidator formValidator = FormValidator();
  User? cachedCredentials;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        cachedCredentials =
            await Provider.of<AuthProvider>(context, listen: false)
                .getCachedUser();
        setState(() {
          showLoader = false;
        });
      } catch (e) {
        setState(() {
          showLoader = false;
        });
      }
    });
  }

  @override
  void dispose() {
    if (_formKey != null && _formKey!.currentState != null) {
      _formKey!.currentState!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColorBrown,
        child: Icon(
          Icons.arrow_back,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: GestureDetector(
        onTap: () {
          if (FocusManager.instance.primaryFocus!.hasFocus)
            FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Container(
          width: 100.0.w,
          height: 100.0.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: WillPopScope(
              onWillPop: () async => false,
              child: LoadingOverlay(
                isLoading: showLoader,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.0.w,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom + 10.0.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10.0.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "تسجيل الدخول",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cairo(
                                  textStyle: TextStyle(
                                color: Color(0xfffefeff),
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0.sp,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 10.0.h,
                          ),
                          // email
                          SizedBox(
                            width: 95.0.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      focusNode!.unfocus();
                                      setState(() {
                                        usingPhoneNumber = !usingPhoneNumber;
                                      });
                                    },
                                    child: SizedBox(
                                      height: 6.2.h,
                                      child: Card(
                                        child: Icon(
                                          usingPhoneNumber
                                              ? Icons.email
                                              : Icons.phone,
                                          color: accentColorBrown,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: usingPhoneNumber
                                      ? // phone
                                      Consumer<AuthProvider>(
                                          builder: (context, value, child) =>
                                              CustomTextField(
                                            focusNode: focusNode,
                                            textInputType: TextInputType.phone,
                                            onValidateFunc: (value) {
                                              return formValidator
                                                  .validatePhoneNumber(
                                                value!.trim(),
                                              );
                                            },
                                            onSaveFunc: (value) {
                                              _user.phone = value!.trim();
                                            },
                                            initValue: value.currentUser == null
                                                ? null
                                                : value.currentUser!.phone,
                                            label: "رقم الهاتف",
                                            hintTextColor: Colors.white,
                                            textStyle:
                                                TextStyle(color: Colors.white),
                                            errorBorderColor: Colors.white,
                                            icon: Icon(
                                              Icons.email,
                                              size: 21.0.sp,
                                              color: const Color(0xffb78457),
                                            ),
                                          ),
                                        )
                                      : CustomTextField(
                                          focusNode: focusNode,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          onValidateFunc: (value) {
                                            return formValidator
                                                .validateEmail(value!.trim());
                                          },
                                          onSaveFunc: (value) {
                                            _user.email = value!.trim();
                                          },
                                          label: "البريد الإلكتروني",
                                          hintTextColor: Colors.white,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                          errorBorderColor: Colors.white,
                                          icon: Icon(
                                            Icons.email,
                                            size: 21.0.sp,
                                            color: const Color(0xffb78457),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 5.0.h,
                          ),
                          // password
                          CustomTextField(
                            onValidateFunc: (value) {
                              return formValidator
                                  .validatePassword(value!.trim().toString());
                            },
                            onSaveFunc: (value) {
                              _user.password = value!.trim();
                            },
                            label: "الرقم السري",
                            hintTextColor: Colors.white,
                            errorBorderColor: Colors.white,
                            textStyle: TextStyle(color: Colors.white),
                            passwordField: true,
                            icon: Icon(
                              Icons.key,
                              size: 21.0.sp,
                              color: const Color(0xffb78457),
                            ),
                          ),

                          SizedBox(
                            height: 10.0.h,
                          ),
                          SizedBox(
                            width: 90.0.w,
                            height: 7.0.h,
                            child: ElevatedButton(
                              onPressed: _login,
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xffb78457)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7.0.h,
                            child: TextButton(
                              child: Text(
                                "تسجيل",
                                style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                  color: Color(0xfffefeff),
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0.sp,
                                )),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  RegisterScreen.screenName,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 7.0.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();

      if (usingPhoneNumber) {
        _user.email = _user.phone;
        _user.phone = null;
      }
      setState(() {
        showLoader = true;
      });

      final String? responseMsg =
          await Provider.of<AuthProvider>(context, listen: false).login(
        _user.toJson(),
      );
      setState(() {
        showLoader = false;
      });
      if (responseMsg == "logged_in") {
        Navigator.of(context).pushReplacementNamed(MainScreen.screenName);
      } else {
        Utils().showPopUp(context, "حدثت مشكلة ما", responseMsg.toString());
      }
    } else {
      await Utils().showPopUp(context, "إدخالات غير صالحة", "تأكد من بياناتك");
    }
  }
}
