import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/library_page/book_detail/widget/book_item_module/common_widgets.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/my_library/library_book_detail/common_widgets.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/common_widgets.dart';
import 'package:katon/widgets/drawer/drawer_cnt.dart';
import 'package:katon/widgets/svgIcon.dart';

class BookItemModuleMobile extends StatelessWidget {
  final BookDetailsM book;

  BookItemModuleMobile({Key? key, required this.book}) : super(key: key);

  final drawerCnt = Get.put(DrawerCnt());
  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      h16,
      Padding(padding: l20, child: BookTitle(book: book)),
      h16,
      Container(
        // height: Get.height,
        margin: b10l10r10,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: cr24,
        ),
        child: Padding(
          padding: l15r15t25b10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: AppColors.white,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SvgIcon(Images.round2, height: 102, width: 244.31),
                        Positioned(
                          bottom: 10,
                          child: CachedNetworkImage(
                            height: 162,
                            width: 70,
                            imageUrl: "${ApiRoutes.imageURL}${book.bkPreview}",
                          ),
                        ),
                      ],
                    ),
                  ),
                  w20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: Get.width / 3,
                          child: BookGenreText(book: book)),
                      book.bkNoOfPages == null
                          ? SizedBox.shrink()
                          : SizedBox(
                              width: Get.width / 3,
                              child: Text(
                                "${"pages".tr} ${book.bkNoOfPages}",
                                style: FontStyleUtilities.h6(
                                        height: 0, fontColor: AppColors.grey500)
                                    .copyWith(
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                      h20,
                      RatingStars(width: 12.24, height: 12.48), //stars
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => cnt.valueChange.value
                        ? ReadFromLibraryButton()
                        : AddToLibraryButton(book: book),
                  ),
                ],
              ),
              h18,
              BookDescription(book: book),
              h18,
              DottedLine(width: 0.6, color: AppColors.primary),
              h26,
              Text(
                "reviews".tr,
                style: FontStyleUtilities.h6(
                  height: 0,
                  fontColor: AppColors.gray800,
                  fontWeight: FWT.medium,
                ),
              ),
              ReviewsList(),
            ],
          ),
        ),
      )
    ]);
  }
}
