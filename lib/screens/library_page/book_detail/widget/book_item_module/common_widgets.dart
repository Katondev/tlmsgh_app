import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/drawer/drawer_cnt.dart';
import 'package:katon/widgets/pdf_view/pdf_view_page.dart';

import '../../../../home_page.dart';

class ReadFromLibraryButton extends StatelessWidget {
  ReadFromLibraryButton({Key? key}) : super(key: key);
  final drawerCnt = Get.put(DrawerCnt());

  @override
  Widget build(BuildContext context) {
    return LargeButton(
      onPressed: () async {
        drawerCnt.index.value = AppPreference().isTeacherLogin ? 9 : 11;
        //navigatorKey.currentState?.pushNamed(RoutesConst.myLibrary);
        navigatorKey.currentState?.pushNamed(RoutesConst.myLibrary,
            arguments:
                StudentRouteArguments().getArgument(RoutesConst.myLibrary));

        // Navigator.of(context).pop();
        // navigatorKey.currentState?.pop();
        // Get.off(MyLibraryPage(
        //     arguments:
        //         StudentRouteArguments().getArgument(RoutesConst.myLibrary)));
      },
      color: AppColors.nevYBlue,
      height: 40,
      width: 141,
      child: Text(
        "read_from_library".tr,
        textAlign: TextAlign.center,
        style: FontStyleUtilities.t2(
          fontWeight: FWT.medium,
          fontColor: AppColors.white,
        ).copyWith(overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

class AddToLibraryButton extends StatelessWidget {
  final BookDetailsM book;

  AddToLibraryButton({Key? key, required this.book}) : super(key: key);

  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 141,
      child: LargeButton(
          onPressed: () => cnt.onAddToLibraryClick(book),
          color: AppColors.nevYBlue,
          height: 40,
          width: 141,
          child: Text("add_to_library".tr,
              textAlign: TextAlign.center,
              style: FontStyleUtilities.t2(
                      fontWeight: FWT.medium, fontColor: AppColors.white)
                  .copyWith(overflow: TextOverflow.ellipsis))),
    );
  }
}

class PreviewPdfButton extends StatelessWidget {
  final BookDetailsM book;

  const PreviewPdfButton({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LargeButton(
            onPressed: () async {
              Get.to(() => PDFViewPage(
                    filename: book.bkPdf ?? "",
                    isFrom: true,
                  ));
            },
            color: AppColors.lightGreen,
            height: 35,
            width: 141,
            child: Text("preview_pdf".tr,
                style: FontStyleUtilities.t2(
                    fontWeight: FWT.medium, fontColor: AppColors.white))),
        w10,
      ],
    );
  }
}

class BookGenreText extends StatelessWidget {
  final BookDetailsM book;

  const BookGenreText({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Translator().translate("${"genre".tr} ${book.bkGenre}"),
        builder: (context, snapshot) {
          return Text(
            snapshot.hasData
                ? "${snapshot.data}".replaceAll("[", "").replaceAll("]", "")
                : "${book.bkGenre}".replaceAll("[", "").replaceAll("]", ""),
            style: FontStyleUtilities.h6(fontColor: AppColors.grey500)
                .copyWith(overflow: TextOverflow.visible),
            maxLines: 3,
          );
        });
  }
}
