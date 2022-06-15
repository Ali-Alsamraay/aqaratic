import 'dart:convert';
import 'dart:typed_data';
import 'package:aqaratak/helper/Utils.dart';
import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/providers/main_provider.dart';
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
import '../widgets/general_drop_down.dart';

class UpdateUserProfileScreen extends StatefulWidget {
  UpdateUserProfileScreen({Key? key}) : super(key: key);
  static const String screenName = "update-user-profile-screen";

  @override
  State<UpdateUserProfileScreen> createState() =>
      _UpdateUserProfileScreenState();
}

class _UpdateUserProfileScreenState extends State<UpdateUserProfileScreen> {
  TextEditingController mobileNumberController = TextEditingController();

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

  bool isThereError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await Provider.of<AuthProvider>(
          context,
          listen: false,
        ).getCachedUser();
        await Provider.of<MainProvider>(
          context,
          listen: false,
        ).get_main_properties();
        setState(() {
          showLoader = false;
          isThereError = false;
        });
      } catch (e) {
        setState(() {
          showLoader = false;
          isThereError = true;
        });
      }
    });
  }

  final User toBeUploadedUser = User();

  final Utils utils = Utils();
  String? loadedImageBase64;
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    final User? _user = Provider.of<AuthProvider>(
      context,
    ).currentUser;
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
                              "edit_data".tr,
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
                                              padding: _user!.image == null ||
                                                      _user.image == ""
                                                  ? EdgeInsets.all(20.0.sp)
                                                  : EdgeInsets.zero,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: backgroundColor,
                                              ),
                                              child: _user.image == null ||
                                                      _user.image == ""
                                                  ? SvgPicture.asset(
                                                      'assets/images/person_icon.svg',
                                                      color: accentColorBlue,
                                                      height: 10.0.w,
                                                      width: 10.0.w,
                                                    )
                                                  : Container(
                                                      width: 25.0.w,
                                                      height: 25.0.w,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              _user.image!),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )),
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
                            initValue: _user!.name == null ? "" : _user.name,
                            textInputType: TextInputType.text,
                            onValidateFunc: (value) {
                              return null;
                            },
                            onSaveFunc: (value) {
                              toBeUploadedUser.name = value!.trim();
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
                            initValue: _user.email == null ? "" : _user.email,
                            textInputType: TextInputType.emailAddress,
                            onValidateFunc: (value) {
                              return null;
                            },
                            onSaveFunc: (value) {
                              toBeUploadedUser.email = value!.trim();
                            },
                            label: _user.email == null || _user.email == ""
                                ? "email".tr
                                : _user.email,
                            disable: true,
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

                          // authorization_number
                          CustomTextField(
                            initValue: _user.authorization_number == null
                                ? ""
                                : _user.authorization_number,
                            textInputType: TextInputType.text,
                            onValidateFunc: (value) {
                              return null;
                            },
                            onSaveFunc: (value) {
                              toBeUploadedUser.authorization_number =
                                  value!.trim();
                            },
                            label: _user.authorization_number == null ||
                                    _user.authorization_number == ""
                                ? "license_number".tr
                                : _user.authorization_number,
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

                          // general_authority_no
                          CustomTextField(
                            initValue: _user.general_authority_no == null
                                ? ""
                                : _user.general_authority_no,
                            textInputType: TextInputType.text,
                            onValidateFunc: (value) {
                              return null;
                            },
                            onSaveFunc: (value) {
                              toBeUploadedUser.general_authority_no =
                                  value!.trim();
                            },
                            label: _user.general_authority_no == null ||
                                    _user.general_authority_no == ""
                                ? "general_authorization_number".tr
                                : _user.general_authority_no,
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

                          // commercial_register
                          CustomTextField(
                            initValue: _user.commercial_register == null
                                ? ""
                                : _user.commercial_register,
                            textInputType: TextInputType.text,
                            onValidateFunc: (value) {
                              return null;
                            },
                            onSaveFunc: (value) {
                              toBeUploadedUser.commercial_register =
                                  value!.trim();
                            },
                            label: _user.commercial_register == null ||
                                    _user.commercial_register == ""
                                ? "commercial_Register".tr
                                : _user.commercial_register,
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

                          // classification_number
                          CustomTextField(
                            initValue: _user.classification_number == null
                                ? ""
                                : _user.classification_number,
                            textInputType: TextInputType.text,
                            onValidateFunc: (value) {
                              return null;
                            },
                            onSaveFunc: (value) {
                              toBeUploadedUser.classification_number =
                                  value!.trim();
                            },
                            label: _user.classification_number == null ||
                                    _user.classification_number == ""
                                ? "classification_number".tr
                                : _user.classification_number,
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

                          // phone
                          CustomTextField(
                            initValue: _user.phone == null ? "" : _user.phone,
                            textInputType: TextInputType.phone,
                            onValidateFunc: (value) {
                              return null;
                            },
                            onSaveFunc: (value) {
                              toBeUploadedUser.phone = value!.trim();
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
                            height: 4.0.h,
                          ),

                          // registration_type
                          GeneralDropDownMenu(
                            title: "registration_type".tr,
                            options: Provider.of<MainProvider>(
                              context,
                              listen: false,
                            ).main_properties['registrations_type'],
                            onSelected: (value) {
                              toBeUploadedUser.registration_type = value['id'];
                            },
                          ),
                          SizedBox(
                            height: 4.0.h,
                          ),

                          SizedBox(
                            width: 90.0.w,
                            height: 7.0.h,
                            child: ElevatedButton(
                              onPressed: _register,
                              child: Text(
                                'edit'.tr,
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
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final bool? isLoggedIn = await authProvider.isCurrentUserLoggedIn();
    if (!isLoggedIn!) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
      return;
    }
    if (_formKey!.currentState!.validate()) {
      if (loadedImageBase64 != null) {
        toBeUploadedUser.image = {
          "ext": utils.getBase64FileExtension(loadedImageBase64!),
          "base64": loadedImageBase64,
        };
      }
      _formKey!.currentState!.save();

      setState(() {
        showLoader = true;
      });

      final String? responseMsg =
          await Provider.of<AuthProvider>(context, listen: false).updateUser(
        toBeUploadedUser.toJson(),
      );
      setState(() {
        showLoader = false;
      });
      if (responseMsg == "updated") {
        Navigator.of(context).pushReplacementNamed(MainScreen.screenName);
      } else if (Provider.of<AuthProvider>(context, listen: false)
          .updateResponseErrorMsgs!
          .isNotEmpty) {
        Utils().showPopUpWithMultiLinesError(
          context,
          responseMsg.toString(),
          Provider.of<AuthProvider>(context, listen: false)
              .updateResponseErrorMsgs,
        );
      } else {
        Utils().showPopUp(context, "problem_happened".tr, responseMsg.toString());
      }
    } else {
      await Utils().showPopUp(context, "invalid_entries".tr, "verify_your_data".tr);
    }
  }
}
