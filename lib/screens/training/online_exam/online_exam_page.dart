import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';
import 'online_exam_mobile.dart';
import 'online_exam_tablet.dart';

class OnlineExamPage extends StatefulWidget {
  // final Assignment assignment;
  final Arguments arguments;

  const OnlineExamPage({super.key, required this.arguments});

  @override
  _OnlineExamPageState createState() => new _OnlineExamPageState();
}

class _OnlineExamPageState extends State<OnlineExamPage>
    with WidgetsBindingObserver {
  TrainingProvider? trainingPrv;
  // AssignmentQSetModel? questionDetail;
  

  @override
  void initState() {
    super.initState();
    trainingPrv = Provider.of<TrainingProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((val) {
      getData();
    });
  }

  getData() async {
    // assignmentController!.index = 0;
    // assignmentController!.answerSubmitServer.clear();
    await trainingPrv!.getExamQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return (Responsive.isMobilenew(context))
        ? OnlineExamMobile()
        : OnlineExamTablet();
  }
}
