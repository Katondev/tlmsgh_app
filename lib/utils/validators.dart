import 'dart:developer';

import 'package:get/get.dart';

class Validators {
  static String? validateDigits(String value, String type, int length) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      log("1");
      return "$type is Required";
    } else if (value.length != length) {
      log("2");
      return "$type must be of $length digits";
    } else if (!regExp.hasMatch(value)) {
      log("3");
      return "$type must be a number. Example: 100";
    } else {
      log("4");
      return null;
    }
  }

  static String? validateContact(String value, String type) {
    // Pattern pattern = r'^(?:[+0][1-9])?[0-9]{5,20}$';
    // RegExp regExp =  RegExp(pattern);
// !regExp.hasMatch(value.toString())
    if (value.isNotEmpty) {
      if (value.length < 11 || value.length > 20) {
        return "Are you sure that you've entered your phone correctly?";
      }
    }
    return null;
  }

  static String? validateAmount(int? value, String type, String type2) {
    if (value == null || value < 10) {
      return type;
    } else if (value > 200) {
      return type2;
    } else {
      return null;
    }
  }

  static String? validateRequired(String value, String type) {
    if (value.isEmpty) {
      return "$type required";
    }
    return null;
  }

  static String? validaterequired(String? value, String? type) {
    if (value!.isEmpty) {
      return "$type";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "please_enter_password".tr;
    } else if (value.length <= 6) {
      return "password_validate".tr;
    }
    return null;
  }

  static String? validateSamePassword(
      String? rePassValue, String? newPassValue) {
    if (rePassValue!.isEmpty) {
      return "please_enter_password".tr;
    } else if (rePassValue != newPassValue) {
      return "password_not_match".tr;
    }
    return null;
  }

  static String? validateMobile(String? value) {
    String val = int.parse(value.toString()).toString();
    // String val =
    //     value!.split("").first == "0" ? value.replaceRange(0, 1, "") : value;
    log(val);
    if (val.isEmpty) {
      return "require_mobilenumber".tr;
    } else if (val.length != 9) {
      return "mobile_no_validate".tr;
    }
    return null;
  }

  static String? validateParentMobile(String? value) {
    // String val = value!.replaceFirst('0', '');
    String val = int.parse(value.toString()).toString();
    log(val);
    if (val.isEmpty) {
      return "require_parent_phone".tr;
    } else if (val.length != 9) {
      return "mobile_no_validate".tr;
    }
    return null;
  }

  static String? validateCharacter(String value, String type, int length) {
    String patttern = r'(^[a-zA-Z0-9]{8,16}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "$type is Required";
    } else if (value.length != length) {
      return "$type must be of $length character";
    } else if (!regExp.hasMatch(value)) {
      return "$type is invalid!";
    }
    return null;
  }

  // static String? validateMobile(String value) {
  //   String patttern = r'(^\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4,5})$)';
  //   RegExp regExp = RegExp(patttern);
  //   if (value.isEmpty) {
  //     return "Phone number is Required";
  //   } else if (!regExp.hasMatch(value)) {
  //     return "Phone number is not valid";
  //   }
  //   return null;
  // }

  //For Email Verification we using RegEx.
  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null) {
      return "Email is required".tr;
    } else if (!regExp.hasMatch(value)) {
      return "Invalid  Email".tr;
    } else {
      return null;
    }
  }

  static String? validateLoginEmail(String? value) {
    // bool emailValid = RegExp(
    //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch(value!);
    if (value!.isEmpty) {
      return "Email or PhoneNumber is required".tr;
    }
    // else if (emailValid == false) {
    //   return 'Please Enter Valid Email or PhoneNumber'.tr;
    // }
    return null;
  }

  static String? validatePaypalEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null) {
      return "Paypal Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Paypal Email";
    } else {
      return null;
    }
  }

  static String? validateFname(String? value, String type, String type2) {
    String pattern = r'^[a-zA-Z]{2,50}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.length <= 1) {
      return type;
    } else if (!regExp.hasMatch(value)) {
      return type2;
    } else {
      return null;
    }
  }

  // ignore: missing_return
  static String? validateText({String? value, String? text, int? maxLen}) {
    if (value.toString().isEmpty) {
      return "$text is required";
    } else {
      if (value.toString().isNotEmpty) {
        if (value.toString().length < 2) {
          return "$text must have at least 2 characters";
        } else if (maxLen != null && value.toString().length > maxLen) {
          return "You have reached your maximum limit of characters allowed";
        } else {
          return null;
        }
      }
    }
    return null;
  }

  static String? validatepass(String? value) {
    if (value!.isEmpty) {
      return "Password is required".tr;
    }
    if (value.length < 8) {
      return 'Password Must be more than 8 charater'.tr;
    } else {
      return null;
    }
  }

  String? validateBusinessMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String? validateestablishedyear(String value) {
    var date = DateTime.now();
    int currentYear = date.year;
    int userinputValue = 0;

    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    // int numValue = int.parse(value);
    if (!regExp.hasMatch(value)) {
      return "Year must be number only";
    } else if (value.isEmpty) {
      return "Established Year is Required";
    } else {
      userinputValue = int.parse(value);
    }

    if (userinputValue < 1850 || userinputValue > currentYear) {
      return "Year must be between 1850 and $currentYear";
    }
    return null;
  }

  String? validateLicenseno(String value) {
    if (value.isEmpty) {
      return "License No is Required";
    }
    return null;
  }

  String? validatenumberofemployee(String value) {
    String patttern = r'(^[1-9]\d*(\.\d+)?$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Number of employee is Required";
    } else if (value.length > 4) {
      return "Number of employee is not more than 9999";
    } else if (!regExp.hasMatch(value)) {
      return "Number of employee must be digits";
    }
    return null;
  }

  String? validatedate(String value) {
    String patttern = r'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Date is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter valid date";
    }
    return null;
  }

  String? validateLicenseissuingauthority(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "License Issuing Authority is Required";
    } else if (!regExp.hasMatch(value)) {
      return "License Issuing Authority must be a-z and A-Z";
    }
    return null;
  }
}
