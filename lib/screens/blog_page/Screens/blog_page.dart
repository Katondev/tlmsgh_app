import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';

import '../../../widgets/responsive.dart';
import '../controller/blog_controller.dart';
import 'blog_mobile.dart';
import 'blog_tablet.dart';

class BlogPage extends StatefulWidget {
  final Arguments arguments;
  const BlogPage({super.key, required this.arguments});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final blgCnt = Get.put(BlogController());
 

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? BlogMobile(arguments: widget.arguments)
        : BlogTablet(arguments: widget.arguments);
  }
}
