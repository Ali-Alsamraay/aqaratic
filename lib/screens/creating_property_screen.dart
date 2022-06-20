import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:aqaratak/providers/State_Manager_Provider.dart';
import 'package:aqaratak/widgets/CheckBoxFields.dart';
import 'package:aqaratak/widgets/SEO_Fields.dart';
import 'package:aqaratak/widgets/Title_Builder.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../helper/Utils.dart';
import '../helper/constants.dart';
import 'package:sizer/sizer.dart';
import '../models/FormValidator.dart';
import '../widgets/Favorite_settings_builder.dart';
import '../widgets/Image_PDF_Video_Fields.dart';
import '../widgets/Main_Info_Fields.dart';
import '../widgets/Nearest_locations_Fields.dart';
import '../widgets/Others_Info_Fields.dart';
import '../widgets/google_map_details_Fields.dart';
import 'main_screen.dart';

class CreatingPropertyScreen extends StatefulWidget {
  static const String screenName = "Creating-Property-Screen";
  CreatingPropertyScreen({Key? key}) : super(key: key);

  @override
  State<CreatingPropertyScreen> createState() => _CreatingPropertyScreenState();
}

class _CreatingPropertyScreenState extends State<CreatingPropertyScreen> {
  final GlobalKey<FormState>? _key = new GlobalKey();

  final FormValidator formValidator = FormValidator();

  bool? loading = true;
  bool? isThereError = false;

