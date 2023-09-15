import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/screens/library_page/book_detail/widget/similar_book_module/similar_book_module_mobile.dart';
import 'package:katon/screens/library_page/book_detail/widget/similar_book_module/similar_book_module_tablet.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/widgets/responsive.dart';

class SimilarBookModule extends StatelessWidget {
  final List<BookDetailsM>? bookList;
  final Function? onDetailClick;
  final Widget? child;
  final bool? isLibrary;
  SimilarBookModule(
      {Key? key, this.bookList, this.child, this.isLibrary, this.onDetailClick})
      : super(key: key);

  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? SimilarBookModuleMobile(
            bookList: bookList,
            isLibrary: isLibrary,
            onDetailClick: onDetailClick,
          )
        : SimilarBookModuleTablet(
            bookList: bookList,
            isLibrary: isLibrary,
            onDetailClick: onDetailClick);
  }
}
