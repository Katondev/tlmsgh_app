import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../utils/app_binding.dart';
import '../../../widgets/download_file.dart';
import '../../my_library/widgets/video_and_book_related_questions.dart';

// class PdfViewerScreen extends StatefulWidget {
//   final String filename;
//   final bool? isdownloading;
//   final String filetype;
//   const PdfViewerScreen(
//       {super.key,
//       required this.filename,
//       this.isdownloading = false,
//       required this.filetype});

//   @override
//   State<PdfViewerScreen> createState() => _PdfViewerScreenState();
// }

// class _PdfViewerScreenState extends State<PdfViewerScreen> {
//   late PdfViewerController _pdfViewerController;
//   late PdfTextSearchResult _searchResult;
//   // final pdfViewCnt = Get.put(PDFViewCnt());
//   RxBool isLoading = false.obs;
//   Directory? dir;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _pdfViewerController = PdfViewerController();
//     _searchResult = PdfTextSearchResult();
//     init();
//   }

//   init() async {
//     dir = await getApplicationDocumentsDirectory();
//     log(dir!.path.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.search,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               _searchResult = _pdfViewerController.searchText(
//                 'the',
//               );
//               if (kIsWeb) {
//                 print(
//                     'Total instance count: ${_searchResult.totalInstanceCount}');
//               } else {
//                 _searchResult.addListener(() {
//                   if (_searchResult.hasResult &&
//                       _searchResult.isSearchCompleted) {
//                     print(
//                         'Total instance count: ${_searchResult.totalInstanceCount}');
//                   }
//                 });
//               }
//             },
//           ),
//           Visibility(
//             visible: _searchResult.hasResult,
//             child: IconButton(
//               icon: Icon(
//                 Icons.clear,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _searchResult.clear();
//                 });
//               },
//             ),
//           ),
//         ],
//         title: Row(
//           children: [],
//         ),
//       ),
//       // floatingActionButton: Row(
//       //   mainAxisSize: MainAxisSize.min,
//       //   children: [
//       //     if (widget.isdownloading!)
//       //       FloatingActionButton(
//       //         heroTag: "2",
//       //         onPressed: () =>
//       //             Provider.of<TrainingProvider>(context, listen: false)
//       //                 .downloadCertificate(
//       //                     path: widget.filename, filetype: widget.filetype),
//       //         child: const Icon(
//       //           Icons.download,
//       //           color: AppColors.white,
//       //         ),
//       //       ),
//       //     if (widget.isdownloading!) w20,
//       //     FloatingActionButton(
//       //       heroTag: "1",
//       //       onPressed: () => Get.back(),
//       //       child: const Icon(
//       //         Icons.close,
//       //         color: AppColors.white,
//       //       ),
//       //     ),
//       //   ],
//       // ),
//       body: SafeArea(
//           child: SfPdfViewer.network(
//         "${ApiRoutes.imageURL}${widget.filename}",
//         controller: _pdfViewerController,
//         pageLayoutMode: PdfPageLayoutMode.continuous,
//         scrollDirection: PdfScrollDirection.vertical,
//       )),
//       // body: SafeArea(
//       //   child: isLoading.value
//       //       ? const Center(child: CircularProgressIndicator())
//       //       : widget.filename.isEmpty
//       //           ? const NoDataFound(message: "No Pdf Found!!")
//       //           : PDF(
//       //               onError: (error) {
//       //                 // cnt.pdfExisted = false;
//       //                 // pdfViewCnt.close();
//       //                 SnackBarService().showSnackBar(
//       //                   message: "$error",
//       //                   type: SnackBarType.error,
//       //                 );
//       //               },
//       //               pageFling: false,
//       //             ).fromUrl("${ApiRoutes.imageURL}${widget.filename}"),
//       // ),
//     );
//   }
// }

/// Represents the Homepage for Navigation
class PdfViewerScreen extends StatefulWidget {
  final bookname;
  final type;
  final String filename;
  final String? file;
  final bool? isdownloadicon;
  final bool? isdownloaded;
  final String filetype;
  const PdfViewerScreen(
      {super.key,
      required this.filename,
      this.isdownloadicon = false,
      required this.filetype,
      this.file,
      this.isdownloaded = false, this.bookname, this.type});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final GlobalKey<SearchToolbarState> _textSearchKey = GlobalKey();
  late bool _showToolbar;
  late bool _showScrollHead;
  RxDouble zoomlevel = 1.0.obs;
  OverlayEntry? overlayEntry;
  RxInt pageCount = 0.obs;
  RxInt selectedValue = 1.obs;

