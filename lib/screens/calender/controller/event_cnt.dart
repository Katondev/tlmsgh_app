import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/event_model.dart';
import 'package:katon/models/meeting_model.dart';
import 'package:katon/services/auth_service.dart';
import 'package:katon/utils/config.dart';

class EventsCnt extends GetxController {
  RxBool isLoading = false.obs;
  EventResponseModel? eventResponseModel;
  List<Events>? events = [];
  RxBool noInternet = false.obs;

  Future getAllEvents() async {
    try {
      noInternet.value = false;
      isLoading.value = true;
      await AuthServices().getEventsDetail().then((value) {
        eventResponseModel = value;
        events = value?.data?.events;
      });
      isLoading.value = false;
    } catch (e) {
      if (e.toString() == "No Internet") {
        noInternet.value = true;
      }
      isLoading.value = false;
    }
  }

  List<Meeting> getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    events?.forEach((element) {
      final DateTime startTime =
          FormatDate.stringToDate(element.ecEventDate.toString());
      final DateTime endTime = startTime.add(const Duration(hours: 12));
      meetings.add(Meeting(element.ecEventTitle.toString(), startTime, endTime,
          const Color(0xFF0F8644), false));
    });
    return meetings;
  }
}
