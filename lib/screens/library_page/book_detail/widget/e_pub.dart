import 'dart:io';
import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';
import 'package:path_provider/path_provider.dart';

class EpubViewer extends StatefulWidget {
  final String epubFilePath;

  EpubViewer({required this.epubFilePath});

  @override
  _EpubViewerState createState() => _EpubViewerState();
}

class _EpubViewerState extends State<EpubViewer> {
  late EpubController _epubController;

  @override
  void initState() {
    super.initState();
    _initEpubController();
  }

  Future<void> _initEpubController() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final epubFilePath = "${appDocDir.path}/${widget.epubFilePath}";

    setState(() {
      _epubController = EpubController(
        document: EpubDocument.openFile(File(epubFilePath)),
        epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Epub Viewer'),
        ),
        body: _epubController != null
            ? EpubView(
                controller: _epubController,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
}



