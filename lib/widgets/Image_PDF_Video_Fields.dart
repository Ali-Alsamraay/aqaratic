import 'dart:io';
import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/Property_Field.dart';
import 'package:aqaratak/widgets/Custom_TextField_Builder.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../helper/Utils.dart';
import '../models/FormValidator.dart';
import '../providers/Properties_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:file_picker/file_picker.dart';

import '../providers/State_Manager_Provider.dart';

class ImagePdfVideoFields extends StatefulWidget {
  ImagePdfVideoFields({
    Key? key,
  }) : super(key: key);

  final FormValidator? formValidator = FormValidator();

  @override
  State<ImagePdfVideoFields> createState() => _ImagePdfVideoFieldsState();
}

class _ImagePdfVideoFieldsState extends State<ImagePdfVideoFields> {
  File? imageFile;
  PermissionStatus? _permissionStatus;
  String? base64File;
  @override
  initState() {
    super.initState();
    () async {
      _permissionStatus = await Permission.storage.status;

      if (_permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        setState(() {
          _permissionStatus = permissionStatus;
        });
      }
    }();
  }

  final Utils utils = Utils();
  int? clickedItem;

  @override
  Widget build(BuildContext context) {
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

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2.0.h,
          ),
          FileOrImagePicker(
            isImage: false,
            propertiesProvider: propertiesProvider,
            langKey: "pdf_file",
          ),
          FileOrImagePicker(
            isImage: true,
            propertiesProvider: propertiesProvider,
            langKey: "banner_img",
          ),
          FileOrImagePicker(
            isImage: true,
            propertiesProvider: propertiesProvider,
            langKey: "thumb_img",
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    stateManagerProvider.add_image_Block(ImageBlock(
                      key: UniqueKey(),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2.0.h),
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
                child: FileOrImagePicker(
                  isImage: true,
                  propertiesProvider: propertiesProvider,
                  langKey: "photo",
                  isListOfImages: true,
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
          CustomTextFieldBuilder(
            formValidator: FormValidator(),
            textInputHeight: 7.0.h,
            propertiesProvider: propertiesProvider,
            langKey: "video_link",
            heightAfterField: 2.0.h,
            textInputType: TextInputType.url,
          ),
          SizedBox(
            height: 2.0.h,
          ),
        ],
      ),
    );
  }
}

class ImageBlock extends StatelessWidget {
  ImageBlock({
    Key? key,
  }) : super(key: key);
  int? index;

  @override
  Widget build(BuildContext context) {
    final PropertiesProvider propertiesProvider =
        Provider.of(context, listen: false);
    final StateManagerProvider stateManagerProvider =
        Provider.of(context, listen: false);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                stateManagerProvider.remove_image_Block(index!);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 2.0.h),
                height: 7.0.h,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    15.0.sp,
                  ),
                  border: Border.all(
                    width: 1.sp,
                    color: Colors.white,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.0.w,
          ),
          Expanded(
            flex: 3,
            child: FileOrImagePicker(
              isImage: true,
              propertiesProvider: propertiesProvider,
              langKey: "photo",
              isListOfImages: true,
            ),
          ),
        ],
      ),
    );
  }
}

class FileOrImagePicker extends StatelessWidget {
  FileOrImagePicker({
    Key? key,
    required this.isImage,
    required this.propertiesProvider,
    required this.langKey,
    this.isListOfImages = false,
  }) : super(key: key);

  final Utils utils = Utils();
  final bool? isImage;
  final String? langKey;
  final bool? isListOfImages;
  final PropertiesProvider? propertiesProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 7.0.h,
          child: GestureDetector(
            onTap: isImage!
                ? () async {
                    if (await Permission.storage.isDenied) {
                      await utils.showPopUp(
                        context,
                        "يجب منح عقاراتك الوصول إلى الصور لرفع صورة",
                        "لن تتمكن من رفع أي ملف إذا لم تقم بمنح الوصول",
                      );
                      final PermissionStatus permissionStatus =
                          await Permission.storage.request();
                      if (permissionStatus.isDenied) return;
                    }
                    final String? loadedImageBase64 = await utils
                        .showPopUpAndPickImage(context, "إختيار الصورة");
                    final PropertyField propertyField = propertiesProvider!
                        .get_Property_Field_By_Lang_key(langKey!)!;

                    if (isListOfImages!)
                      propertyField.values!.add(loadedImageBase64);
                    else
                      propertyField.value = loadedImageBase64;
                  }
                : () async {
                    if (await Permission.storage.isDenied) {
                      await utils.showPopUp(
                        context,
                        "يجب منح عقاراتك الوصول إلى الصور لرفع صورة",
                        "لن تتمكن من رفع أي ملف إذا لم تقم بمنح الوصول",
                      );
                      final PermissionStatus permissionStatus =
                          await Permission.storage.request();
                      if (permissionStatus.isDenied) return;
                    }
                    String? base64FileContent;
                    final FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      final File? file = File(result.files.first.path!);
                      base64FileContent = utils.convertFileToBase64(file!.path);
                      final PropertyField propertyField = propertiesProvider!
                          .get_Property_Field_By_Lang_key(langKey!)!;
                      propertyField.value = base64FileContent;
                    }
                  },
            child: Container(
              decoration: BoxDecoration(
                color: accentColorLightBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(
                  15.0.sp,
                ),
                border: Border.all(
                  width: 0.7.sp,
                  color: accentColorBlue,
                ),
              ),
              width: 80.0.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Icon(
                      isImage! ? Icons.image : Icons.upload_file,
                      color: accentColorBlue,
                      size: 17.0.sp,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      propertiesProvider!.get_Label_Text_By_Lang_key(langKey)!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2.0.h,
        ),
      ],
    );
  }
}
