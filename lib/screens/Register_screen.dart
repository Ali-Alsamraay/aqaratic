import 'dart:convert';
import 'dart:typed_data';

import 'package:aqaratak/helper/Utils.dart';
import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/screens/login_screen.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../helper/constants.dart';
import '../models/FormValidator.dart';
import '../models/User.dart';
import '../widgets/Custom_TextField.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static const String screenName = "register-screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController mobileNumberController = TextEditingController();

  final User _user = User();

  bool showLoader = false;

  final GlobalKey<FormState>? _formKey = new GlobalKey();
  final FormValidator formValidator = FormValidator();

  Uint8List? imgBytes;

  @override
  void dispose() {
    if (_formKey != null && _formKey!.currentState != null) {
      _formKey!.currentState!.dispose();
    }
    super.dispose();
  }

  final Utils utils = Utils();
  String? loadedImageBase64;
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showLoader
          ? null
          : FloatingActionButton(
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
                            height: 13.0.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "register__new_account".tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  color: Color(0xfffefeff),
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.0.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  child: image != null
                                      ? Container(
                                          width: 25.0.w,
                                          height: 25.0.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: MemoryImage(image!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () async {
                                            if (await Permission
                                                .storage.isDenied) {
                                              await utils.showPopUp(
                                                context,
                                                "permission_images".tr,
                                                "permission_images_error".tr,
                                              );
                                              final PermissionStatus
                                                  permissionStatus =
                                                  await Permission.storage
                                                      .request();
                                              if (permissionStatus.isDenied ||
                                                  !permissionStatus.isGranted)
                                                return;
                                            }
                                            loadedImageBase64 = await utils
                                                .showPopUpAndPickImage(
                                              context,
                                              "photo_selection".tr,
                                            );
                                            if (loadedImageBase64 == null ||
                                                loadedImageBase64 == "") return;
                                            setState(() {
                                              image = base64Decode(
                                                  loadedImageBase64!);
                                            });
                                          },
                                          child: Container(
                                            width: 25.0.w,
                                            padding: EdgeInsets.all(20.0.sp),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: backgroundColor,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/person_icon.svg',
                                              color: accentColorBlue,
                                              height: 10.0.w,
                                              width: 10.0.w,
                                            ),
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 1.0.h,
                                ),
                                Text(
                                  "profile_picture".tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                      color: Color(0xfffefeff),
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4.0.h,
                          ),
                          // user name
                          CustomTextField(
                            textInputType: TextInputType.text,
                            onValidateFunc: (value) {
                              return formValidator
                                  .validateTextField(value!.trim());
                            },
                            onSaveFunc: (value) {
                              _user.name = value!.trim();
                            },
                            label: "username".tr,
                            hintTextColor: Colors.white,
                            textStyle: TextStyle(color: Colors.white),
                            errorBorderColor: Colors.white,
                          ),
                          SizedBox(
                            height: 4.0.h,
                          ),
                          // email
                          CustomTextField(
                            textInputType: TextInputType.emailAddress,
                            onValidateFunc: (value) {
                              return formValidator.validateEmail(value!.trim());
                            },
                            onSaveFunc: (value) {
                              _user.email = value!.trim();
                            },
                            label: "email".tr,
                            hintTextColor: Colors.white,
                            textStyle: TextStyle(color: Colors.white),
                            errorBorderColor: Colors.white,
                            icon: Icon(
                              Icons.email,
                              size: 21.0.sp,
                              color: const Color(0xffb78457),
                            ),
                          ),
                          SizedBox(
                            height: 4.0.h,
                          ),

                          // password
                          CustomTextField(
                            textInputType: TextInputType.visiblePassword,
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
                            height: 4.0.h,
                          ),

                          // phone
                          CustomTextField(
                            textInputType: TextInputType.phone,
                            onValidateFunc: (value) {
                              return formValidator
                                  .validatePhoneNumber(value!.trim());
                            },
                            onSaveFunc: (value) {
                              _user.phone = value!.trim();
                            },
                            label: "phone_number".tr,
                            hintTextColor: Colors.white,
                            textStyle: TextStyle(color: Colors.white),
                            errorBorderColor: Colors.white,
                            icon: Icon(
                              Icons.email,
                              size: 21.0.sp,
                              color: const Color(0xffb78457),
                            ),
                          ),
                          SizedBox(
                            height: 7.0.h,
                          ),

                          SizedBox(
                            width: 90.0.w,
                            height: 7.0.h,
                            child: ElevatedButton(
                              onPressed: _register,
                              child: Text(
                                'registration'.tr,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 3.0.h,
                                ),
                                Text(
                                  "already_have_an_account".tr,
                                  style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                    color: Color(0xfffefeff),
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.0.sp,
                                  )),
                                ),
                                TextButton(
                                  child: Text(
                                    'sign_in'.tr,
                                    style: GoogleFonts.cairo(
                                        textStyle: TextStyle(
                                      color: Color(0xfffefeff),
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0.sp,
                                    )),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(LoginScreen.screenName);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.0.h,
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

  _register() async {
    if (_formKey!.currentState!.validate()) {
      if (loadedImageBase64 == null) {
        await utils.showPopUp(
            context, "profile_picture_is_required".tr, "verify_your_data".tr);
        return;
      }

      _formKey!.currentState!.save();
      _user.image = {
        "ext": utils.getBase64FileExtension(loadedImageBase64!),
        "base64": loadedImageBase64,
      };

      setState(() {
        showLoader = true;
      });

      final String? responseMsg =
          await Provider.of<AuthProvider>(context, listen: false).register(
        _user.toJson(),
      );
      setState(() {
        showLoader = false;
      });
      if (responseMsg == "registered") {
        Navigator.of(context).pushReplacementNamed(MainScreen.screenName);
      } else if (Provider.of<AuthProvider>(context, listen: false)
          .registerResponseErrorMsgs!
          .isNotEmpty) {
        Utils().showPopUpWithMultiLinesError(
          context,
          responseMsg.toString(),
          Provider.of<AuthProvider>(context, listen: false)
              .registerResponseErrorMsgs,
        );
      } else {
        Utils()
            .showPopUp(context, "problem_happened".tr, responseMsg.toString());
      }
    } else {
      await Utils()
          .showPopUp(context, "invalid_entries".tr, "verify_your_data".tr);
    }
  }
}