  @override
  void dispose() {
    if (_key != null && _key!.currentState != null) {
      _key!.currentState!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await Provider.of<PropertiesProvider>(
          context,
          listen: false,
        ).get_Property_Form(context);
        setState(() {
          loading = false;
          isThereError = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
          isThereError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(
      context,
      listen: false,
    );
    return Container(
      height: 100.0.h,
      width: 100.0.w,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        floatingActionButton: loading!
            ? null
            : FloatingActionButton(
                backgroundColor: accentColorBlue,
                child: Icon(
                  Icons.arrow_back,
                ),
                onPressed: ()  {
                  Navigator.pop(context);

                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor.withOpacity(0.2),
        body: GestureDetector(
          onTap: () {
            if (FocusManager.instance.primaryFocus!.hasFocus)
              FocusManager.instance.primaryFocus!.unfocus();
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: LoadingOverlay(
              isLoading: loading!,
              child: Container(
                width: 100.0.w,
                height: 100.0.h,
                child: isThereError!
                    ? Center(
                        child: TitleBuilder(
                          title: "حدث خطأ غير متوقع",
                        ),
                      )
                    : Provider.of<PropertiesProvider>(context)
                                .formInitErrorMsg !=
                            null
                        ? Center(
                            child: TitleBuilder(
                              title: Provider.of<PropertiesProvider>(context)
                                  .formInitErrorMsg
                                  .toString(),
                            ),
                          )
                        : Form(
                            key: _key!,
                            child: SingleChildScrollView(
                              child: loading!
                                  ? Container()
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: 13.0.h,
                                        ),
                                        TitleBuilder(
                                          title: propertiesProvider
                                              .get_Label_Text_By_Lang_key(
                                            "basic_info",
                                          )!,
                                        ),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        formCard(
                                          MainInfoFields(),
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        TitleBuilder(
                                          title: propertiesProvider
                                              .get_Label_Text_By_Lang_key(
                                            "others_info",
                                          )!,
                                        ),
                                        formCard(
                                          OthersInfoFields(),
                                        ),
                                        SizedBox(
                                          height: 4.0.h,
                                        ),
                                        TitleBuilder(
                                          title: propertiesProvider
                                              .get_Label_Text_By_Lang_key(
                                            "img_pdf_video",
                                          )!,
                                        ),
                                        formCard(
                                          ImagePdfVideoFields(),
                                        ),
                                        SizedBox(
                                          height: 4.0.h,
                                        ),
                                        TitleBuilder(
                                          title: propertiesProvider
                                              .get_Label_Text_By_Lang_key(
                                            "aminities",
                                          )!,
                                        ),
                                        formCard(
                                          CheckBoxFields(),
                                        ),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        TitleBuilder(
                                          title: propertiesProvider
                                              .get_Label_Text_By_Lang_key(
                                            "nearest_loc",
                                          )!,
                                        ),
                                        formCard(
                                          NearestLocationsFields(),
                                        ),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        TitleBuilder(
                                          title: propertiesProvider
                                              .get_Label_Text_By_Lang_key(
                                            "detail_google_map",
                                          )!,
                                        ),
                                        formCard(
                                          GoogleMapsDetailsFields(),
                                        ),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        TitleBuilder(
                                          title: "SEO",
                                        ),
                                        formCard(
                                          SEOFields(),
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15.0.sp,
                                            ),
                                          ),
                                          onPressed: loading! ? null : _submit,
                                          padding: EdgeInsets.all(
                                            7.0.sp,
                                          ),
                                          color: accentColorBlue,
                                          child: Text(
                                            'إضافة',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0.h,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                      ],
                                    ),
                            )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formCard(Widget? fields) {
    return Container(
      width: 90.0.w,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.sp),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.0.w,
            ),
            child: Center(child: fields!),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    // if (_key!.currentState!.validate()) {
    _key!.currentState!.save();
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(
      context,
      listen: false,
    );
    final StateManagerProvider stateManagerProvider =
        Provider.of<StateManagerProvider>(
      context,
      listen: false,
    );

    final Map<String, dynamic> formData = {
      "title":
          propertiesProvider.get_Property_Field_By_Lang_key("title")!.value,

      "address":
          propertiesProvider.get_Property_Field_By_Lang_key("address")!.value,
      "email":
          propertiesProvider.get_Property_Field_By_Lang_key("email")!.value,
      "phone":
          propertiesProvider.get_Property_Field_By_Lang_key("phone")!.value,
      "price":
          propertiesProvider.get_Property_Field_By_Lang_key("price")!.value,
      "property_type": propertiesProvider
          .get_Property_Field_By_Lang_key("property_type")!
          .value,
      "city": propertiesProvider.get_Property_Field_By_Lang_key("city")!.value,
      "purpose":
          propertiesProvider.get_Property_Field_By_Lang_key("purpose")!.value,
      "area": propertiesProvider
          .get_Property_Field_By_Lang_key("total_area")!
          .value,
      "unit": propertiesProvider
          .get_Property_Field_By_Lang_key("total_unit")!
          .value,
      "room": propertiesProvider
          .get_Property_Field_By_Lang_key("total_room")!
          .value,
      "bedroom": propertiesProvider
          .get_Property_Field_By_Lang_key("total_bedroom")!
          .value,
      "bathroom": propertiesProvider
          .get_Property_Field_By_Lang_key("total_bathroom")!
          .value,
      "floor": propertiesProvider
          .get_Property_Field_By_Lang_key("total_floor")!
          .value,
      "kitchen": propertiesProvider
          .get_Property_Field_By_Lang_key("total_kitchen")!
          .value,
      "parking": propertiesProvider
          .get_Property_Field_By_Lang_key("parking_place")!
          .value,
      "pdf_file":
          propertiesProvider.get_Property_Field_By_Lang_key("pdf_file")!.value,
      "banner_image": propertiesProvider
          .get_Property_Field_By_Lang_key("banner_img")!
          .value,
      "thumbnail_image":
          propertiesProvider.get_Property_Field_By_Lang_key("thumb_img")!.value,
      "slider_images":
          propertiesProvider.get_Property_Field_By_Lang_key("photo")!.values,
      "video_link": propertiesProvider
          .get_Property_Field_By_Lang_key("video_link")!
          .value,
      // "aminities": propertiesProvider
      //     .get_Property_Field_By_Lang_key("aminities")!
      // .values,
      "nearest_locations": propertiesProvider
          .get_Property_Field_By_Lang_key("nearest_loc")!
          .values,
      "distances":
          propertiesProvider.get_Property_Field_By_Lang_key("distance")!.values,
      // "period":
      //     propertiesProvider.get_Property_Field_By_Lang_key("price")!.value,
      "google_map_embed_code": propertiesProvider
          .get_Property_Field_By_Lang_key("google_map")!
          .value,
      "description":
          propertiesProvider.get_Property_Field_By_Lang_key("des")!.value,
      // "featured":
      //     propertiesProvider.get_Property_Field_By_Lang_key("price")!.value,
      // "urgent_property":
      //     propertiesProvider.get_Property_Field_By_Lang_key("price")!.value,
      "seo_title":
          propertiesProvider.get_Property_Field_By_Lang_key("seo_title")!.value,
      "seo_description":
          propertiesProvider.get_Property_Field_By_Lang_key("seo_des")!.value
    };
    String? responseMsg;
    try {
      setState(() {
        loading = true;
      });

      responseMsg =
          await Provider.of<PropertiesProvider>(context, listen: false)
              .createProperty(
        formData,
      );

      setState(() {
        loading = false;
      });

      if (responseMsg == "posted") {
        await Utils().showPopUp(
          context,
          "تمت إضافة البيانات بنجاح",
        );

        propertiesProvider.cleare_form_data();
        stateManagerProvider.cleareData();
        Navigator.of(context).pop();
      } else if (Provider.of<PropertiesProvider>(context, listen: false)
          .formResponseErrorMsgs!
          .isNotEmpty) {
        Utils().showPopUpWithMultiLinesError(
          context,
          responseMsg.toString(),
          Provider.of<PropertiesProvider>(context, listen: false)
              .formResponseErrorMsgs,
        );
      } else {
        Utils().showPopUp(context, "حدثت مشكلة ما", responseMsg.toString());
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      Utils().showPopUp(context, "حدثت مشكلة ما", responseMsg.toString());
    }

    // }
    // else {
    // await Utils().showPopUp(context, "إدخالات غير صالحة", "تأكد من بياناتك");
    // }
  }
}
