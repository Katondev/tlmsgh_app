
import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';
import '../../../teacher/drawer.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/drawer/drawer.dart';
import '../../../widgets/no_data_found.dart';
import '../../home_page.dart';

class LibraryPagePhone extends StatefulWidget {
  final Arguments arguments;

  const LibraryPagePhone({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<LibraryPagePhone> createState() => _LibraryPagePhoneState();
}

class _LibraryPagePhoneState extends State<LibraryPagePhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.boxgreyColor,
      resizeToAvoidBottomInset: false,
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      // endDrawer: endDrawer(),
      appBar: CommonAppbarMobile(title: widget.arguments.title),
      body: Consumer<ELearningProvider>(
        builder: (context, ePrv, child) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Practice",
                    //   style: AppTextStyle.normalBold28.copyWith(
                    //     color: AppColors.black,
                    //   ),
                    // ),
                    // h4,
                    Text(
                      "${widget.arguments.description}",
                      style: AppTextStyle.normalRegular14.copyWith(
                        color: AppColors.textgrey,
                      ),
                    ),
                  ],
                ),
                customHeight(15),
                Expanded(
                  child: (ePrv.practiceStudentList.isEmpty)
                      ? NoDataFound(message: "no_book_found".tr)
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            // crossAxisCount: 4,
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 200,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.95,
                          ),
                          itemBuilder: (context, i) {
                            var data = ePrv.practiceStudentList[i];
                            return GestureDetector(
                              onTap: () {
                                ePrv.selectedPractice = i;
                                 if(ePrv.selectedPractice == 0){
                                      ePrv.selectsubjectype = 'ebook';
                                    }else{
                                       ePrv.selectsubjectype = 'videos';
                                    }
                                navigatorKey.currentState!.pushNamed(
                                    RoutesConst.eLearningcard,
                                    arguments: data["title"]);
                                   
                              },
                              child: Container(
                                // height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.primaryWhite,
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.primaryBlack
                                              .withOpacity(.05),
                                          blurRadius: 12),
                                    ]),

                                child: Column(
                                  children: [
                                    // Text(
                                    //   "${data.ppTitle}",
                                    //   textAlign: TextAlign.center,
                                    //   maxLines: 2,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: AppTextStyle.normalBold20
                                    //       .copyWith(
                                    //     color: AppColors.primaryBlack,
                                    //   ),
                                    // ),
                                    // h20,
                                    Expanded(
                                      child: Container(
                                        width: Get.width,
                                        height: 100,
                                        padding: const EdgeInsets.all(40),
                                        child: Image.asset(
                                          data["image"],
                                          // height: 100,
                                        ),
                                      ),
                                    ),
                                    // h22,
                                    // const Spacer(),
                                    Container(
                                      width: Get.width,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        color: AppColors.boxgreyColor
                                            .withOpacity(.7),
                                      ),
                                      child: Text(
                                        data["title"],
                                        style: AppTextStyle.normalRegular16
                                            .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: ePrv.practiceStudentList.length,
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}