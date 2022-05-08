import '../models/get_lookups_info/get_lookups_info_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../helper/constants.dart';
import '../helper/endpoints.dart';
import '../helper/networking.dart';

class AddUnitScreen extends StatefulWidget {
  const AddUnitScreen({Key? key}) : super(key: key);

  @override
  State<AddUnitScreen> createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<GetLookupsInfoModel> _lookupsList = [];

  String lookupID = '';
  Map<String, SvgPicture> categories = {
    'أراضي': SvgPicture.asset(
      'assets/images/land_icon.svg',
      height: 25.0,
      width: 25.0,
    ),
    'عماير': SvgPicture.asset('assets/images/building_icon.svg',
        height: 25.0, width: 25.0),
    'فيلا': SvgPicture.asset('assets/images/villa_icon.svg',
        height: 25.0, width: 25.0),
  };
  List<bool> isSelected = [true, false, false];
  List<XFile>? images;
  var apiFinished;

  Future<bool> getCategoriesType() async {
    Map<String, dynamic> lookupsParams = {'lookuptype': 'unit_type'};
    NetworkHelper userTypes = NetworkHelper(
        endpoint: lookupsEndpoint, params: lookupsParams, context: context);
    List lookupDataMap = await userTypes.getRequest();
    if (lookupDataMap != null) {
      for (int i = 0; i < lookupDataMap.length; i++) {
        _lookupsList.add(GetLookupsInfoModel.fromJson(lookupDataMap[i]));
      }
      lookupID = _lookupsList[0].id!;
      print(lookupID);
    }
    return true;
  }

