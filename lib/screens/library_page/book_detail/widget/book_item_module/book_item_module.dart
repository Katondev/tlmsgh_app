import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/screens/library_page/book_detail/widget/book_item_module/book_item_module_mobile.dart';
import 'package:katon/screens/library_page/book_detail/widget/book_item_module/book_item_module_tablet.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/widgets/drawer/drawer_cnt.dart';
import 'package:katon/widgets/responsive.dart';

class BookItemModule extends StatefulWidget {
  final BookDetailsM book;

  const BookItemModule({Key? key, required this.book}) : super(key: key);

  @override
  State<BookItemModule> createState() => _BookItemModuleState();
}

class _BookItemModuleState extends State<BookItemModule> {
  final drawerCnt = Get.put(DrawerCnt());
  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return BookItemModuleMobile(book: widget.book);
    } else {
      return BookItemModuleTablet(book: widget.book);
    }
  }
}
