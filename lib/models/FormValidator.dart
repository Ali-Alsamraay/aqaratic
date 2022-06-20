class FormValidator {
  static FormValidator? _instance;

  factory FormValidator() => _instance ??= new FormValidator._();

  FormValidator._();

  dynamic validatePassword(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "الرقم السري مطلوب";
    }
    // else if (value.length < 8) {
    //   return "Password must minimum eight characters";
    // } else if (!regExp.hasMatch(value)) {
    //   return "Password at least one uppercase letter, one lowercase letter and one number";
    // }
    return null;
  }

  dynamic validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value!.trim().isEmpty) {
      return "الإيميل مطلوب";
    } else if (!regExp.hasMatch(value)) {
      return "إيميل غير صالح";
    } else {
      return null;
    }
  }

  dynamic validateTextField(String? value) {
    if (value!.trim().isEmpty) {
      return "هذا الحقل مطلوب";
    } else {
      return null;
    }
  }

  dynamic validatePhoneNumber(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value!.length == 0) {
      return "هذا الحقل مطلوب";
    } else if (!regExp.hasMatch(value)) {
      return "رقم الهاتف غير صالح";
    }
    return null;
  }

  dynamic validateNumber(String? value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value!.trim())) {
      return "الرجاء ادخال رقم صحيح";
    }
    return null;
  }
}
