import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import '../data/models/grouped_list.dart';


class Utilities {
  static const nairaSign = "\u{20A6}";
  static const naira = "₦";
  static bool unauthorizedFlag = false;

  static List<String> electricityPresets = [
    "1000",
    "2000",
    "5000",
    "10000",
    "20000",
    "50000",
  ];

  //returns a currency symbol based on currency code
  static String getCurrencySymbol({String? currencyCode}) {
    var format = NumberFormat.simpleCurrency(name: currencyCode ?? 'NGN');
    return format.currencySymbol;
  }

  //format currency
  static String formatAmount({double? amount, bool addDecimal = true}) {
    try {
      final oCcy = addDecimal
          ? NumberFormat('#,##0.00', 'en_US')
          : NumberFormat('#,##0', 'en_US');
      final formattedAmount = oCcy.format(amount);
      return formattedAmount;
    } catch (e) {
      final oCcy = addDecimal
          ? NumberFormat('#,##0.00', 'en_US')
          : NumberFormat('#,##0', 'en_US');
      final formattedAmount = oCcy.format(0);
      return formattedAmount;
    }
  }

  //abbreviates money value
  static String abbreviateAmount({required double value}) {
    String formattedValue;

    if (value >= 1000000000) {
      formattedValue = (value / 1000000000).toStringAsFixed(2);
    } else if (value >= 1000000) {
      formattedValue = (value / 1000000).toStringAsFixed(2);
    } else if (value >= 1000) {
      formattedValue = (value / 1000).toStringAsFixed(2);
    } else {
      formattedValue = value.toStringAsFixed(2);
    }

    // Remove trailing zeros after decimal and the decimal point if it's an integer
    formattedValue = formattedValue.replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');

    if (value >= 1000000000) {
      return "${formattedValue}B";
    } else if (value >= 1000000) {
      return "${formattedValue}M";
    } else if (value >= 1000) {
      return "${formattedValue}K";
    } else {
      return formattedValue;
    }
  }

  //converts incoming string to human readable message
  static String formatMessage(String incomingMessage, {bool isSuccess = true}) {
    debugPrint('incoming raw message:::$incomingMessage>>>');
    if (incomingMessage.isEmpty) {
      return isSuccess ? defaultSuccessMessage : defaultErrorMessage;
    }

    // if (incomingMessage
    //         .toLowerCase()
    //         .contains("cannot read properties of undefined") ||
    //     incomingMessage.toLowerCase().contains("validation error") ||
    //     incomingMessage.toLowerCase().contains("null") ||
    //     incomingMessage.toLowerCase().contains("database") ||
    //     incomingMessage.toLowerCase().contains("_") ||
    //     incomingMessage.toLowerCase().contains("subtype") ||
    //     incomingMessage.toLowerCase().contains("formatexception") ||
    //     incomingMessage.toLowerCase().contains("string") ||
    //     incomingMessage.toLowerCase().contains("mysql error") ||
    //     //incomingMessage.toLowerCase().contains("v1") ||
    //     incomingMessage.toLowerCase().contains("er-bad-field-error")) {
    //   return "An Error Occurred. Please try again";
    // }

    return incomingMessage;
  }

  //hide keyboard
  static hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

  // Cleans phone number and add leading zero only if necessary
  static String cleanPhoneNumber({required String phoneNumber}) {

    if(phoneNumber.isEmpty)return '';

    // Remove white spaces
    String cleanedNumber = phoneNumber.replaceAll(' ', '');

    // Remove the prefix '+234'
    if (cleanedNumber.startsWith('+234')) {
      cleanedNumber = cleanedNumber.substring(4);

      //Add leading zero only if the number doesn't already start with '0'
      if (!cleanedNumber.startsWith('0')) {
        cleanedNumber = '0$cleanedNumber';
      }
    }

    // Remove the prefix '234'
    if (cleanedNumber.startsWith('234')) {
      cleanedNumber = cleanedNumber.substring(3);

      //Add leading zero only if the number doesn't already start with '0'
      if (!cleanedNumber.startsWith('0')) {
        cleanedNumber = '0$cleanedNumber';
      }
    }

    return cleanedNumber;
  }

  //mask characters in a string
  static String maskCharacters(
      {required String? subject,
      required int startIndex,
      required int endIndex}) {
    if (subject != null) {
      if (subject.isEmpty) {
        return '********';
      }
      return subject.replaceRange(
          startIndex, endIndex, "*" * (endIndex - startIndex));
    }

    return '';
  }

