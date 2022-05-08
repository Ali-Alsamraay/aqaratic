import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/Service.dart';
import 'package:aqaratak/providers/services_provider.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/FormValidator.dart';
import 'package:sizer/sizer.dart';

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
        ),
        SizedBox(
          height: 2.0.h,
        ),

        // last name
        CustomTextField(
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
          onValidateFunc: (value) {
            return formValidator.validateTextField(value);
          },
          onSaveFunc: (value) {
            _serviceData.regarding_info = value!.trim();
          },
          label: "إضافة تفاصيل",
          detailsField: true,
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
        await showPopUp(
          "تمت إضافة البيانات بنجاح",
        );
        Navigator.of(context).pop();
      } else {
        showPopUp("حدثت مشكلة ما", responseMsg.toString());
      }
    } else {
      await showPopUp("إدخالات غير صالحة", "تأكد من بياناتك");
    }
  }

  Future<void> showPopUp(String? title, [String? content]) async {
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
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.onSaveFunc,
    required this.onValidateFunc,
    required this.label,
    this.detailsField = false,
  }) : super(key: key);
  final Function(String?) onValidateFunc;
  final void Function(String?)? onSaveFunc;
  final String? label;
  final bool? detailsField;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          keyboardType: TextInputType.text,
          textDirection: TextDirection.rtl,
          autofocus: true,
          cursorColor: accentColorBrown,
          maxLines: detailsField! ? 5 : 1,
          decoration: InputDecoration(
            focusColor: accentColorBrown,
            hintText: label!,
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15.0.sp,
              ),
            ),
          ),
          validator: (String? v) {
            final errorMsg = onValidateFunc(v);
            return errorMsg;
          },
          onSaved: (value) => onSaveFunc!(value),
        ),
      ),
    );
  }
}
