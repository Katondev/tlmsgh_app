import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/screens/past_paper/past_paper_details/past_paper_details_mobile.dart';
import 'package:katon/screens/past_paper/past_paper_details/past_paper_details_tablet.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class PastPaperDetails extends StatefulWidget {
  const PastPaperDetails({Key? key}) : super(key: key);

  @override
  State<PastPaperDetails> createState() => _PastPaperDetailsState();
}

class _PastPaperDetailsState extends State<PastPaperDetails> {
  Arguments? arguments;
  PastPaperProvider? paperProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paperProvider = Provider.of<PastPaperProvider>(context, listen: false);
    init();
  }

  init() async {
    await paperProvider?.getPastPaperDetails(paperID: paperProvider?.PaperId);
  }

  @override
  Widget build(BuildContext context) {
    // print("paperProvider?.PaperId${paperProvider?.PaperId}");
    return Material(
      color: AppColors.white,
      child: CommonContainer(
          child: Responsive.isMobile(context)
              ? PastPaperDetailsPageMobile(
                  arguments: StudentRouteArguments()
                      .getArgument(RoutesConst.pastPaperDetails))
              : PastPaperDetailsPageTablet(
                  arguments: StudentRouteArguments()
                      .getArgument(RoutesConst.pastPaperDetails))),
    );
  }
}