  //returns user's initials
  static String getNameInitials(
      {required String? firstName, required String? lastName}) {
    String firstInitial = '';
    String lastInitial = '';
    if (firstName != null && firstName.isNotEmpty) {
      firstInitial = firstName[0].toUpperCase();
    }
    if (lastName != null && lastName.isNotEmpty) {
      lastInitial = lastName[0].toUpperCase();
    }
    final result = '$firstInitial$lastInitial';
    return result.trim();
  }

  //formats saved user login phone number
  static String formatSavedUserPhoneNumber({required String phoneNumber}) {
    if (phoneNumber.isEmpty) return 'N/A';

    // Remove the '+234' prefix if it exists
    if (phoneNumber.startsWith('+234')) {
      phoneNumber = phoneNumber.substring(4);
    }

    // Remove the '234' prefix if it exists
    if (phoneNumber.startsWith('234')) {
      phoneNumber = phoneNumber.substring(3);
    }

    // Remove leading zero if it exists after removing '+234'
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    }

    // Proceed with formatting
    if (phoneNumber.length < 4) {
      return phoneNumber;
    }

    // first 3 characters
    String part1 = phoneNumber.substring(0, 3);
    // next 3 characters
    String part2 = phoneNumber.length > 6
        ? phoneNumber.substring(3, 6)
        : phoneNumber.substring(3);
    // remaining characters
    String part3 = phoneNumber.length > 6 ? phoneNumber.substring(6) : '';

