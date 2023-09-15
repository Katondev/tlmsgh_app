import 'package:flutter/material.dart';

import '../../../../models/argument_model.dart';
import 'create_blog_mobile.dart';

class CreateBlogPage extends StatefulWidget {
  final Arguments arguments;
  const CreateBlogPage({super.key, required this.arguments});

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  @override
  Widget build(BuildContext context) {
    return CreateBlogMobile(
      arguments: widget.arguments,
    );
  }
}
