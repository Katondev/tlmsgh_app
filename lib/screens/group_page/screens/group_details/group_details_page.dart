import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';

import '../../../../widgets/responsive.dart';
import '../../../blog_page/controller/blog_controller.dart';
import '../../controller/group_controller.dart';
import 'group_details_mobile.dart';
import 'group_details_tablet.dart';

class GroupDetailsPage extends StatefulWidget {
  final Arguments arguments;
  const GroupDetailsPage({super.key, required this.arguments});

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage>
    with WidgetsBindingObserver {
  final grpCnt = Get.find<GroupController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      init();
    });
  }

  Future init() async {
    await grpCnt.getGroupDetailsbyId();
  }

  @override
  Widget build(BuildContext context) {
    return GroupDetailsMobile(arguments: widget.arguments);
  }
}
