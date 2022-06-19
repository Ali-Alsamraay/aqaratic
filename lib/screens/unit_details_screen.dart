import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/FormValidator.dart';
import 'package:aqaratak/models/property.dart';
import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:aqaratak/providers/State_Manager_Provider.dart';
import 'package:aqaratak/widgets/Custom_TextField.dart';
import 'package:aqaratak/widgets/Custom_TextField_Builder.dart';
import 'package:aqaratak/widgets/Image_PDF_Video_Fields.dart';
import 'package:aqaratak/widgets/comment_widget_view.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sizer/sizer.dart';

class UnitDetailsScreen extends StatefulWidget {
  // final Results unitInfo;
  const UnitDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UnitDetailsScreen> createState() => _UnitDetailsScreenState();
}

class _UnitDetailsScreenState extends State<UnitDetailsScreen> {
  int sliderIndex = 0;

  String? getImagesUrl(String url) {
    return url.startsWith("/") ? url : "/" + url;
  }

  Future<void> shareLink(String title, String description, String image) async {
    await FlutterShare.share(
      title: title,
      text: description,
      linkUrl: image,
      chooserTitle: 'عقاراتـك',
    );
  }

  void showCommentPopUp(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Container(
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0.sp),
            ),
            child: SizedBox(
              width: 90.0.w,
              height: 45.0.h,
              child: Center(
                child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 2.0.h,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.0.w, vertical: 1.h),
                      child: Column(
                        children: [
                          Text('add_new_comment'.tr,
                              style: TextStyle(
                                color: accentColorBlue,
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                          SizedBox(height: 1.h),
                          Align(
                            alignment: Alignment.topRight,
                            child: RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 25,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 3.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: accentColorBlue, width: 2.0)),
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.multiline,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 11),
                              decoration: InputDecoration(
                                hintText: "write_comment_here".tr,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                              ),
                              autofocus: false,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.0.w,
                              vertical: 0.0.h,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0.sp),
                                color: accentColorBrown,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 7.0.w,
                                  vertical: 0.5.h,
                                ),
                                child: Center(
                                  child: Text(
                                    "add_comment".tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    final int? propertyId = ModalRoute.of(context)!.settings.arguments as int;

    final Property? selectedProperty =
        Provider.of<PropertiesProvider>(context, listen: false)
            .getPropertyById(propertyId);

    final StateManagerProvider stateManagerProvider =
    Provider.of<StateManagerProvider>(
      context,
      listen: false,
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: 100.0.w,
          height: 100.0.h,
          decoration: const BoxDecoration(
            color: Color(0xffE9EAEE),
          ),
          child: Stack(alignment: Alignment.topCenter, children: [
            SizedBox(
              height: 50.0.h,
              child: Stack(children: [
                selectedProperty!.images_urls!.isNotEmpty
                    ? CarouselSlider.builder(
                        itemCount: selectedProperty.images_urls?.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) =>
                                Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Image.network(
                            baseUrl +
                                getImagesUrl(selectedProperty
                                    .images_urls![index]
                                    .toString())!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              sliderIndex = index;
                            });
                          },
                          height: double.infinity,
                          viewportFraction: 10,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    : Image.asset(
                        imagePath + 'background.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedSmoothIndicator(
                      activeIndex: sliderIndex,
                      count: selectedProperty.images_urls!.isEmpty
                          ? 1
                          : selectedProperty.images_urls!.length,
                      textDirection: TextDirection.rtl,
                      effect: const WormEffect(
                          dotColor: Colors.white,
                          activeDotColor: accentColorBrown),
                    ),
                  ),
                ),
              ]),
            ),
            Positioned(
              top: 2.0,
              left: 0.0,
              right: 5.0.w,
              child: SizedBox(
                width: 100.0.w,
                height: 12.0.h,
                child: AppBar(
                  leading: RawMaterialButton(
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
                  actions: [
                    RawMaterialButton(
                      elevation: 0.0,
                      onPressed: () => shareLink(
                          selectedProperty.title!,
                          selectedProperty.description!,
                          baseUrl + selectedProperty.thumbnail_image!),
                      fillColor: Colors.white,
                      padding: const EdgeInsets.only(right: 10),
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.share,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                  backgroundColor:
                      Colors.transparent, //You can make this transparent
                  elevation: 0.0, //No shadow
                ),
              ),
            ),
            Positioned(
              top: 40.0.h,
              // left: 30.0,
              child: Container(
                height: 45.0.h,
                width: 80.0.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                          vertical: 3.0.h,
                        ),
                        child: Text(
                          selectedProperty.title ?? '',
                          style: TextStyle(
                            color: Color(0xff0c2757),
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                          vertical: 2.0.h,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.sp),
                            color: accentColorBrown,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.0.w,
                              vertical: 0.5.h,
                            ),
                            child: Center(
                              child: Text(
                                "details_and_features".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Field(
                        title: "address".tr,
                        value: selectedProperty.address ?? "there_is_no".tr,
                      ),
                      Field(
                        title: "license_number".tr,
                        value: authProvider.currentUser == null
                            ? "there_is_no".tr
                            : authProvider.currentUser!.authorization_number ??
                                "there_is_no".tr,
                      ),
                      Field(
                        title: "authorization_number".tr,
                        value: selectedProperty.authorization_num_of_GA ??
                            "there_is_no".tr,
                      ),
                      Field(
                        title: "property_type".tr,
                        value:
                            selectedProperty.property_type!['slug']!.toString(),
                      ),
                      Field(
                        title: "space".tr,
                        value: selectedProperty.area!.toString(),
                      ),
                      Field(
                        title: "bedrooms".tr,
                        value: selectedProperty.number_of_bedroom!.toString(),
                      ),
                      Field(
                        title: "bathrooms".tr,
                        value: selectedProperty.number_of_bathroom!.toString(),
                      ),
                      Field(
                        title: "rooms".tr,
                        value: selectedProperty.number_of_room!.toString(),
                      ),
                      Field(
                        title: "units".tr,
                        value: selectedProperty.number_of_unit!.toString(),
                      ),
                      Field(
                        title: "floors".tr,
                        value: selectedProperty.number_of_floor!.toString(),
                      ),
                      Field(
                        title: "kitchens".tr,
                        value: selectedProperty.number_of_kitchen!.toString(),
                      ),
                      Field(
                        title: "parking_place".tr,
                        value: selectedProperty.number_of_parking!.toString(),
                      ),
                      Field(
                        title: "description".tr,
                        value: selectedProperty.description ?? "there_is_no".tr,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                          vertical: 2.0.h,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.sp),
                            color: accentColorBrown,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.0.w,
                              vertical: 0.5.h,
                            ),
                            child: Center(
                              child: Text(
                                "means_of_comfort".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 8.0.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.0.w,
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 3.0.w,
                                vertical: 1.0.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0.sp),
                                color: accentColorBlue,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: accentColorBrown,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.0.w,
                                  ),
                                  Text(
                                    selectedProperty.property_aminities![index]
                                            ['aminity']['aminity']
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.0.w,
                                  ),
                                ],
                              ),
                            ),
                            itemCount:
                                selectedProperty.property_aminities!.length,
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                          vertical: 2.0.h,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.sp),
                            color: accentColorBrown,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.0.w,
                              vertical: 0.5.h,
                            ),
                            child: Center(
                              child: Text(
                                "map".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 70.0.w,
                          height: 50.0.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0.sp),
                            color: accentColorBrown,
                          ),
                          child: GoogleMap(
                            myLocationButtonEnabled: false,
                            mapType: MapType.terrain,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                selectedProperty.latitude!,
                                selectedProperty.longitude!,
                              ),
                              zoom: 12,
                            ),
                            onMapCreated: (GoogleMapController controller) {},
                            markers: {
                              Marker(
                                markerId: MarkerId(
                                  selectedProperty.id.toString(),
                                ),
                              ),
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                          vertical: 2.0.h,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.sp),
                            color: accentColorBrown,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.0.w,
                              vertical: 0.5.h,
                            ),
                            child: Center(
                              child: Text(
                                "nearby_locations".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 8.0.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.0.w,
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 3.0.w,
                                vertical: 1.0.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0.sp),
                                color: accentColorBlue,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    selectedProperty
                                        .property_nearest_locations![index]
                                            ['nearest_location']['location']
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.0.w,
                                  ),
                                  Text(
                                    ":",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.0.w,
                                  ),
                                  Text(
                                    selectedProperty
                                        .property_nearest_locations![index]
                                            ['distance']
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.0.w,
                                  ),
                                ],
                              ),
                            ),
                            itemCount: selectedProperty
                                .property_nearest_locations!.length,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                          vertical: 0.0.h,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.sp),
                            color: accentColorBrown,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.0.w,
                              vertical: 0.5.h,
                            ),
                            child: Center(
                              child: Text(
                                "engineering_plans".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        stateManagerProvider.add_image_Block(
                                          ImageBlock(
                                            key: UniqueKey(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: 1.0.h, top: 1.0.h),
                                        height: 7.0.h,
                                        decoration: BoxDecoration(
                                          color: accentColorBlue,
                                          borderRadius: BorderRadius.circular(
                                            15.0.sp,
                                          ),
                                          border: Border.all(
                                            width: 1.sp,
                                            color: accentColorBrown,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.0.w,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CustomTextField(
                                      onValidateFunc: (value) {},
                                      onSaveFunc: (value) {},
                                      label: 'engineering_plans'.tr,
                                    ),
                                  ),
                                ],
                              ),
                              Consumer<StateManagerProvider>(
                                builder: (context, value, child) => Column(
                                  children: [
                                    ...List.generate(
                                      value.imagesBlocks.length,
                                          (index) {
                                        value.imagesBlocks[index].index = index;

                                        return value.imagesBlocks[index];
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                          vertical: 0.0.h,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.sp),
                            color: accentColorBrown,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.0.w,
                              vertical: 0.5.h,
                            ),
                            child: Center(
                              child: Text(
                                "reviews".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      InkWell(
                        onTap: () {
                          showCommentPopUp(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.0.w,
                            vertical: 0.0.h,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.0.w, vertical: 2.0.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0.sp),
                              color: accentColorBlue,
                            ),
                            child: Text(
                              'add_new_comment_plus'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0.sp,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CommentWidgetView(
                                name: 'امجد الخطيب',
                                image:
                                    'https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg',
                                date: 'Sep 2021 18',
                                subject:
                                    'هذا التعليق مبني على فكرة طرح المثال ليناسب مبدأعرض التعليقات داخل هذا التطبيق',
                                rate: 4.0);
                          })
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: 100.0.w,
                height: 10.0.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.7)),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${selectedProperty.price} ريال ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xffb78457),
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                      RawMaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return Container(
                                width: 90.0.w,
                                height: 60.0.h,
                                child: Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: UserInfo(),
                                ),
                              );
                            },
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.sp),
                        ),
                        fillColor: accentColorBrown,
                        child: Text(
                          'request'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  const Field({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 7.0.w,
          ),
          child: Text(title,
              style: TextStyle(
                color: Color(0xff0c2757),
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 7.0.w,
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        const Divider(),
      ]),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: new Center(
        child: Container(
          width: 100.0.w,
          height: 50.0.h,
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
                child: Center(
                  child: SingleChildScrollView(
                      child: Container(
                    width: 60.0.w,
                    margin: EdgeInsets.symmetric(vertical: 2.0.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "service_owner_information".tr,
                          style: TextStyle(
                            color: accentColorBlue,
                            fontSize: 15.0.sp,
                          ),
                        ),
                        Divider(color: accentColorBlue, thickness: 0.2.sp),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              "name_form".tr,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 3.0.w,
                            ),
                            Text(
                              "أحمد منصور",
                              textAlign: TextAlign.end,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              "email_form",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 3.0.w,
                            ),
                            Text(
                              "ahmad@digitalfuture.sa",
                              textAlign: TextAlign.end,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              "phone_number_form".tr,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 3.0.w,
                            ),
                            Text(
                              "0771234567",
                              textAlign: TextAlign.end,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.sp),
                          ),
                          fillColor: accentColorBrown,
                          child: Text(
                            'communication'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
