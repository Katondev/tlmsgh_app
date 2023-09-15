import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/group_page/screens/group_mobile.dart';
import 'package:katon/screens/group_page/screens/group_tablet.dart';

import '../../../widgets/responsive.dart';
import '../controller/group_controller.dart';

class GroupPage extends StatefulWidget {
  final Arguments arguments;
  const GroupPage({super.key, required this.arguments});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
    final grpCnt = Get.put(GroupController());

 
  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? GroupMobile(arguments: widget.arguments)
        : GroupTablet(arguments: widget.arguments);
  }
}