  /// Ensure the entry history of Text search.
  LocalHistoryEntry? _historyEntry;
  PdfScrollDirection scrollDirection = PdfScrollDirection.vertical;
  PdfPageLayoutMode layoutMode = PdfPageLayoutMode.continuous;
  final TextEditingController pageController = TextEditingController(text: "1");

  @override
  void initState() {
    _showToolbar = false;
    _showScrollHead = true;

    print("isdownload-------${widget.isdownloadicon}--------${widget.file}");
    _pdfViewerController.addListener(() {
      log("message");
      pageCount.value = _pdfViewerController.pageCount;
      pageController.text = _pdfViewerController.pageNumber.toString();
    });
    super.initState();
  }

  /// Ensure the entry history of text search.
  void _ensureHistoryEntry() {
    if (_historyEntry == null) {
      final ModalRoute<dynamic>? route = ModalRoute.of(context);
      if (route != null) {
        _historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(_historyEntry!);
      }
    }
  }

  /// Remove history entry for text search.
  void _handleHistoryEntryRemoved() {
    _textSearchKey.currentState?.clearSearch();
    setState(() {
      _showToolbar = false;
    });
    _historyEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(
          Icons.article,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primaryYellow,
        onPressed: () {
          print(widget.bookname);
            Get.to(() => QuizScreen());
          // navigatorKey.currentState
          //     ?.pushNamed(RoutesConst.videobokQuestions, arguments: "kd");
          setState(() {});
        },
      ),
      appBar: _showToolbar
          ? PreferredSize(
              preferredSize: Size(Get.width, 60),
              // child: AppBar(
              //   flexibleSpace:
              //   automaticallyImplyLeading: false,
              //   backgroundColor: Colors.grey,
              // ),
              child: SafeArea(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                    BoxShadow(
                        color: AppColors.black12,
                        offset: Offset(0, 4),
                        blurRadius: 5,
                        spreadRadius: 3)
                  ]),
                  child: SearchToolbar(
                    key: _textSearchKey,
                    showTooltip: true,
                    controller: _pdfViewerController,
                    onTap: (Object toolbarItem) async {
                      if (toolbarItem.toString() == 'Cancel Search') {
                        setState(() {
                          _showToolbar = false;
                          _showScrollHead = true;
                          if (Navigator.canPop(context)) {
                            Navigator.maybePop(context);
                          }
                        });
                      }
                      if (toolbarItem.toString() == 'noResultFound') {
                        setState(() {
                          _textSearchKey.currentState?._showToast = true;
                        });
                        await Future.delayed(Duration(seconds: 1));
                        setState(() {
                          _textSearchKey.currentState?._showToast = false;
                        });
                      }
                    },
                  ),
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(Get.width, 60),
              child: Obx(
                () => SafeArea(
                  child: Container(
                    height: 60,
                    width: Get.width,
                    decoration:
                        BoxDecoration(color: AppColors.white, boxShadow: [
                      BoxShadow(
                          color: AppColors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 5,
                          spreadRadius: 3)
                    ]),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          // color: AppColors.appbarRed,
                          width: (Responsive.isMobilenew(context)) ? 110 : 120,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                        child: TextFormField(
                                          controller: pageController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 10, bottom: 0),
                                              // isDense: true,
                                              constraints: BoxConstraints(
                                                  maxHeight: 45, maxWidth: 40)),
                                          onFieldSubmitted: (val) {
                                            _pdfViewerController
                                                .jumpToPage(int.parse(val));
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'\s')),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  h4,
                                ],
                              ),
                              Text(
                                "/ ${pageCount.value}",
                                style: (Responsive.isMobilenew(context))
                                    ? FontStyleUtilities.t1()
                                    : FontStyleUtilities.h5(),
                              ),
                              w16,
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _showScrollHead = false;
                                    _showToolbar = true;
                                    _ensureHistoryEntry();
                                  });
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          // color: AppColors.appbarRed,
                          width: (Responsive.isMobilenew(context)) ? 110 : 120,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (zoomlevel.value > 1.0) {
                                    zoomlevel.value -= 0.1;
                                    _pdfViewerController.zoomLevel =
                                        zoomlevel.value;
                                  }
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                  ),
                                  child: Icon(
                                    Icons.zoom_out,
                                    size: (Responsive.isMobilenew(context))
                                        ? 22
                                        : 25,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Text(
                                "${zoomlevel.toStringAsFixed(1)}x",
                                style: (Responsive.isMobilenew(context))
                                    ? FontStyleUtilities.t1()
                                    : FontStyleUtilities.h5(),
                              ),
                              InkWell(
                                onTap: () {
                                  if (zoomlevel.value < 2.0) {
                                    zoomlevel.value += 0.1;
                                    _pdfViewerController.zoomLevel =
                                        zoomlevel.value;
                                  }
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                  ),
                                  child: Icon(
                                    Icons.zoom_in,
                                    size: (Responsive.isMobilenew(context))
                                        ? 22
                                        : 25,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // w10,
                        SizedBox(
                          // color: AppColors.appbarRed,
                          width: (Responsive.isMobilenew(context)) ? 110 : 120,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton(
                                // icon:
                                // child: Icon(
                                //   Icons.more_vert,
                                //   color: Colors.black54,
                                // ),
                                constraints: BoxConstraints(maxWidth: 230),
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      padding: EdgeInsets.zero,
                                      child: StatefulBuilder(
                                        builder: (context, setstate) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 230,
                                                child: ListTile(
                                                  tileColor:
                                                      (selectedValue.value == 1)
                                                          ? AppColors.grey
                                                          : AppColors.white,
                                                  onTap: () {
                                                    layoutMode =
                                                        PdfPageLayoutMode
                                                            .continuous;
                                                    selectedValue.value = 1;
                                                    setState(() {});
                                                    setstate(() {});
                                                  },
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  leading: Icon(Icons
                                                      .insert_page_break_rounded),
                                                  title: Text(
                                                    "Continuous Page",
                                                    style:
                                                        FontStyleUtilities.t1(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 230,
                                                child: ListTile(
                                                  tileColor:
                                                      (selectedValue.value == 2)
                                                          ? AppColors.grey
                                                          : AppColors.white,
                                                  onTap: () {
                                                    layoutMode =
                                                        PdfPageLayoutMode
                                                            .single;
                                                    selectedValue.value = 2;
                                                    Get.back();
                                                    setState(() {});
                                                    setstate(() {});
                                                  },
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  leading: Icon(Icons.copy),
                                                  title: Text(
                                                    "Page by page",
                                                    style:
                                                        FontStyleUtilities.t1(),
                                                  ),
                                                ),
                                              ),
                                              if (selectedValue.value == 1)
                                                SizedBox(
                                                  width: 230,
                                                  child: ListTile(
                                                    onTap: () {
                                                      scrollDirection =
                                                          PdfScrollDirection
                                                              .vertical;

                                                      Get.back();
                                                      setState(() {});
                                                      setstate(() {});
                                                    },
                                                    tileColor: (scrollDirection ==
                                                            PdfScrollDirection
                                                                .vertical)
                                                        ? AppColors.grey
                                                        : AppColors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    leading: Icon(Icons
                                                        .vertical_distribute_outlined),
                                                    title: Text(
                                                      "Verticle scrolling",
                                                      style: FontStyleUtilities
                                                          .t1(),
                                                    ),
                                                  ),
                                                ),
                                              if (selectedValue.value == 1)
                                                SizedBox(
                                                  width: 230,
                                                  child: ListTile(
                                                    onTap: () {
                                                      scrollDirection =
                                                          PdfScrollDirection
                                                              .horizontal;
                                                      Get.back();
                                                      setState(() {});
                                                      setstate(() {});
                                                    },
                                                    tileColor: (scrollDirection ==
                                                            PdfScrollDirection
                                                                .horizontal)
                                                        ? AppColors.grey
                                                        : AppColors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    leading: Icon(Icons
                                                        .horizontal_distribute_outlined),
                                                    title: Text(
                                                      "Horizontal scrolling",
                                                      style: FontStyleUtilities
                                                          .t1(),
                                                    ),
                                                  ),
                                                ),
                                              SizedBox(
                                                width: 230,
                                                child: ListTile(
                                                  onTap: () {
                                                    _pdfViewerController
                                                        .firstPage();
                                                    Get.back();
                                                    setState(() {});
                                                    setstate(() {});
                                                  },
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  leading: Icon(Icons
                                                      .arrow_circle_up_sharp),
                                                  title: Text(
                                                    "First Page",
                                                    style:
                                                        FontStyleUtilities.t1(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 230,
                                                child: ListTile(
                                                  onTap: () {
                                                    _pdfViewerController
                                                        .lastPage();
                                                    Get.back();
                                                    setState(() {});
                                                    setstate(() {});
                                                  },
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  leading: Icon(Icons
                                                      .arrow_circle_down_sharp),
                                                  title: Text(
                                                    "Last Page",
                                                    style:
                                                        FontStyleUtilities.t1(),
                                                  ),
                                                ),
                                              ),
                                              if (widget.isdownloadicon!)
                                                SizedBox(
                                                  width: 230,
                                                  child: ListTile(
                                                    onTap: () async {
                                                      Get.back();
                                                      await DownloadGeoJsonFile()
                                                          .downloadFile(
                                                        url:
                                                            "${ApiRoutes.imageURL}${widget.filename}",
                                                        filename: widget
                                                            .filename
                                                            .toString(),
                                                        fileType:
                                                            widget.filetype,
                                                        isFrom: true,
                                                        uploadprogress: (prg) {
                                                          double pro =
                                                              double.parse(prg
                                                                  .toString());
                                                          log(pro.toString());
                                                        },
                                                        isshowSnackbar: true,
                                                      );
                                                      setState(() {});
                                                    },
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    leading:
                                                        Icon(Icons.download),
                                                    title: Text(
                                                      "Download",
                                                      style: FontStyleUtilities
                                                          .t1(),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ];
                                },
                                offset: Offset(50, 50),
                              ),
                              w30,
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      body: Stack(
        children: [
          (widget.isdownloaded ?? false)
              ? SfPdfViewer.file(
                  File(widget.file!),
                  controller: _pdfViewerController,
                  canShowScrollHead: _showScrollHead,
                  onZoomLevelChanged: (PdfZoomDetails details) {
                    print(details.newZoomLevel);
                  },
                  scrollDirection: scrollDirection,
                  pageLayoutMode: layoutMode,
                  enableDoubleTapZooming: false,
                  pageSpacing: 10,
                )
              : SfPdfViewer.network(
                  '${ApiRoutes.imageURL}${widget.filename}',
                  controller: _pdfViewerController,
                  canShowScrollHead: _showScrollHead,
                  onZoomLevelChanged: (PdfZoomDetails details) {
                    print(details.newZoomLevel);
                  },
                  scrollDirection: scrollDirection,
                  pageLayoutMode: layoutMode,
                  enableDoubleTapZooming: false,
                  pageSpacing: 10,
                ),
          Visibility(
            visible: _textSearchKey.currentState?._showToast ?? false,
            child: Align(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(left: 15, top: 7, right: 15, bottom: 7),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    child: Text(
                      'No result',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _showOverlay(
  //   BuildContext context,
  // ) async {
  //   OverlayState? overlayState = Overlay.of(context);
  //   overlayEntry = OverlayEntry(builder: (context) {
  //     return Positioned(
  //       left: MediaQuery.of(context).size.width * 0.1,
  //       top: MediaQuery.of(context).size.height * 0.1,
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(10),
  //         child: Material(

  //           child: Container(
  //             alignment: Alignment.center,
  //             color: Colors.grey.shade200,
  //             padding:
  //                 EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
  //             width: MediaQuery.of(context).size.width * 0.8,
  //             height: MediaQuery.of(context).size.height * 0.06,
  //             child: Text(
  //               "hello",
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   });

  //   // inserting overlay entry
  //   overlayState.insert(overlayEntry!);
  // }
}

/// Signature for the [SearchToolbar.onTap] callback.
typedef SearchTapCallback = void Function(Object item);

/// SearchToolbar widget
class SearchToolbar extends StatefulWidget {
  ///it describe the search toolbar constructor
  SearchToolbar({
    this.controller,
    this.onTap,
    this.showTooltip = true,
    Key? key,
  }) : super(key: key);

  /// Indicates whether the tooltip for the search toolbar items need to be shown or not.
  final bool showTooltip;

  /// An object that is used to control the [SfPdfViewer].
  final PdfViewerController? controller;

  /// Called when the search toolbar item is selected.
  final SearchTapCallback? onTap;

  @override
  SearchToolbarState createState() => SearchToolbarState();
}

/// State for the SearchToolbar widget
class SearchToolbarState extends State<SearchToolbar> {
  /// Indicates whether search is initiated or not.
  bool _isSearchInitiated = false;

  /// Indicates whether search toast need to be shown or not.
  bool _showToast = false;

  ///An object that is used to retrieve the current value of the TextField.
  final TextEditingController _editingController = TextEditingController();

  /// An object that is used to retrieve the text search result.
  PdfTextSearchResult _pdfTextSearchResult = PdfTextSearchResult();

  ///An object that is used to obtain keyboard focus and to handle keyboard events.
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode?.requestFocus();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode?.dispose();
    _pdfTextSearchResult.removeListener(() {});
    super.dispose();
  }

  ///Clear the text search result
  void clearSearch() {
    _isSearchInitiated = false;
    _pdfTextSearchResult.clear();
  }

  ///Display the Alert dialog to search from the beginning
  void _showSearchAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(0),
          title: Text('Search Result'),
          content: Container(
              width: 328.0,
              child: Text(
                  'No more occurrences found. Would you like to continue to search from the beginning?')),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _pdfTextSearchResult.nextInstance();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'YES',
                style: TextStyle(
                    color: Color(0x00000000).withOpacity(0.87),
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _pdfTextSearchResult.clear();
                  _editingController.clear();
                  _isSearchInitiated = false;
                  focusNode?.requestFocus();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'NO',
                style: TextStyle(
                    color: Color(0x00000000).withOpacity(0.87),
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0x00000000).withOpacity(0.54),
              size: 24,
            ),
            onPressed: () {
              widget.onTap?.call('Cancel Search');
              _isSearchInitiated = false;
              _editingController.clear();
              _pdfTextSearchResult.clear();
            },
          ),
        ),
        Flexible(
          child: TextFormField(
            style: TextStyle(
                color: Color(0x00000000).withOpacity(0.87), fontSize: 18),
            enableInteractiveSelection: false,
            focusNode: focusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            controller: _editingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Find...',
              hintStyle: TextStyle(color: Color(0x00000000).withOpacity(0.34)),
            ),
            onChanged: (text) {
              if (_editingController.text.isNotEmpty) {
                setState(() {});
              }
            },
            onFieldSubmitted: (String value) {
              if (kIsWeb) {
                _pdfTextSearchResult =
                    widget.controller!.searchText(_editingController.text);
                if (_pdfTextSearchResult.totalInstanceCount == 0) {
                  widget.onTap?.call('noResultFound');
                }
                setState(() {});
              } else {
                _isSearchInitiated = true;
                _pdfTextSearchResult =
                    widget.controller!.searchText(_editingController.text);
                _pdfTextSearchResult.addListener(() {
                  if (super.mounted) {
                    setState(() {});
                  }
                  if (!_pdfTextSearchResult.hasResult &&
                      _pdfTextSearchResult.isSearchCompleted) {
                    widget.onTap?.call('noResultFound');
                  }
                });
              }
            },
          ),
        ),
        Visibility(
          visible: _editingController.text.isNotEmpty,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Color.fromRGBO(0, 0, 0, 0.54),
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  _editingController.clear();
                  _pdfTextSearchResult.clear();
                  widget.controller!.clearSelection();
                  _isSearchInitiated = false;
                  focusNode!.requestFocus();
                });
                widget.onTap!.call('Clear Text');
              },
              tooltip: widget.showTooltip ? 'Clear Text' : null,
            ),
          ),
        ),
        Visibility(
          visible:
              !_pdfTextSearchResult.isSearchCompleted && _isSearchInitiated,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _pdfTextSearchResult.hasResult,
          child: Row(
            children: [
              Text(
                '${_pdfTextSearchResult.currentInstanceIndex}',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.54).withOpacity(0.87),
                    fontSize: 16),
              ),
              Text(
                ' of ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.54).withOpacity(0.87),
                    fontSize: 16),
              ),
              Text(
                '${_pdfTextSearchResult.totalInstanceCount}',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.54).withOpacity(0.87),
                    fontSize: 16),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(
                    Icons.navigate_before,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _pdfTextSearchResult.previousInstance();
                    });
                    widget.onTap!.call('Previous Instance');
                  },
                  tooltip: widget.showTooltip ? 'Previous' : null,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(
                    Icons.navigate_next,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_pdfTextSearchResult.currentInstanceIndex ==
                              _pdfTextSearchResult.totalInstanceCount &&
                          _pdfTextSearchResult.currentInstanceIndex != 0 &&
                          _pdfTextSearchResult.totalInstanceCount != 0 &&
                          _pdfTextSearchResult.isSearchCompleted) {
                        _showSearchAlertDialog(context);
                      } else {
                        widget.controller!.clearSelection();
                        _pdfTextSearchResult.nextInstance();
                      }
                    });
                    widget.onTap!.call('Next Instance');
                  },
                  tooltip: widget.showTooltip ? 'Next' : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
