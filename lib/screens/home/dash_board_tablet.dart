import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/home/widget/study_material/study_material.dart';
import 'package:katon/screens/home/widget/news_item/news_item.dart';
import 'package:katon/screens/home/widget/notification_item.dart';
import 'package:katon/screens/home/widget/student_info/student_info.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/loader.dart';

class DashBoardTablet extends StatelessWidget {
  final Arguments arguments;

  DashBoardTablet({Key? key, required this.arguments}) : super(key: key);
  final cnt = Get.put(AppBarCnt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: commonAppBar(
          title: arguments.title, description: arguments.description),
      // endDrawer: endDrawer(),
      body: Center(
        child: Obx(
          () => cnt.isLoading.value
              ? Loader(message: "loading".tr)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StudentInfo(
                                    schoolRollNO:
                                        "${"roll_no".tr} ${cnt.student.stId}",
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
                              ],
                            ),
                            w20,
                            const NotificationWidget(),
                          ],
                        ),
                      ),
                      h20,
                      StudyMaterial(
                          bookName: "beginner_english".tr,
                          bookPrice: 15,
                          isFree: false,
                          rating: 3,
                          image:
                              "https://www.nicepng.com/png/detail/762-7624714_7-steps-to-achieve-your-goals-3d-book.png")
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
