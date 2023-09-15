import 'dart:developer';

import 'package:get/get.dart';
import 'package:katon/models/message_model.dart';
import 'package:katon/services/auth_service.dart';
import 'package:katon/utils/config.dart';

class MessageCnt extends GetxController {
  RxBool isLoading = false.obs;
  RxInt messageCount = 0.obs;
  MessageResponseModel? messageResponseModel = MessageResponseModel();

  Future getAllMessage() async {
    try {
      isLoading.value = true;
      // log("school----${stSchool.toString()}");
      await AuthServices().getAllMessages().then((value) async {
        messageResponseModel = value;
        messageCount.value =
            messageResponseModel?.data?.sendMessage?.length ?? 0;
        log(messageResponseModel!.toJson().toString());
        await AppPreference().setString('isMessageRead', 'true');
        await AppPreference().setInt('isMessageRead', messageCount.value);
      });
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
