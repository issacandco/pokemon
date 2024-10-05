import 'package:intl/intl.dart';

class DateTimeUtil {
  static const String basicDateFormat = 'dd-MMM-yyyy';
  static const String dateFormatWithoutDash = 'dd MMM yyyy';
  static const String weekOfDayFormat = 'E';
  static const String dayFormat = 'dd';
  static const String monthFormat = 'MMM';
  static const String dateTimeFormat = 'dd MMM, hh:mm a';
  static const String fullDateTimeFormat = 'dd-MMM-yyyy, hh:mm:ss a';
}

extension DateTimeExtension on DateTime {
  String dateFormat({String? format}) {
    try {
      return DateFormat(format ?? DateTimeUtil.basicDateFormat).format(this);
    } catch (e) {
      return toString();
    }
  }

  int getParsedMillisecondsDateTime() {
    return millisecondsSinceEpoch;
  }

  bool isSameDay(DateTime dateTime) {
    return year == dateTime.year && month == dateTime.month && day == dateTime.day;
  }

  bool isDayBefore(DateTime dateTime) {
    return isBefore(dateTime) && !isSameDay(dateTime);
  }

  bool isSameDayOrAfter({DateTime? dateTime}) {
    DateTime currentDateTime = dateTime ?? DateTime.now();
    return isSameDay(currentDateTime) || isAfter(currentDateTime);
  }

  bool isBeforeOrSameDay({DateTime? dateTime}) {
    DateTime currentDateTime = dateTime ?? DateTime.now();
    return isBefore(currentDateTime) || isSameDay(currentDateTime);
  }

  bool isBetween(int startDateTimeInt, int endDateTimeInt) {
    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startDateTimeInt);
    DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(endDateTimeInt);
    return isSameDayOrAfter(dateTime: startDateTime) && isBeforeOrSameDay(dateTime: endDateTime);
  }

  bool isBetweenDateTime(DateTime? startDateTime, DateTime? endDateTime) {
    if (startDateTime == null || endDateTime == null) return false;
    return isSameDayOrAfter(dateTime: startDateTime) && isBeforeOrSameDay(dateTime: endDateTime);
  }

  bool isSameMoment(DateTime dateTime) {
    return isAtSameMomentAs(dateTime);
  }

  bool isBeforeMoment(DateTime dateTime) {
    return isBefore(dateTime);
  }

  bool isAfterMoment(DateTime dateTime) {
    return isAfter(dateTime);
  }

  DateTime getDateTime({int? inputYear, int? inputMonth, int? inputDay}) {
    return DateTime(
      year + (inputYear ?? 0),
      month + (inputMonth ?? 0),
      day + (inputDay ?? 0),
    );
  }

  DateTime startOfDay() {
    return DateTime(year, month, day);
  }

  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  String timeAgo() {
    final Duration difference = DateTime.now().difference(this);
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat(DateTimeUtil.basicDateFormat).format(this);
    }
  }

  int getQuarter() {
    return ((month - 1) / 3).floor() + 1;
  }
}

extension DateTimeMillisecondsExtension on int {
  DateTime? parseDateTimeByMilliseconds() {
    try {
      return DateTime.fromMillisecondsSinceEpoch(this);
    } catch (e) {
      return null;
    }
  }

  String parseDateTimeByMillisecondsToString({String? format}) {
    try {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this);
      return DateFormat(format ?? DateTimeUtil.fullDateTimeFormat).format(dateTime);
    } catch (e) {
      return toString();
    }
  }

  String parseIntIntoMinutes() {
    return Duration(seconds: this).toString().split('.').first.padLeft(8, '0');
  }
}

extension StringDateTimeExtension on String {
  int parseStringDateTimeToMillSeconds() {
    try {
      String formattedDate = '${substring(0, 10)} ${substring(11)}';
      return DateTime.parse(formattedDate).toLocal().millisecondsSinceEpoch;
    } catch (e) {
      return 0;
    }
  }

  String parseStringToDateTimeString({String? format, bool isConvertToLocal = false}) {
    try {
      DateTime parsedDate = isConvertToLocal ? DateTime.parse(this).toLocal() : DateTime.parse(this);
      String dateString = DateFormat(format ?? DateTimeUtil.basicDateFormat).format(parsedDate);
      return dateString;
    } catch (e) {
      return this;
    }
  }

  String parseFormattedStringToDateTimeString(String formattedDate, {String? format}) {
    try {
      return DateFormat(format ?? DateTimeUtil.basicDateFormat).format(DateFormat(formattedDate).parse(this));
    } catch (e) {
      return this;
    }
  }

  DateTime parseStringToDateTime({bool isConvertToLocal = false}) {
    try {
      return isConvertToLocal ? DateTime.parse(this).toLocal() : DateTime.parse(this);
    } catch (e) {
      return DateTime.now();
    }
  }
}
