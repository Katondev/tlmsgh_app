import 'package:flutter/material.dart';

import '../../../models/argument_model.dart';
import '../../../widgets/responsive.dart';
import 'library_ebook_mobile.dart';
import 'library_ebook_tablet.dart';

class LibraryEbookScreen extends StatefulWidget {
  final Arguments arguments;
  const LibraryEbookScreen({super.key, required this.arguments});

  @override
  State<LibraryEbookScreen> createState() => _LibraryEbookScreenState();
}

class _LibraryEbookScreenState extends State<LibraryEbookScreen> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return LibraryEbookMobile(arguments: widget.arguments);
    } else {
      return LibraryEbookTablet(arguments: widget.arguments);
    }
  }
}
