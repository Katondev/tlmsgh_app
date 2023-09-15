import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import '../../../components/app_text_style.dart';
import '../../../utils/constants.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_internet.dart';
import 'controller/practice_prv.dart';

class AssignmentTestScreen extends StatefulWidget {
  final List<dynamic> args;
  final String title;
  const AssignmentTestScreen(
      {Key? key, required this.args, required this.title})
      : super(key: key);

  @override
  State<AssignmentTestScreen> createState() => _AssignmentTestScreenState();
}

class _AssignmentTestScreenState extends State<AssignmentTestScreen> {
  PracticePrv? eLearningPrv;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eLearningPrv = Provider.of<PracticePrv>(context, listen: false);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailProvider>(builder: (context, value, child) {
      // bookId = value.books?.bkId;
      return Scaffold(
        // endDrawer: endDrawer(),
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Consumer<PracticePrv>(builder: (context, ePrv, child) {
            return Container(
              padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
              child: ePrv.value
                  ? Loader(message: "loading_wait".tr)
                  : ePrv.connection
                      ? NoInternet(
                          onTap: () {},
                          // onTap: () => ePrv.resetOnTap(),
                        )
                      :
                      // (ePrv.books.isEmpty)
                      //     ? NoDataFound(message: "no_book_found".tr)
                      //     :
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // log("message");
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 20,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                customWidth(15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.args[0]["title"]}",
                                      style: AppTextStyle.normalBold28.copyWith(
                                        color: AppColors.black,
                                      ),
                                    ),
                                    // h4,
                                    Text(
                                      "${widget.args[1]}",
                                      style:
                                          AppTextStyle.normalRegular16.copyWith(
                                        color: AppColors.textgrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            customHeight(15),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: AppColors.boxgreyColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.fromLTRB(55, 50, 55, 85),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.title}",
                                    style: AppTextStyle.normalBold28.copyWith(
                                      color: AppColors.primaryBlack,
                                    ),
                                  ),
                                  customHeight(50),
                                  questionList(),
                                ],
                              ),
                            ),
                          ],
                        ),
            );
          }),
        ),
      );
    });
  }
}

Widget questionList() {
  return Padding(
    padding: const EdgeInsets.only(left: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("1. Which of the following sets is well defined?"),
        h10,
        Row(
          children: [
            Radio(
              value: false,
              groupValue: "1",
              onChanged: (value) {},
              overlayColor: MaterialStateProperty.all(AppColors.gray909090),
              visualDensity: VisualDensity.comfortable,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            w10,
            Column(
              children: [
                Text("{Man, Kofi, Red, 14}"),
                h4,
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
