import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aqaratak/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class Utils {
  Future<void> showPopUp(BuildContext context, String? title,
      [String? content]) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title!,
          textAlign: TextAlign.end,
        ),
        content: content == null
            ? Icon(
                Icons.done,
                color: accentColorBrown,
                size: 25.0.sp,
              )
            : Text(
                content.toString(),
                textAlign: TextAlign.end,
              ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(
              context,
            ),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                color: accentColorBrown,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showPopUpWithMultiLinesError(
    BuildContext context,
    String? title,
    List<dynamic>? errorsMsgs,
  ) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title!,
          textAlign: TextAlign.end,
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                errorsMsgs!.length,
                (index) {
                  return Column(
                    children: [
                      Text(
                        errorsMsgs[index],
                        textAlign: TextAlign.end,
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(
              context,
            ),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                color: accentColorBrown,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?>? showPopUpAndPickImage(
    BuildContext context,
    String? title,
  ) async {
    File? imageFile;
    String? base64File;

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title!,
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 20.0.h,
          width: 70.0.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 30.0.w,
                height: 15.0.h,
                child: Card(
                  shadowColor: accentColorBrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0.sp),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        imageFile = File(pickedFile.path);
                        base64File = convertFileToBase64(imageFile!.path);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: accentColorBrown,
                          size: 20.0.sp,
                        ),
                        Text(
                          "من الكاميرا",
                          style: TextStyle(
                            color: accentColorBrown,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 30.0.w,
                height: 15.0.h,
                child: Card(
                  shadowColor: accentColorBrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0.sp),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        imageFile = File(pickedFile.path);
                        base64File = convertFileToBase64(imageFile!.path);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.image,
                          color: accentColorBrown,
                          size: 20.0.sp,
                        ),
                        Text(
                          "من المعرض",
                          style: TextStyle(
                            color: accentColorBrown,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return base64File;
  }

  String getBase64FileExtension(String base64String) {
    switch (base64String.characters.first) {
      case '/':
        return 'jpeg';
      case 'i':
        return 'png';
      case 'R':
        return 'gif';
      case 'U':
        return 'webp';
      case 'J':
        return 'pdf';
      default:
        return 'unknown';
    }
    
  }

  String? convertFileToBase64(String? filePath) {
    try {
      final File? imageFile = new File(filePath!);
      final List<int>? imageBytes = imageFile!.readAsBytesSync();
      final String? base64Image = base64Encode(imageBytes!);
      return base64Image;
    } catch (e) {
      rethrow;
    }
  }

  List<dynamic>? drop_down_options_mapper(
    List<dynamic>? options,
    dynamic optionTitle,
    dynamic id,
  ) {
    final List<dynamic>? convertedOptions = options!.map(
      (e) {
        return {
          "id": e[id],
          "option-title": e[optionTitle],
        };
      },
    ).toList();

    return convertedOptions;
  }
}
