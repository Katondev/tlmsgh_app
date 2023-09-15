import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/home/widget/study_material/study_material.dart';
import 'package:katon/screens/home/widget/news_item/news_item.dart';
import 'package:katon/screens/home/widget/notification_item.dart';
import 'package:katon/screens/home/widget/student_info/student_info.dart';
import 'package:katon/screens/message/message_cnt.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/loader.dart';

import '../home_page.dart';

class DashBoardMobile extends StatelessWidget {
  final Arguments arguments;

  DashBoardMobile({Key? key, required this.arguments}) : super(key: key);
  final cnt = Get.put(AppBarCnt());
  final messageCnt = Get.put(MessageCnt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: endDrawerMobile(),
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      backgroundColor: Colors.transparent,
      appBar: CommonAppbarMobile(title: arguments.title),
      body: Padding(
        padding: all10,
        child: Obx(
          () => cnt.isLoading.value
              ? Loader(message: "loading".tr)
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StudentInfo(
                          schoolRollNO: "${"roll_no".tr} ${cnt.student.stId}",
                          classDetails: "primary".tr,
                          schoolAddress: "address".tr,
                          schoolContact: "+244 545 6556",
                          schoolImage:
                              "https://static.vecteezy.com/system/resources/previews/006/174/322/original/academy-badge-logo-free-vector.jpg",
                          schoolName: "high_school".tr,
                          studentImage: cnt.student.stProfilePic == ""
                              ? 'https://img.freepik.com/free-photo/young-attractive-smiling-student-showing-thumb-up-outdoors-campus-university_8353-6394.jpg?w=2000'
                              : ApiRoutes.imageURL +
                                  cnt.student.stProfilePic.toString(),
                          studentName: cnt.student.stFullName ?? ""),
                      h24,
                      const NewsItem(),
                      h20,
                      const NotificationWidget(),
                      h20,
                      StudyMaterial(
                        bookName: "beginner_english".tr,
                        bookPrice: 15,
                        isFree: false,
                        rating: 3,
                        image:
                            "https://www.nicepng.com/png/detail/762-7624714_7-steps-to-achieve-your-goals-3d-book.png",
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
