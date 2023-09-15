import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/screens/training/training_page_mobile.dart';
import 'package:katon/screens/training/training_page_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class TrainingPage extends StatefulWidget {
  final Arguments arguments;
  const TrainingPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage>
    with WidgetsBindingObserver {
  TrainingProvider? trainingProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trainingProvider = Provider.of<TrainingProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() async {
    await trainingProvider?.getAllTrainings();
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return TrainingPageMobile(arguments: widget.arguments);
    } else {
      return TrainingPageTablet(arguments: widget.arguments);
    }
  }
}