    return '$part1 $part2 $part3'.trim();
  }

  //capitalize and return first letter of a string
  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase();
  }

    //capitalize word of a string
  static String capitalizeWord(String input) {
    if (input.isEmpty) return input;
    return "${capitalizeFirstLetter(input)}${input.substring(1)}";
  }

  //capitalize and return first letter of middle and last name
  static String middleAndLastNameInitials(String middleName, String lastName) {
    if(middleName.isEmpty && lastName.isEmpty){
      return '';
    }
    if (middleName.isEmpty) {
      return lastName[0].toUpperCase();
    }
    return "${middleName[0].toUpperCase()}.${lastName[0].toUpperCase()}";
  }

  //returns the first 2 characters of a string
  static String getFirstTwoLetters({required String? input}) {
    if (input == null || input.isEmpty) {
      return '';
    }
    if (input.length < 2) {
      return input[0].toUpperCase();
    }
    return input.substring(0, 2).toUpperCase();
  }

  //removes special Character from String and returns double
  static formatToDouble({String? value, bool returnInt = false}) {
    try {
      String? formattedString = value?.replaceAll(RegExp(r"[^\d.]"), '');
      double realValue = double.tryParse(formattedString ?? '0') ?? 0;
      //print('val to be returned:::$realValue >>>> ${realValue.toInt()}');
      if (returnInt) {
        return realValue.toInt();
      }
      return realValue;
    } catch (e) {
      if (returnInt) {
        return 0;
      }
      return 0.0;
    }
  }

  //returns date filter parameter
  static String? returnDateFilter(
      {required String? filterOption, bool isPriceSorting = false}) {
    if (filterOption == null) {
      return null;
    }

    switch (filterOption.toLowerCase()) {
      case 'today':
        return '1day';
      case 'yesterday':
        return '2days';
      case '3 days ago':
        return '3days';
      case '7 days ago':
        return '7days';
      case 'price: highest to lowest':
        if (!isPriceSorting) {
          return '';
        }
        return 'price_descending';
      case 'price: lowest to highest':
        if (!isPriceSorting) {
          return '';
        }
        return 'price_ascending';
      default:
        return '';
    }
  }

  //returns filter label
  static String returnLabel(
      {required String? dateFilter,
      required String? startDate,
      required String? endDate}) {
    print('date filter:::$dateFilter>>>');
    print('staet:::$startDate>>>');
    print('end:::$endDate>>>');

    if (dateFilter != null) {
      return dateFilter;
    }

    if (startDate != null && endDate != null) {
      return "$startDate to $endDate";
    }

    return '';
  }

  //returns filter value
  static String? returnFilterOption(
      {required String? label,
      bool isDateRange = false,
      bool isEndDate = false}) {
    if (label == null) {
      return null;
    }

    if ((label.toLowerCase() == 'today' ||
            label.toLowerCase() == 'yesterday' ||
            label.toLowerCase().contains('ago') ||
            label.toLowerCase().contains('price')) &&
        (isDateRange == false)) {
      print('should enter here>>>>>$label>>>>>${!isDateRange}');
      return label;
    }

    if (label.contains("-") && isDateRange) {
      List<String> dates = label.split('to').map((s) => s.trim()).toList();
      if (dates.length != 2) return null;

      if (isEndDate) {
        return dates[1];
      }

      return dates[0];
    }

    return null;
  }

  ///url launcher
  static launchIt({String? url}) async {
    if (await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  //frequency type list
  static List<String> frequencies = [
    'Daily',
    'Weekly',
    'Monthly',
  ];

  //days of the week list
  static List<String> daysOfTheWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

//  temp -> from backend
  static List<String> loanCollectionReasons = [
    'Emergency Payment',
    'Accommodation',
    'School Fees Payment',
    'Business',
    'Medical',
  ];

  //days of the month list
  static List<String> daysOfTheMonth() {
    return List<String>.generate(31, (index) {
      final day = index + 1;
      if (day % 10 == 1 && day != 11) {
        return '${day}st';
      } else if (day % 10 == 2 && day != 12) {
        return '${day}nd';
      } else if (day % 10 == 3 && day != 13) {
        return '${day}rd';
      } else {
        return '${day}th';
      }
    });
  }

  //masks email address
  static String maskEmail({required String email}) {
    if (email.isNotEmpty) {
      //Find the index of '@' symbol
      int atIndex = email.indexOf('@');

      //If '@' is not found or it's too close to the beginning/end, return unchanged
      if (atIndex <= 2 || atIndex >= email.length - 3) {
        return email;
      }

      //Get the portion of the email that needs to be masked
      String mask = email.substring(2, atIndex - 1);

      //Create the masked email by replacing characters with '*'
      String maskedEmail =
          email.replaceRange(2, atIndex - 1, '*' * mask.length);

      return maskedEmail;
    }

    return email;
  }




  static String statusText({required String? status}) {
    if (status == null) return '';
    switch (status.toLowerCase()) {
      case 'closed':
        return 'Completed';
      default:
        return status.isEmpty ? 'N/A' : status;
    }
  }

  static List<String> sortOptions = [
    'Ascending Order (A-Z)',
    'Descending order  (Z-A)'
  ];

  static List<String> electionStatus = ['New', 'Completed', 'Ongoing'];
  static List<String> eventType = ['Physical', 'Virtual'];
  static List<String> eventStatus = ['New', 'Sold Out', 'Trending', 'Postponed', 'Cancelled'];

  /// takes in start and end date and returns a [String] in format "Month day - Month day, Year"
  static String formatDateRange(DateTime startDate, DateTime endDate) {
    // List of month names
    final List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];

    // Get month and day for both dates
    String startMonth = months[startDate.month - 1];
    String endMonth = months[endDate.month - 1];
    int startDay = startDate.day;
    int endDay = endDate.day;

    // If the dates are in the same year, only show the year once at the end
    if (startDate.year == endDate.year) {
      return '$startMonth $startDay - $endMonth $endDay, ${startDate.year}';
    }

    // If different years, show both years
    return '$startMonth $startDay, ${startDate.year} - $endMonth $endDay, ${endDate.year}';
  }

  static List<String> parseStringToList(String? input) {
    if (input == null || input.trim().isEmpty) {
      return []; // Return an empty list if input is null or empty
    }

    return input
        .split('|')
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty) // Filter out any empty URLs
        .toList();
  }

  //returns a grouped list ot type T(any object)
  static List<GroupedList<T>> groupList<T>(
      List<T> list,
      DateTime? Function(T item) dateSelector, {
        bool sortDescendingDate = true,
      }) {
    final Map<DateTime, List<T>> buckets = {};

    for (final item in list) {
      final raw = dateSelector(item) ?? DateTime.now();
      final key = DateTime(raw.year, raw.month, raw.day);
      buckets.putIfAbsent(key, () => []).add(item);
    }

    final grouped = buckets.entries
        .map((e) => GroupedList<T>(date: e.key, items: e.value))
        .toList();

    if (sortDescendingDate) {
      grouped.sort((a, b) => b.date.compareTo(a.date));
    }

    return grouped;
  }

  //manipulates string
  static String removeLeadingNegativeSign(String value) {
    if (value.startsWith('-')) {
      return value.substring(1);
    }
    return value;
  }

}
