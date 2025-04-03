import 'package:intl/intl.dart';

extension StringExtension on String {
  /// formatedTime Output:10:33.
  String get formatedTime =>
      DateFormat("HH:mm").format(DateTime.parse(this)).toString();

  /// dmyFormatedDate Output: 02-04-1421.
  String get dmyFormatedDate =>
      DateFormat("dd-MMM-yyyy").format(DateTime.parse(this)).toString();

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
