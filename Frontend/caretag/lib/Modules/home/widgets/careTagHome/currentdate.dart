import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String getCurrentDate(DateTime date) {
  int day = date.day;

  String suffix = 'th';
  if (!(day >= 11 && day <= 13)) {
    switch (day % 10) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
    }
  }

  String monthYear = DateFormat(' MMM yyyy').format(date);

  return '$day$suffix$monthYear';
}
