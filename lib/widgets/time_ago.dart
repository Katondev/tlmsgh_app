import 'package:get/get.dart';

String timeAgoSinceDate({bool numericDates = true}) {
  DateTime date = DateTime.parse('2022-08-29 20:18:04Z');
  final date2 = DateTime.now().toLocal();
  final difference = date2.difference(date);

  if (difference.inSeconds < 5) {
    return 'just_now'.tr;
  } else if (difference.inSeconds <= 60) {
    return '${difference.inSeconds} ${"seconds_ago".tr}';
  } else if (difference.inMinutes <= 1) {
    return (numericDates) ? '1_minute_ago'.tr : 'a_minute_ago'.tr;
  } else if (difference.inMinutes <= 60) {
    return '${difference.inMinutes} ${"minute_ago".tr}';
  } else if (difference.inHours <= 1) {
    return (numericDates) ? '1_hour_ago'.tr : 'an_hour_ago'.tr;
  } else if (difference.inHours <= 60) {
    return '${difference.inHours} ${"hours_ago".tr}';
  } else if (difference.inDays <= 1) {
    return (numericDates) ? '1_day_ago'.tr : 'yesterdays'.tr;
  } else if (difference.inDays <= 6) {
    return '${difference.inDays} ${"days_ago".tr}';
  } else if ((difference.inDays / 7).ceil() <= 1) {
    return (numericDates) ? '1_week_ago'.tr : 'last_week'.tr;
  } else if ((difference.inDays / 7).ceil() <= 4) {
    return '${(difference.inDays / 7).ceil()} ${"week_ago".tr}';
  } else if ((difference.inDays / 30).ceil() <= 1) {
    return (numericDates) ? '1_month_ago'.tr : 'Last_month'.tr;
  } else if ((difference.inDays / 30).ceil() <= 30) {
    return '${(difference.inDays / 30).ceil()} ${"months_ago".tr}';
  } else if ((difference.inDays / 365).ceil() <= 1) {
    return (numericDates) ? '1_year_ago'.tr : 'Last_year'.tr;
  }
  return '${(difference.inDays / 365).floor()} ${"year_ago".tr}';
}
