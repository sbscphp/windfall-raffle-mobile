import 'package:flutter/material.dart';

const String defaultErrorMessage = "An Error Occurred. please try again";
const String defaultSuccessMessage = "Request was successful";
const String emptyEmailField = 'Email field cannot be empty!';
const String emptyTextField = 'Field cannot be empty!';
const String incorrectPasscodeLength = 'Passcode must be 6-digits';
const String emptyPasswordField = 'Password field cannot be empty';
const String invalidEmailField =
    "Invalid email";
const String passwordLengthError = 'Password length must be greater than 6';
const String emptyUsernameField = 'Username  cannot be empty';
const String usernameLengthError = 'Username length must be greater than 6';
const String emailRegex = '[a-zA-Z0-9\+\.\_\%\-\+]{1,256}' +
    '\\@' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}' +
    '(' +
    '\\.' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}' +
    ')+';

const String phoneNumberRegex = r'0[789][01]\d{8}';
const String phoneNumberLengthError = 'Phone number must be 11 digits';
const String invalidPhoneNumberField =
    "Invalid Phone Number";
const String terms = "";
const String faq = "https://windfall-fe-main-app.vercel.app/faq";
const String claimPrize = "";
const double phoneWidth = 500;
///design height, draft(responsiveness)
const double draftHeight = 932;

///design width, draft(responsiveness)
const double draftWidth = 430;
///pagination limit
const int paginationLimit = 20;

///aspect ratio
double aspectRatio(BuildContext context) {
  final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = MediaQuery.of(context).size.width / 2;

  double aspectRatio = (itemWidth / itemHeight);

  return aspectRatio;
}
