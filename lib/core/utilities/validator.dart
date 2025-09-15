

import 'package:windfall/core/utilities/utilities.dart';

import '../constants/app_constants.dart';

class EmailValidator {
  static String? validateEmail(String? value, {bool isCompulsory = true}) {
    if (value != null) {
      if(value.isEmpty && !isCompulsory){
        return null;
      }
      if (value.isEmpty) {
        return emptyEmailField;
      }
      // Regex for email validation
      final regExp = RegExp(emailRegex);
      if (regExp.hasMatch(value)) {
        return null;
      }

      return invalidEmailField;
    } else {
      return null;
    }
  }
}

class PhoneNumberValidator {
  static String? validatePhoneNumber(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
      // Regex for phone number validation
      final regExp = RegExp(phoneNumberRegex);
      //print(regExp.hasMatch(value));
      if (regExp.hasMatch(value)) {
        return null;
      }
      return invalidPhoneNumberField;
    } else {
      return null;
    }
  }
}

class PasswordValidator {
  static String? validatePassword(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyPasswordField;
      }

      if (value.length < 6) {
        return passwordLengthError;
      }
    } else {
      return null;
    }
    return null;
  }
}

class UsernameValidator {
  static String? validateUsername(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyUsernameField;
      }

      if (value.length < 6) {
        return usernameLengthError;
      }
    } else {
      return null;
    }

    return null;
  }
}

class FieldValidator {
  static String? validate(String? value) {
    if (value != null) {
      if (value.isEmpty || value.trim().isEmpty) {
        return emptyTextField;
      }
    } else {
      return null;
    }

    return null;
  }

}

class PasscodeFieldValidator {
  static String? validate(String? value) {
    if (value != null) {
      if (value.isEmpty || value.trim().isEmpty) {
        return emptyTextField;
      }
      if(value.length != 6){
        return incorrectPasscodeLength;
      }
    } else {
      return null;
    }

    return null;
  }
}

class AmountValidator {
  static String? validateAmount(String? value, {required double maxAmount, bool isEmptyFieldAllowed = true}) {
    if (value != null) {
      if (value.isEmpty) {
        return isEmptyFieldAllowed ? null : emptyTextField;
      }

      final amount = Utilities.formatToDouble(value: value);

      if (amount == null || amount == 0) {
        return 'Please enter a valid amount';
      }

      if (amount > maxAmount) {
        return "Amount can't exceed ₦${Utilities.formatAmount(amount: maxAmount)}";
      }

      return null;
    } else {
      return null;
    }
  }
}
