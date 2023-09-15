import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/my_library/my_library_page_mobile.dart';
import 'package:katon/screens/my_library/my_library_page_tablet.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/responsive.dart';

class MyLibraryPage extends StatefulWidget {
  final Arguments? arguments;

  const MyLibraryPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<MyLibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  final cnt = Get.put(ELearningCnt());

  @override
  void initState() {
    init();
    super.initState();

  }

  Future<void> init() async {
     cnt.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: onlyTopBottomLeft42,
            color: AppColors.backGroundColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.grey500,
                blurRadius: 02,
                offset: Offset(
                  2,
                  0,
                ),
              )
            ],
          ),
          child: Responsive.isMobile(context)
              ? MyLibraryPageMobile(arguments: widget.arguments)
              : MyLibraryPageTablet(arguments: widget.arguments),
        ),
      ),
    );
  }
}
