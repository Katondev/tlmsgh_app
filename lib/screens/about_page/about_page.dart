import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/about_page/about_page_mobile.dart';
import 'package:katon/screens/about_page/about_page_tablet.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_container.dart';

class AboutPage extends StatelessWidget {
  final Arguments? arguments;

  const AboutPage({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: CommonContainer(
        child: Responsive.isMobile(context)
            ? AboutPageMobilePage(arguments: arguments)
            : AboutPageTabletPage(arguments: arguments),
      ),
    );
  }
}
