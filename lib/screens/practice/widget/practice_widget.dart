import 'package:flutter/material.dart';
import 'package:katon/models/assignment_model.dart';
import 'package:katon/screens/practice/widget/practice_item_mobile.dart';
import 'package:katon/screens/practice/widget/practice_item_tablet.dart';
import 'package:katon/widgets/responsive.dart';

class PracticeWidget extends StatelessWidget {
  final Assignment? assignment;
  final Function()? onPressed;

  const PracticeWidget({Key? key, this.assignment, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? PracticeItemMobile(onPressed: onPressed, assignment: assignment)
        : PracticeItemTablet(assignment: assignment, onPressed: onPressed);
  }
}
