import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/practice/practice_subject/practice_subject_mobile.dart';
import 'package:katon/screens/practice/practice_subject/practice_subject_tablet.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

import '../../self_assessment/self_assesment_controller.dart';
import '../controller/practice_prv.dart';

class PracticeSubjectPage extends StatefulWidget {
  final Arguments arguments;

  const PracticeSubjectPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeSubjectPage> createState() => PracticeSubjectPageState();
}

class PracticeSubjectPageState extends State<PracticeSubjectPage> {
  PracticePrv? practicePrv;
   SelfAssessmentController? ePev;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      practicePrv = Provider.of<PracticePrv>(context, listen: false);
      ePev = Provider.of<SelfAssessmentController>(context,listen: false);
      init();
    });
  }

  init() async {
      ePev!.getSelectPapar();
    if (AppPreference().getString(PreferencesKey.uType) == "Student") {
      if (practicePrv?.selectedPractice == 0) {
      practicePrv?.getAssessmentSubject();
       practicePrv?.practiceSubjectList.clear();
      } else if (practicePrv?.selectedPractice == 1) {
        practicePrv?.getpastAssessmentSubject();
        practicePrv?.practiceSubjectList.clear();
      } else if (practicePrv?.selectedPractice == 2) {
        practicePrv?.getSelfAssessmentSubject();
           practicePrv?.practiceSubjectList.clear();
      }
      practicePrv?.notifyListeners();
    } else {
      if (practicePrv?.selectedPractice == 0) {
       practicePrv?.getAssessmentSubject();
           practicePrv?.practiceSubjectList.clear();
      
      } else if (practicePrv?.selectedPractice == 1) {
       practicePrv?.getpastAssessmentSubject();
         practicePrv?.practiceSubjectList.clear();
      }
      practicePrv?.notifyListeners();
    
    }
    // await practicePrv?.getSelfAssessmentSubject();
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return PracticeSubjectPagePhone(arguments: widget.arguments);
    } else {
      return PracticeSubjectPageTablet(arguments: widget.arguments);
    }
  }
}
