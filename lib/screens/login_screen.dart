import 'dart:ffi';

import 'package:aqaratak/helper/Utils.dart';
import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/screens/Register_screen.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        print(cachedCredentials);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColorBrown,
        child: Icon(
          Icons.arrow_back,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Form(
        key: _formKey,
        child: WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: LoadingOverlay(
              isLoading: showLoader,
              child: Material(
                child: Container(
                  width: 100.0.w,
                  height: 100.0.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15.0.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "sign_in".tr,
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
                                            label: "phone_number".tr,
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
                                          label: "email".tr,
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
                            label: "password".tr,
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
                                'sign_in'.tr,
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
                                "registration".tr,
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
        Utils().showPopUp(context, "problem_happened".tr, responseMsg.toString());
      }
    } else {
      await Utils().showPopUp(context, "invalid_entries".tr, "verify_your_data".tr);
    }
  }
}
