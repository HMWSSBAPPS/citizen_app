import 'package:intl/intl.dart';

extension StringExtension on String {
  /// formatedTime Output:10:33.
  String get formatedTime =>
      DateFormat("HH:mm").format(DateTime.parse(this)).toString();

  /// dmyFormatedDate Output: 02-04-1421.
  String get dmyFormatedDate =>
      DateFormat("dd-MMM-yyyy").format(DateTime.parse(this)).toString();
  String get dmyFormattedDateTime {
    try {
      // Try parsing both known formats
      DateTime date;
      if (contains('-') && contains(':') && contains(' ')) {
        if (this.contains(RegExp(r'[A-Za-z]{3}'))) {
          // Format like: "06-APR-25 17:27"
          date = DateFormat("dd-MMM-yy HH:mm").parse(this);
        } else {
          // Format like: "06-04-2025 16:51:00"
          date = DateFormat("dd-MM-yyyy HH:mm:ss").parse(this);
        }
        return DateFormat("dd-MMM-yyyy hh:mm a").format(date);
      } else {
        return this;
      }
    } catch (_) {
      return this;
    }
  }

  ///dMFormatedDate Output: 02-04.
  String get dMFormatedDate =>
      DateFormat("dd-MMM").format(DateTime.parse(this)).toString();
}

extension DateTimeExtension on DateTime? {
  /// Returns `true` if the date is today

  bool? isAfterOrEqualTo(DateTime dateTime) {
    final DateTime? date = this;
    if (date != null) {
      final bool isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final DateTime? date = this;
    if (date != null) {
      final bool isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool? isBetween(DateTime fromDateTime, DateTime toDateTime) {
    final DateTime? date = this;
    if (date != null) {
      final bool isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
      final bool isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
      return isAfter && isBefore;
    }
    return null;
  }
}
