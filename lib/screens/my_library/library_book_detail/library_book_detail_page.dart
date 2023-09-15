import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/my_library/library_book_detail/library_book_detail_mobile.dart';
import 'package:katon/screens/my_library/library_book_detail/library_book_detail_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/utils/config.dart';

class LibraryBookDetailPage extends StatefulWidget {
  LibraryBookDetailPage({Key? key}) : super(key: key);

  @override
  State<LibraryBookDetailPage> createState() => _LibraryBookDetailPageState();
}

class _LibraryBookDetailPageState extends State<LibraryBookDetailPage> {
  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: CommonContainer(
          child: Responsive.isMobile(context)
              ? LibraryBookDetailPageMobile()
              : LibraryBookDetailPageTablet(),
        ),
      ),
    );
  }
}
