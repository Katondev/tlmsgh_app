import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/training/training_details/training_details_page_mobile.dart';
import 'package:katon/screens/training/training_details/training_details_page_tablet.dart';
import 'package:provider/provider.dart';
import '../../../widgets/responsive.dart';
import '../controller/training_prv.dart';

class TrainingDetailsPage extends StatefulWidget {
  final Arguments arguments;
  const TrainingDetailsPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<TrainingDetailsPage> createState() => _TrainingDetailsPageState();
}

class _TrainingDetailsPageState extends State<TrainingDetailsPage>
    with WidgetsBindingObserver {
  TrainingProvider? pro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pro = Provider.of<TrainingProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    await pro?.getTrainingDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobilenew(context)) {
      return TrainingDetailsMobile(
        arguments: widget.arguments,
      );
    } else {
      return TrainingDetailsTablet(
        arguments: widget.arguments,
      );
    }
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //       color: AppColors.white,
  //       child: CommonContainer(
  //           child: Scaffold(
  //         backgroundColor: Colors.transparent,
  //         appBar: commonAppBar(
  //             title: StudentRouteArguments().getArgument(RoutesConst.trainingDetails).title),
  //         body: Column(children: [
  //           CustomScrollView(
  //             slivers: [
  //               SliverAppBar(
  //                 flexibleSpace: FlexibleSpaceBar(
  //                   background: Image.network(""),
  //                 ),
  //               )
  //             ],
  //           )
  //         ]),
  //       )));
  // }
}
