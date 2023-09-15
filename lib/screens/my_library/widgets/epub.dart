// import 'package:katon/utils/config.dart';
// import 'dart:typed_data';
// import 'package:epub_view/epub_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
// import 'package:katon/widgets/download_file.dart';

// class Epub extends StatefulWidget {
//   final String filename;

//   const Epub({Key? key, required this.filename}) : super(key: key);

//   @override
//   State<Epub> createState() => _EpubState();
// }

// class _EpubState extends State<Epub> {
//   EpubController? _epubController;
//   RxBool isLoading = false.obs;
//   final cnt = Get.put(ELearningCnt());

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   Future<void> init() async {
//     isLoading.value = true;

//     print(widget.filename);
//     Uint8List tempUnit = await DownloadGeoJsonFile().filePath(widget.filename);
//     _epubController = EpubController(
//       document: EpubDocument.openData(tempUnit),
//     );
//     isLoading.value = false;
//   }

//   void name() {
//     Container(
//       color: Colors.black,
//       height: 100,
//       width: 100,
//     );
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Icon(
//             Icons.close,
//             color: AppColors.white,
//           ),
//         ),
//         body: SafeArea(
//           child: Obx(
//             () => isLoading.value
//                 ? const Center(child: CircularProgressIndicator())
//                 : EpubView(
//                     builders: EpubViewBuilders<DefaultBuilderOptions>(
//                       options: const DefaultBuilderOptions(),
//                       errorBuilder: (_, error) {
//                         cnt.ePubExisted.value = false;
//                         return Center(
//                           child: Text("$error"),
//                         );
//                       },
//                     ),
//                     controller: _epubController!,
//                   ),
//           ),
//         ),
//       );
// }
