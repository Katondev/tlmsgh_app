import 'package:flutter/material.dart';
import 'package:katon/screens/library_page/videos/library_video_mobile.dart';

import '../../../models/argument_model.dart';
import '../../../widgets/responsive.dart';
import 'library_video_tablet.dart';

class LibraryVideoScreen extends StatefulWidget {
  final Arguments arguments;
  const LibraryVideoScreen({super.key, required this.arguments});

  @override
  State<LibraryVideoScreen> createState() => _LibraryVideoScreenState();
}

class _LibraryVideoScreenState extends State<LibraryVideoScreen> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobilenew(context)) {
      return LibraryVideoMobile(arguments: widget.arguments);
    } else {
      return LibraryVideoTablet(arguments: widget.arguments);
    }
  }
}
