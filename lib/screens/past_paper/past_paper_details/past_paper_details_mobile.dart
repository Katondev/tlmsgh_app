import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/screens/past_paper/past_paper_details/widgets/information_container.dart';
import 'package:katon/screens/past_paper/past_paper_details/widgets/question_container.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';

class PastPaperDetailsPageMobile extends StatelessWidget {
  final Arguments? arguments;
  const PastPaperDetailsPageMobile({Key? key, this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CommonAppbarMobile(title: arguments?.title ?? ""),
      // endDrawer: endDrawerMobile(),
      body: Consumer<PastPaperProvider>(
        builder: (context, value, child) => value.value
            ? Loader(message: "loading_wait".tr)
            : value.connection
                ? NoInternet(
                    onTap: () =>
                        value.getPastPaperDetails(paperID: value.PaperId))
                : Padding(
                    padding: all14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QuestionContainer(),
                        h12,
                        //InformationContainer(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