  Future addUnit() async {
    // Map<String, dynamic> paramaters = {};
    // NetworkHelper getAllUnits = NetworkHelper(
    //     endpoint: uploadFileEndpoint, params: paramaters, context: context);
    // var dataMap = await getAllUnits.uploadImages(File(images![0].path));
    //
    // if (dataMap != null) {
    //   print(dataMap);
    // }

    Map<String, dynamic> paramaters = {
      "title": titleController.text,
      "address": addressController.text,
      "description": detailsController.text,
      "area": areaController.text,
      "rooms": roomsController.text,
      "price": priceController.text,
      "unit_type": lookupID,
    };
    NetworkHelper getAllUnits = NetworkHelper(
        endpoint: aqarUnitsEndpoint, params: paramaters, context: context);
    var dataMap = await getAllUnits.postRequest();

    if (dataMap != null) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiFinished = getCategoriesType();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: apiFinished,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  extendBodyBehindAppBar: true,
                  extendBody: true,
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
                    title: const Text("اضافة اعلان",
                        style: TextStyle(
                            color: accentColorBlue,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 18.0)),
                  ),
                  body: Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Ink(
                          width: double.infinity,
                          height: 150,
                          child: GridView.count(
                            primary: true,
                            crossAxisCount:
                                3, //set the number of buttons in a row
                            crossAxisSpacing:
                                15, //set the spacing between the buttons
                            childAspectRatio:
                                2.4, //set the width-to-height ratio of the button,
                            //>1 is a horizontal rectangle
                            children: List.generate(isSelected.length, (index) {
                              //using Inkwell widget to create a button
                              return InkWell(
                                  //the default splashColor is grey
                                  onTap: () {
                                    lookupID = _lookupsList[index].id!;
                                    //set the toggle logic
                                    setState(() {
                                      for (int indexBtn = 0;
                                          indexBtn < isSelected.length;
                                          indexBtn++) {
                                        if (indexBtn == index) {
                                          isSelected[indexBtn] = true;
                                        } else {
                                          isSelected[indexBtn] = false;
                                        }
                                      }
                                    });
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        color: isSelected[index]
                                            ? accentColorBlue
                                            : Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        categories.values.elementAt(index),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${categories.keys.elementAt(index)}',
                                          style: TextStyle(
                                              color: isSelected[index]
                                                  ? Colors.white
                                                  : accentColorBlue),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ));
                            }),
                          ),
                        ),
                        // Container(
                        //     width: double.infinity,
                        //     height: 50,
                        //     child: TextFormField(
                        //       decoration: InputDecoration(
                        //           contentPadding: EdgeInsets.all(10.0),
                        //           border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(15.0),
                        //           ),
                        //           filled: true,
                        //           hintText: 'المكان',
                        //           hintStyle:
                        //               TextStyle(color: Color(0xffb3bbcb), fontSize: 20),
                        //           suffixIcon: UnconstrainedBox(
                        //             child: SvgPicture.asset(
                        //               'assets/images/target_icon.svg',
                        //               width: 25,
                        //               height: 25,
                        //             ),
                        //           ),
                        //           prefixIcon: Icon(
                        //             Icons.pin_drop_rounded,
                        //             color: accentColorBrown,
                        //           )),
                        //     )),
                        Container(
                            width: double.infinity,
                            height: 50,
                            child: TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                hintText: 'المدينة / الحي',
                                hintStyle: const TextStyle(
                                    color: Color(0xffb3bbcb), fontSize: 20),
                              ),
                            )),
                        Container(
                            width: double.infinity,
                            height: 50,
                            child: TextFormField(
                              controller: titleController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                hintText: 'عنوان الإعلان',
                                hintStyle: const TextStyle(
                                    color: Color(0xffb3bbcb), fontSize: 20),
                              ),
                            )),

                        Container(
                            width: double.infinity,
                            child: TextFormField(
                              maxLines: null,
                              controller: detailsController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                hintText: 'التفاصيل',
                                hintStyle: const TextStyle(
                                    color: const Color(0xffb3bbcb),
                                    fontSize: 20),
                              ),
                            )),
                        // const Text("اضف صور ",
                        //     style: const TextStyle(
                        //       fontFamily: 'Cairo',
                        //       color: Color(0xff0c2757),
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w700,
                        //       fontStyle: FontStyle.normal,
                        //     )),
                        // Row(
                        //   children: [
                        //     DottedBorder(
                        //       borderType: BorderType.RRect,
                        //       color: accentColorBrown,
                        //       radius: const Radius.circular(15),
                        //       child: GestureDetector(
                        //         onTap: () async {
                        //           final ImagePicker _picker = ImagePicker();
                        //
                        //           final List<XFile>? pickedImages =
                        //               await _picker.pickMultiImage();
                        //
                        //           if (pickedImages != null) {
                        //             setState(() {
                        //               images = pickedImages;
                        //             });
                        //           } else {
                        //             return;
                        //           }
                        //           // Capture a photo
                        //           // final XFile photo =
                        //           //     await _picker.pickImage(source: ImageSource.camera);
                        //
                        //           // Pick multiple images
                        //           // final List<XFile> images = await _picker.pickMultiImage();
                        //         },
                        //         child: Container(
                        //           width: 76,
                        //           height: 76,
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //             children: const [
                        //               Icon(
                        //                 Icons.camera_alt,
                        //                 size: 35,
                        //                 color: accentColorBrown,
                        //               ),
                        //               Text(
                        //                 "اضف صورة",
                        //                 style: TextStyle(
                        //                     color: Color(0xffcccccc),
                        //                     fontWeight: FontWeight.w400,
                        //                     fontStyle: FontStyle.normal,
                        //                     fontSize: 10.0),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 20,
                        //     ),
                        //     images == null
                        //         ? const SizedBox.shrink()
                        //         : GestureDetector(
                        //             onLongPress: () {
                        //               setState(() {
                        //                 images = null;
                        //               });
                        //             },
                        //             child: SizedBox(
                        //               height: 100,
                        //               width: 330,
                        //               child: ListView.builder(
                        //                 scrollDirection: Axis.horizontal,
                        //                 itemCount: images!.length,
                        //                 itemBuilder:
                        //                     (BuildContext context, int index) =>
                        //                         ClipRRect(
                        //                   borderRadius: BorderRadius.circular(8.0),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(3.0),
                        //                     child: Image.file(
                        //                       File(images![index].path),
                        //                       width: 100,
                        //                       height: 100,
                        //                       fit: BoxFit.fill,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                    height: 100,
                                    child: TextFormField(
                                      controller: areaController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        filled: true,
                                        hintText: 'المساحة',
                                        hintStyle: const TextStyle(
                                            color: const Color(0xffb3bbcb),
                                            fontSize: 20),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                    height: 100,
                                    child: TextFormField(
                                      controller: roomsController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        filled: true,
                                        hintText: 'عدد الغرف',
                                        hintStyle: const TextStyle(
                                            color: const Color(0xffb3bbcb),
                                            fontSize: 20),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            filled: true,
                            hintText: 'السعر',
                            hintStyle: const TextStyle(
                                color: Color(0xffb3bbcb), fontSize: 20),
                          ),
                        )),
                        Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async {
                              await addUnit();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const MainScreen()));
                            },
                            child: const Text(
                              'أضف الإعلان',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffb78457)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            // empty data case
            return Container();
          }
        } else {
          return AlertDialog(
            content: Text('State: ${snapshot.connectionState}'),
          );
        }
      });
}
