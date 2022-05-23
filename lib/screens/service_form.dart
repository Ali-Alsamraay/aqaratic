import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/Service.dart';
import 'package:aqaratak/providers/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/Utils.dart';
import '../models/FormValidator.dart';
import 'package:sizer/sizer.dart';

import '../widgets/Custom_TextField.dart';

class ServiceForm extends StatefulWidget {
  final int? service_id;
  ServiceForm({required this.service_id});
  @override
  State<StatefulWidget> createState() {
    return new _ServiceFormState();
  }
}

class _ServiceFormState extends State<ServiceForm> {
  final GlobalKey<FormState>? _key = new GlobalKey();
  final Service _serviceData = Service();
  final FormValidator formValidator = FormValidator();
  bool? loading = false;

  @override
  void dispose() {
    if (_key != null && _key!.currentState != null) {
      _key!.currentState!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: new Center(
        child: Container(
          width: 100.0.w,
          height: 70.0.h,
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
                    child: new Form(
                      key: _key!,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: _getFormUI(),
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

  Widget _getFormUI() {
    return new Column(
      children: <Widget>[
        SizedBox(
          height: 6.0.h,
        ),

        // email
        CustomTextField(
          onValidateFunc: (value) {
            return formValidator.validateEmail(value);
          },
          onSaveFunc: (value) {
            _serviceData.email = value!.trim();
          },
          label: "البريد الإلكتروني",
          enabledBorderColor: accentColorBlue,
        ),
        SizedBox(
          height: 2.0.h,
        ),

        // first name
        CustomTextField(
          onValidateFunc: (value) {
            return formValidator.validateTextField(value!);
          },
          onSaveFunc: (value) {
            _serviceData.first_name = value!.trim();
          },
          label: "الإسم الأول",
          enabledBorderColor: accentColorBlue,
        ),
        SizedBox(
          height: 2.0.h,
        ),

        // last name
        CustomTextField(
          enabledBorderColor: accentColorBlue,
          onValidateFunc: (value) {
            return formValidator.validateTextField(value);
          },
          onSaveFunc: (value) {
            _serviceData.last_name = value!.trim();
          },
          label: "الإسم الأخير",
        ),
        SizedBox(
          height: 2.0.h,
        ),

        // phone number
        CustomTextField(
          enabledBorderColor: accentColorBlue,
          onValidateFunc: (value) {
            return formValidator.validatePhoneNumber(value);
          },
          onSaveFunc: (value) {
            _serviceData.phone = value!.trim();
          },
          label: "رقم الهاتف",
        ),
        SizedBox(
          height: 2.0.h,
        ),

        // details
        CustomTextField(
          enabledBorderColor: accentColorBlue,
          onValidateFunc: (value) {
            return formValidator.validateTextField(value);
          },
          onSaveFunc: (value) {
            _serviceData.regarding_info = value!.trim();
          },
          label: "إضافة تفاصيل",
          linesNumber: 5,
        ),
        SizedBox(
          height: 2.0.h,
        ),
        loading!
            ? CircularProgressIndicator.adaptive()
            : RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0.sp),
                ),
                onPressed: _sendToServer,
                padding: EdgeInsets.all(7.0.sp),
                color: accentColorBrown,
                child: Text(
                  'إضافة',
                  style: TextStyle(color: Colors.white),
                ),
              ),

        SizedBox(
          height: 4.0.h,
        ),
      ],
    );
  }

  _sendToServer() async {
    if (_key!.currentState!.validate()) {
      _key!.currentState!.save();
      setState(() {
        loading = true;
      });
      _serviceData.id = widget.service_id;
      final String? responseMsg =
          await Provider.of<ServicesProvider>(context, listen: false)
              .post_services(
        _serviceData.toJson(),
      );
      setState(() {
        loading = false;
      });
      if (responseMsg == "succeed_form") {
        await Utils().showPopUp(
          context,
          "تمت إضافة البيانات بنجاح",
        );
        Navigator.of(context).pop();
      } else {
        Utils().showPopUp(context, "حدثت مشكلة ما", responseMsg.toString());
      }
    } else {
      await Utils().showPopUp(context, "إدخالات غير صالحة", "تأكد من بياناتك");
    }
  }
}
