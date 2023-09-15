import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:katon/models/notification_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/notification/widgets/notification_pdf_view.dart';
import 'package:katon/services/auth_service.dart';
import 'package:katon/utils/date_format.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/download_file.dart';
import 'package:path_provider/path_provider.dart';

class NotificationCnt extends GetxController {
  RxBool isLoading = false.obs;
  RxBool onDownload = false.obs;
  RxBool onError = false.obs;
  RxBool connection = false.obs;
  int ntId = 0;
  List<Notifications>? notification = <Notifications>[];
  RxList<String> monthList = const [
    "Select Month",
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ].obs;
  RxString selectedMonth = "${FormatDate.fullMonth("${DateTime.now()}")}".obs;

  Future getAllNotification() async {
    isLoading.value = true;
    connection.value = true;
    try {
      await AuthServices().getNotificationDetail().then((value) async {
        notification = value?.data?.notification;
        log("notification data-----${value?.data?.notification.toString()}");
        if (notification != []) {
          final String notificationEncodedData =
              Notifications.encode(notification ?? []);
          await AppPreference().setString(
              PreferencesKey.notificationData, notificationEncodedData);
        }
        checkPdfIsAvailable();
        print("Notification res code${value?.status}");
      });
      isLoading.value = false;
      onError.value = false;
    } catch (e) {
      if (e.toString() == "No Internet") {
        connection.value = false;
        final String notificationData =
            AppPreference().getString(PreferencesKey.notificationData);
        // notification = Notifications.decode(notificationData);
        await checkPdfIsAvailable();
      } else {
        onError.value = true;
      }
      isLoading.value = false;
    }
  }

  Future? openPdf(String filename) {
    return Get.to(
      () => NotificationPdfView(filename: filename),
    );
  }

  Future downloadPdf(int index) async {
    notification?[index].inProgress?.value = true;
    await DownloadGeoJsonFile().downloadFile(
      url: "${ApiRoutes.imageURL}${notification?[index].ntFile}",
      filename: notification![index].ntFile.toString(),
      uploadprogress: (prg) {
        var progress = double.parse(prg.toString());
        log(progress.toString());
      },
    );
    notification?[index].isDownloading?.value = true;
    ntId = notification![index].ntId!.toInt();
    notification?[index].inProgress?.value = false;
  }

  Future checkPdfIsAvailable() async {
    notification?.forEach(
      (element) async {
        Directory dir = await getApplicationDocumentsDirectory();
        var path = '${dir.path}/${element.ntFile}';
        final savedDir1 = File(path);
        element.isDownloading = savedDir1.existsSync().obs;
      },
    );
  }
}
