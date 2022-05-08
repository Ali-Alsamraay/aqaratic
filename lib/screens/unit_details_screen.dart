import 'dart:async';

import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/get_all_units_info/get_all_units_info_model.dart';
import 'package:aqaratak/models/property.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sizer/sizer.dart';

class UnitDetails extends StatefulWidget {
  // final Results unitInfo;
  const UnitDetails({Key? key}) : super(key: key);

  @override
  State<UnitDetails> createState() => _UnitDetailsState();
}

class _UnitDetailsState extends State<UnitDetails> {
  int sliderIndex = 0;
  // List<Marker> markerList = [];

  // final Completer<GoogleMapController> _controller = Completer();
  var _kGooglePlex;

  @override
  void initState() {
    // // // TODO: implement initState
    // super.initState();
    // final int? propertyId = ModalRoute.of(context)!.settings.arguments as int;
    // final Property? selectedProperty =
    //     Provider.of<PropertiesProvider>(context, listen: false)
    //         .getPropertyById(propertyId);
    // _kGooglePlex = CameraPosition(
    //   target: LatLng(
    //     selectedProperty!.latitude!,
    //     selectedProperty.longitude!,
    //   ),
    //   zoom: 16,
    // );
    // setMarkers(selectedProperty.latitude!, selectedProperty.longitude!);
  }

//   setMarkers(double? latitude, double? longitude) {
//     final marker2 = Marker(
//       markerId: MarkerId('place_name'),
//       position: LatLng(latitude!, longitude!),
//       icon: BitmapDescriptor.defaultMarker,
//       infoWindow: InfoWindow(
//         title: 'فلتين في تنال المسك',
//         snippet:
//             """
//           فلل  في حي تنال المسك
// مساحه  كل  فله300 شماليات
// درج داخلي + شقه
// الدور الارضي
// ملحق خارجي
// مجلس + مقلط دورة مياة
// طبخ وصاله ودورة مياه
// الدور الاول غرف نوم
// شارع 15 امام مرفق
// البيع باذن الله مليون 500
//                 """,
//       ),
//     );

//     setState(() {
//       markerList.addAll([marker2]);
//     });
//   }

  @override
  Widget build(BuildContext context) {
    final int? propertyId = ModalRoute.of(context)!.settings.arguments as int;

    final Property? selectedProperty =
        Provider.of<PropertiesProvider>(context, listen: false)
            .getPropertyById(propertyId);

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
                            imageBaseUrl + selectedProperty.images_urls![index],
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
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.0.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                'assets/images/area_icon.svg',
                                color: accentColorBrown,
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text('${selectedProperty.area ?? 0}',
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                              const VerticalDivider(),
                              SvgPicture.asset('assets/images/bath_icon.svg',
                                  color: accentColorBrown,
                                  height: 30.0,
                                  width: 30.0),
                              Text("0",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                              const VerticalDivider(),
                              SvgPicture.asset(
                                'assets/images/rooms_icon.svg',
                                color: accentColorBrown,
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text(
                                '${selectedProperty.number_of_room ?? 0}',
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                        ),
                        child: Text("رقم الترخيص",
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
                        child: Text('11223344',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                        ),
                        child: Text("الوصف",
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
                        child: Text(selectedProperty.description ?? '',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 10.0.sp,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0.w,
                        ),
                        child: Text("العنوان",
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
                          child: Text(selectedProperty.address ?? '',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ))),
                      Center(
                          // child: Container(
                          //   width: 350,
                          //   height: 250,
                          //   child: GoogleMap(
                          //     myLocationButtonEnabled: false,
                          //     mapType: MapType.terrain,
                          //     initialCameraPosition: _kGooglePlex,
                          //     onMapCreated: (GoogleMapController controller) {
                          //       _controller.complete(controller);
                          //     },
                          //     markers: markerList.map((e) => e).toSet(),
                          //   ),
                          // ),
                          ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.0.w,
                          ),
                          child: Text("المميزات",
                              style: TextStyle(
                                color: Color(0xff0c2757),
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ))),
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.0.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset('assets/images/pool_icon.svg',
                                  color: accentColorBrown,
                                  height: 25.0,
                                  width: 25.0),
                              Text("حمام سباحة",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 10.0.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                              const VerticalDivider(),
                              SvgPicture.asset(
                                  'assets/images/security_icon.svg',
                                  color: accentColorBrown,
                                  height: 25.0,
                                  width: 25.0),
                              Text("آمن",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 10.0.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                              const VerticalDivider(),
                              SvgPicture.asset('assets/images/car_icon.svg',
                                  color: accentColorBrown,
                                  height: 25.0,
                                  width: 25.0),
                              Text("موقف سيارات",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 10.0.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      )
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
                        child: const Text(
                          'أطلب',
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
                          "معلومات صاحب الخدمة",
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
                              ":الإسم",
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
                              ":الإيميل",
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
                              ":رقم الهاتف",
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
                          child: const Text(
                            'تواصل',
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
