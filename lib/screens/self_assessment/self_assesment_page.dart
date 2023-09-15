import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/screens/past_paper/past_paper_mobile.dart';
import 'package:katon/screens/past_paper/past_paper_tablet.dart';
import 'package:katon/screens/self_assessment/self_assesment_controller.dart';
import 'package:katon/screens/self_assessment/self_assesment_mobile.dart';
import 'package:katon/screens/self_assessment/self_assesment_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import 'package:katon/utils/config.dart';

class SelfAssessmentPage extends StatefulWidget {
  final Arguments arguments;

  const SelfAssessmentPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<SelfAssessmentPage> createState() => _SelfAssessmentPageState();
}

class _SelfAssessmentPageState extends State<SelfAssessmentPage> {
  SelfAssessmentController? selfAssessmentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selfAssessmentController =
        Provider.of<SelfAssessmentController>(context, listen: false);
    init();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await selfAssessmentController?.getAllSelfAssessmentList();
      await selfAssessmentController?.getAllCategoryInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Material(
    //   color: AppColors.white,
    //   child: Consumer<SelfAssessmentController>(
    //     builder: (context, value, child) => CommonContainer(
    //         child:  SelfAssessmentMobile(arguments: widget.arguments)),
    //   ),
    // );
    return Responsive.isMobile(context)
        ? SelfAssessmentMobile(
            arguments: widget.arguments,
          )
        : SelfAssessmentTablet(
            arguments: widget.arguments,
          );
  }
}
