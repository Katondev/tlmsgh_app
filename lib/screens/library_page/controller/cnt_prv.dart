// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/models/books_model.dart';
import 'package:katon/models/elearning_model/sub_category_model.dart';
import 'package:katon/models/filter_category_model/filter_category_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/models/teacher_sign_in_model.dart';
import 'package:katon/models/video_books_model.dart';
import 'package:katon/screens/library_page/book_detail/book_detail_page.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/services/book_services.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/utils/route_const.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../../models/subject_model.dart';
import '../../../network/api_constants.dart';
import '../../../res.dart';
import '../../../services/api_service.dart';
import '../../../utils/global_singlton.dart';
import '../../home_page.dart';

class ELearningProvider extends ChangeNotifier {
  List<BooksM> booksM = [];
  List<VideoBooksModel> videobooksM = [];
  List<BookDetailsM> downloadedEbooks = [];
  int currentIndex = -1;
  List<Map<String, dynamic>> subjectList = [
    {
      "title": "English",
      // "icon": AppAssets.ic_subject1,
      "subList": ["E Books", "Videos"],
      "isExpanded": false,
    },
    {
      "title": "Mathematics",
      // "icon": AppAssets.ic_subject2,
      "subList": ["E Books", "Videos"],
      "isExpanded": false,
    },
    {
      "title": "Science",
      // "icon": AppAssets.ic_subject3,
      "subList": ["E Books", "Videos"],
      "isExpanded": false,
    },
    {
      "title": "Social Studies",
      "icon": AppAssets.ic_subject4,
      "subList": ["E Books", "Videos"],
      "isExpanded": false,
    },
    {
      "title": "Computer",
      // "icon": AppAssets.ic_subject5,
      "subList": ["E Books", "Videos"],
      "isExpanded": false,
    },
    {
      "title": "Creative Art",
      // "icon": AppAssets.ic_subject6,
      "subList": ["E Books", "Videos"],
      "isExpanded": false,
    },
  ];
  final TextEditingController ebookShareCnt = TextEditingController();

  int booksMCount = 0;
  BooksM? booksFilter;
  int currentlabelIndex = 0;
  int currentVideoIndex = 0;
  TeacherSignInModel teachersignInM = TeacherSignInModel();
  SignInModel signInM = SignInModel();
  final cnt = Get.put(ELearningCnt());

  GlobalKey<PaginationViewState> pageviewPaginationKey =
      GlobalKey<PaginationViewState>();
  GlobalKey<PaginationViewState> pageviewPaginationKeyTablet =
      GlobalKey<PaginationViewState>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription subscription;

  bool connections = false;
  bool _isLoading = false;
  bool isLoadingStarted = false;

  List<BookDetailsM> similarBookList = [];
  final TextEditingController searchCnt = TextEditingController();

  bool get value => _isLoading;

  bool get connection => connections;

  List<FilterCategoryModel> mainCategoryMList = <FilterCategoryModel>[];
  List<SubCategoryModel> subCategoryList = <SubCategoryModel>[];
  Rx<SubCategoryModel> selectedSubCat = SubCategoryModel().obs;
  String subCategoryName = "";
  Rx<FilterCategoryModel> selectedMainCat = FilterCategoryModel().obs;
  int totalNumberOfPages = 1;

  List<String> filterResourceList = [
    "Resource Type",
    "All",
    "Pdf",
    "Video",
    "ePub"
  ];
  final List<BookDetailsM> _bookData = [];
  final List<VideoDatum> _videobookData = [];
  List<VideoBooksData> videobookData1 = [];
  List<VideoDatum> offlinevideobooks = [];
  final List<VideoDatum> _videobooklabel = [];

  int selectedIndex = 0;

  List<BookDetailsM> get books => _bookData;
  List<VideoDatum> get videobooks => _videobookData;
  // List<VideoDatum> get offlinevideoList => _offlinevideobooks;
  List<VideoDatum> get videobookslabel => _videobooklabel;

  /// Get all main category
  Future getAllCategoryInfo() async {
    // log("--------===== ${AppPreference().getString(PreferencesKey.mainCategory)}");
    // log("--------=====  $mainCategoryMList");
    if (mainCategoryMList.isEmpty) {
      final String mainCategoryData =
          AppPreference().getString(PreferencesKey.mainCategory);
      // mainCategoryMList = (jsonDecode(mainCategoryData) as List).map((e) => FilterCategoryModel.).toList();
      mainCategoryMList = (jsonDecode(mainCategoryData) as List)
          .map((e) => FilterCategoryModel.fromJson(e))
          .toList();

      // log(mainCategoryMList.length.toString());
      mainCategoryMList.forEach((element) {
        log("sdsdsd----${element.maincategoryName}");
      });

      mainCategoryMList.insert(
        0,
        FilterCategoryModel(
          categoryName: "Class/Grade",
          categoryId: 15250,
        ),
      );
      selectedMainCat.value = mainCategoryMList.first;
    }
    log("main-----${mainCategoryMList.length}");

    /// get All sub Category
    subCategoryList.clear();
    if (subCategoryList.isEmpty) {
      log("--------===== ${AppPreference().getString(PreferencesKey.subCategory)}");
      final String subCategoryData =
          AppPreference().getString(PreferencesKey.subCategory);
      subCategoryList = SubCategoryModel.decode(subCategoryData);
      log("subcategory----${subCategoryList.length}");
      subCategoryList.insert(
        0,
        SubCategoryModel(
          categoryName: "Subject",
          subCategoryId: 15200,
          categoryId: 15250,
        ),
      );
      selectedSubCat.value = subCategoryList.first;
    }
  }

  List<BookDetailsM>? rowsTemp = [];

  int rowShows = 0;

  /// Get All Books with search

  int apiPage = 1;

  Future<void> getAllBooksWithSearch(String bkCategory, String bkTitle,
      String bkSubCategory, int page, int limit) async {
    // try {
    //   connections = false;
    //   _setLoading(true);
    //   notifyListeners();
    //   await BookServices().getBooksListWithSearch({
    //     "bk_category": bkCategory,
    //     "bk_title": bkTitle,
    //     "bk_subCategory": bkSubCategory,
    //     "page": page,
    //     "limit": 12,
    //     "userType": "${AppPreference().uType}"
    //   }).then((book) {
    //     booksM = book;
    //     final isLastPage = booksM!.data!.bookList!.rows!.length < pageSize;
    //     if (isLastPage) {
    //       pagingController.appendLastPage(booksM!.data!.bookList!.rows!);
    //     } else {
    //       final nextPageKey = page + booksM!.data!.bookList!.rows!.length;
    //       pagingController.appendPage(
    //           booksM!.data!.bookList!.rows!, nextPageKey);
    //     }
    //     double totalPage =
    //         (booksM!.data!.bookList!.rows!.length * apiPage) / 20;
    //     if (totalPage <= 1.00) {
    //       totalNumberOfPages = 1;
    //     } else if (totalPage <= 2.00) {
    //       totalNumberOfPages = 2;
    //     } else {
    //       totalNumberOfPages = int.parse(totalPage.toStringAsFixed(0));
    //     }
    //     apiPage += 1;
    //     notifyListeners();
    //   });
    //   _setLoading(false);
    // } on Exception catch (e) {
    //   if (e.toString() == "No Internet") {
    //     connections = true;
    //   }
    //   _setLoading(false);
    // }
    // notifyListeners();
  }
  List<VideoDatum> dd = [];
  initOffline() {
    dd.clear();
    log("messageddd--------${videobookslabel.length}");
    offlinevideobooks.clear();
    videobookslabel.forEach((e) {
      final a = VideoDatum(label: e.label, data: []);
      bool isAnyDownloaded = false;
      e.data?.forEach((f) {
        if (File("${GlobalSingleton().Dirpath}/${f.bkVideo?.split("/").last}")
            .existsSync()) {
          print("label------${e.label}");
          a.data?.add(f);
          isAnyDownloaded = true;
        }
      });
      if (isAnyDownloaded) {
        dd.add(a);
      }
    });
    setBooks();

    print("video----000----${dd.length}");
  }

  setBooks() async {
    final String encodeData = VideoData.encode(dd);
    await AppPreference()
        .setString(PreferencesKey.downloaded_ebooks, encodeData);
    log("encode data-----$encodeData");
    getBooks();
  }

  // List<VideoDatum> videoBookDetails = [];
  getBooks() {
    final String booksString =
        AppPreference().getString(PreferencesKey.downloaded_ebooks);
    if (booksString.isNotEmpty) {
      offlinevideobooks = VideoData.decode(booksString);
      log("dd--------13---${offlinevideobooks.map((e) => e.label)}");
    }
  }

  Future<List<VideoDatum>> getBooksbyVideo(
      {String? bkCategory,
      String? bkSubCategory,
      int? page,
      int? limit}) async {
    try {
      notifyListeners();
      VideoBooksModel? bookData;
      // if (page == 1) {
      _videobookData.clear();
      _videobooklabel.clear();
      videobookData1.clear();
      videobooksM.clear();
      _isLoading = true;
      isLoadingStarted = true;
      notifyListeners();

      connections = false;
      VideoBooksModel? booksM;

      var res = await ApiService.instance.get(
        ApiRoutes.videobookWithSearch,
        queryParameters: {
          "bk_mainCategory": bkCategory ?? "JHS",
          "bk_subCategory": bkSubCategory,
          "userType": AppPreference().getString(PreferencesKey.uType),
          "level": AppPreference().getString(PreferencesKey.level),
        },
      );
      booksM = VideoBooksModel.fromJson(res.data);
      print("---resdata---${res.data}");

      if (res.statusCode == 200) {
        bookData = booksM;
        videobooksM.add(booksM);
        _videobooklabel.addAll(booksM.data!.videoData!);
        if (GlobalSingleton().globalVideolabelData.isEmpty) {
          GlobalSingleton()
              .globalVideolabelData
              .addAll(booksM.data!.videoData!);
        }
        print("video book label length----${_videobooklabel.length}");
        for (var i in booksM.data!.videoData!) {
          _videobookData.addAll(booksM.data!.videoData!);
          print("video book data length----${_videobookData.length}");
          videobookData1.addAll(i.data!);
          if (GlobalSingleton().globalVideoData.isEmpty) {
            GlobalSingleton().globalVideoData.addAll(booksM.data!.videoData!);
          }

          print(
              "global video data---------------${GlobalSingleton().globalVideolabelData.length}");
          print(
              "video books-----${_videobookData.map((e) => e.data!.length)}-------$videobookData1");
        }
        initOffline();
      }
      // pages++;
      // booksMCount = book!.data!.videoData!.c ?? 0;
      isFilter.value = false;
      _isLoading = false;
      isLoadingStarted = false;

      notifyListeners();
      isFilter.notifyListeners();

      // notifyListeners();
      return bookData!.data!.videoData!;

      // _setLoading(false);
    } on Exception catch (e) {
      // isLoadingStarted = false;
      notifyListeners();
      isFilter.notifyListeners();
      if (e.toString() == "No Internet") {
        connections = true;
        getBooks();
      }
      isFilter.notifyListeners();
      _isLoading = false;
      isLoadingStarted = false;
      notifyListeners();
      return [];
      // _setLoading(false);
    }
    // notifyListeners();
  }

  initEbookOffline() {
    log("messageddd--------${books.length}");
    for (var e in books) {
      if (File("${GlobalSingleton().Dirpath}/${e.bkEpub?.split("/").last}")
              .existsSync() ||
          File("${GlobalSingleton().Dirpath}/${e.bkPdf?.split("/").last}")
              .existsSync()) {
        if (books.contains(e)) {
          var book = books.where((element) => element.bkId == e.bkId).toList();

          log("bk-------1----$book");
          downloadedEbooks = book;
        }
        log("bk--------2---$downloadedEbooks");
        setEBooks();
      }
    }
  }

  setEBooks() async {
    final String encodeData = BookDetailsM.encode(downloadedEbooks);
    print("dd-----1----$encodeData");
    await AppPreference()
        .setString(PreferencesKey.downloaded_ebooks, encodeData);
    getEBooks();
  }

  List<BookDetailsM> listOfBookDetails = [];
  getEBooks() {
    print("----------------------------------");
    final String booksString =
        AppPreference().getString(PreferencesKey.downloaded_ebooks);
    print("dd-----2----$booksString");
    if (booksString.isNotEmpty) {
      listOfBookDetails = BookDetailsM.decode(booksString);
      print("dd-----3----$listOfBookDetails");
    }
  }

  Future getAllBooksWithSearchPagination(
      {String? bkCategory,
      String? bkTitle,
      String? bkSubCategory,
      int? page,
      int? limit}) async {
    try {
      // isLoadingStarted = true;
      notifyListeners();
      BooksM? bookData;
      if (page == 1) {
        _bookData.clear();
        booksM.clear();
        _isLoading = true;
        notifyListeners();
      } else {
        isLoadingStarted = true;
        notifyListeners();
      }
      connections = false;
      await ApiService.instance.get(ApiRoutes.bookWithSearch, queryParameters: {
        "bk_mainCategory": bkCategory ?? "JHS",
        "bk_subCategory": bkSubCategory,
        "page": page,
        "limit": limit,
        "userType": AppPreference().uType
      }).then((book) {
        log("--------------------HH------------------------");
        bookData = BooksM.fromJson(book.data);

        booksM.add(bookData!);
        // books.add(bookData.data);
        _bookData.addAll(bookData!.data!.bookList!.rows!);
        log("books--------${book.data}");
        initEbookOffline();
        booksMCount = bookData!.data!.bookList!.count ?? 0;
        isFilter.value = false;
        _isLoading = false;
        isLoadingStarted = false;
        notifyListeners();
        isFilter.notifyListeners();
      });

      //  bookData.data!.bookList!.rows!;
    } on Exception catch (e) {
      notifyListeners();
      isFilter.notifyListeners();
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isFilter.notifyListeners();
      _isLoading = false;
      isLoadingStarted = false;
      notifyListeners();
      // return [];
      // _setLoading(false);
    }
    // notifyListeners();
  }

  List<SubjectDataModel> downloadedSubject = [];
  initSubjectOffline() {
    print("messageddd--------${books.length}");
    for (var e in subjectList1) {
      // if (File("${GlobalSingleton().Dirpath}/${e.bkEpub?.split("/").last}")
      //         .existsSync() ||
      //     File("${GlobalSingleton().Dirpath}/${e.bkPdf?.split("/").last}")
      //         .existsSync()) {
      if (subjectList1.contains(e)) {
        // var book = books.where((element) => element.bkId == e.bkId).toList();

        // print("bk-------1----${book.length}");
        downloadedSubject = subjectList1;
      }
      print("bk--------2---$downloadedSubject");
      setSubject();
      // }
    }
  }

  setSubject() async {
    final String encodeData = SubjectDataModel.encode(downloadedSubject);
    print("dd-----1----$encodeData");
    await AppPreference()
        .setString(PreferencesKey.offline_subjects, encodeData);
    getSubject();
  }

  List<SubjectDataModel> listOfSubject = [];
  getSubject() {
    print("----------------------------------");
    final String booksString =
        AppPreference().getString(PreferencesKey.offline_subjects);
    print("dd-----2----$booksString");
    if (booksString.isNotEmpty) {
      listOfSubject = SubjectDataModel.decode(booksString);
      print("dd-----3----${listOfSubject.map((e) => e.title)}");
    }
  }

  //!
  RxList<SubjectDataModel> subjectList1 = <SubjectDataModel>[].obs;
  Future getAllSubjects({
    String? subject,
  }) async {
    try {
      // isLoadingStarted = true;
      subjectList1.clear();
      notifyListeners();
      SubjectModel? subjectData;

      _isLoading = true;
      isLoadingStarted = true;
      notifyListeners();

      connections = false;
      var book = await ApiService.instance.get(
          "${ApiRoutes.subjectList}?subject=${AppPreference().getString(PreferencesKey.level)}",
          queryParameters: {
            "subject": AppPreference().uType,
          });
      subjectData = SubjectModel.fromJson(book.data);

      if (book.statusCode == 200) {
        subjectList1.addAll(subjectData.data!);
        print("books--------${book.data}");
        initSubjectOffline();
        _isLoading = false;
        isLoadingStarted = false;
        notifyListeners();
      }
    } on Exception catch (e) {
      notifyListeners();
      isFilter.notifyListeners();
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isFilter.notifyListeners();
      _isLoading = false;
      isLoadingStarted = false;
      notifyListeners();

      // _setLoading(false);
    }
    // notifyListeners();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    // notifyListeners();
  }

  int SelectedIndex = 1;
  bool isExpanded = false;

  static const pageSize = 20;
  int pages = 1;
  PagingController<int, BookDetailsM> pagingController =
      PagingController(firstPageKey: 0);

  Future callApiPagination() async {
    // log("index" + index.toString());
    // try {
    //   print("PRINTING: $isFilter");
    //   print(
    //       "subcategory0----: $subCategoryName-----------${AppPreference().getString(PreferencesKey.level)}");
    //   notifyListeners();
    //   getAllBooksWithSearchPagination(
    //       bkCategory: AppPreference().getString(PreferencesKey.level),
    //       bkSubCategory: subCategoryName,
    //       page: pages,
    //       limit: 50);

    //   // });
    // } catch (e) {
    //   print(e);
    //   return [];
    // }
    try {
      // isLoadingStarted = true;
      notifyListeners();
      BooksM? bookData;
      if (pages == 1) {
        _bookData.clear();
        booksM.clear();
        _isLoading = true;
        notifyListeners();
      } else {
        isLoadingStarted = true;
        notifyListeners();
      }
      connections = false;
      await ApiService.instance.get(ApiRoutes.bookWithSearch, queryParameters: {
        "bk_mainCategory": AppPreference().getString(PreferencesKey.level),
        "bk_subCategory": subCategoryName,
        "page": pages,
        "limit": 50,
        "userType": AppPreference().uType
      }).then((book) {
        print("--------------------HH------------------------${book.data}");
        bookData = BooksM.fromJson(book.data);

        booksM.add(bookData!);
        // books.add(bookData.data);
        _bookData.addAll(bookData!.data!.bookList!.rows!);
        print("books--------${bookData?.toJson()}");
        initEbookOffline();
        booksMCount = bookData!.data!.bookList!.count ?? 0;
        isFilter.value = false;
        _isLoading = false;
        isLoadingStarted = false;
        notifyListeners();
        isFilter.notifyListeners();
      });

      //  bookData.data!.bookList!.rows!;
    } on Exception catch (e) {
      notifyListeners();
      isFilter.notifyListeners();
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isFilter.notifyListeners();
      _isLoading = false;
      isLoadingStarted = false;
      notifyListeners();
      // return [];
      // _setLoading(false);
    }
  }

  Future<List<VideoDatum>> callVideobookApiPagination() async {
    // log("index" + index.toString());
    try {
      print("PRINTING: $isFilter");
      print("subcategory0----: $subCategoryName");
      notifyListeners();
      return getBooksbyVideo(
        bkCategory: AppPreference().getString(PreferencesKey.level),
        bkSubCategory: subCategoryName,
        page: pages,
      );

      // });
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Future<void> onPageChange(int index) async {
  //   if (booksM!.data!.bookList!.rows!.length > rowShows) {
  //     rowShows = 20 * (index + 1);
  //     if (rowShows == booksM!.data!.bookList!.rows!.length) {
  //       await getAllBooksWithSearch(
  //           selectedMainCat.categoryName == "Select Main Category"
  //               ? ""
  //               : "${selectedMainCat.categoryName}",
  //           searchCnt.text,
  //           selectedSubCat.categoryName == "Select Sub Category"
  //               ? ""
  //               : selectedSubCat.categoryName ?? "",
  //           index + 1,
  //           12);
  //       rowShows = rowShows - 20;
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> submitOnTap() async {
    // _isLoading = true;
    // notifyListeners();
    // selectedFilter.value = "Resource Type";
    // filterList.clear();
    isFilter.value = false;
    isFilter.notifyListeners();
    pages = 1;
    await callApiPagination();
    // pageviewPaginationKey.currentState!.refresh();
    // pageviewPaginationKeyTablet.currentState!.refresh();
  }

  Future<void> resetOnTap() async {
    selectedMainCat.value = mainCategoryMList.first;
    selectedSubCat.value = subCategoryList.first;
    selectedFilter.value = "Resource Type";
    filterList.clear();
    isFilter.value = false;
    isFilter.notifyListeners();

    searchCnt.text = '';
    await getAllCategoryInfo();
    pages = 1;
    notifyListeners();
    pageviewPaginationKey.currentState?.refresh() ?? await callApiPagination();
    if (Responsive.isTablet(Get.context!)) {
      pages = 1;
      notifyListeners();
      pageviewPaginationKeyTablet.currentState?.refresh() ??
          await callApiPagination();
    }
  }

  RxString selectedFilter = 'Resource Type'.obs;

  List<BookDetailsM> filterList = [];
  // bool isFilter = false;
  final ValueNotifier<bool> isFilter = ValueNotifier<bool>(false);

  int totalPages = 0;

  updateResourceType() {
    // if(){

    // }
  }

  updateSelectedFilter(String selected) {
    selectedFilter.value = selected;
    _isLoading = true;
    notifyListeners();
    if (selectedFilter.value != "Resource Type") {
      // isFilter.value = false;
      // isFilter.notifyListeners();
      totalNumberOfPages = 1;
      filterList.clear();
      notifyListeners();
      log("->111");

      if (selectedFilter.value == "All") {
        filterList.clear();
        pages = 1;
        isFilter.value = false;
        isFilter.notifyListeners();
        pageviewPaginationKey.currentState?.refresh();
        _isLoading = false;
        notifyListeners();

        log("->222");
      } else {
        if (booksM.isNotEmpty)
          for (int i = 0; i < booksM[0].data!.bookList!.rows!.length; i++) {
            if (selectedFilter.value == 'ePub') {
              filterList.clear();
              isFilter.value = true;
              notifyListeners();
              if (booksM[0].data!.bookList!.rows![i].bkEpub != null) {
                filterList.add(booksM[0].data!.bookList!.rows![i]);
                log(filterList.length.toString());
              }
            }
            if (selectedFilter.value == 'Video') {
              if (booksM[0].data!.bookList!.rows![i].bkVideo != null) {
                filterList.add(booksM[0].data!.bookList!.rows![i]);
                log(filterList.length.toString());
              }
            }

            if (selectedFilter.value == 'Pdf') {
              if (booksM[0].data!.bookList!.rows![i].bkPdf != null) {
                filterList.add(booksM[0].data!.bookList!.rows![i]);
                log(filterList.length.toString());
              }
            }
          }
        _isLoading = false;
        notifyListeners();
        isFilter.value = true;
        isFilter.notifyListeners();
      }
    } else {
      isFilter.value = false;
      isFilter.notifyListeners();
      _isLoading = false;
      notifyListeners();
    }

    booksMCount = filterList.length;
    log("Release mode ${filterList.length}");
    // print("Release mode ${filterList!.length}");
    log("Release mode ${filterList.toString()}");
    log("Release mode $isFilter");
    _isLoading = false;
    notifyListeners();
    isFilter.notifyListeners();
  }

  /// Select Main Category Drop down
  void selectMainCategory({FilterCategoryModel? value}) {
    selectedMainCat.value = value!;

    log(selectedMainCat.value.toJson().toString());
    if (AppPreference().getString(PreferencesKey.uType) == "Student") {
      signInM.data?.categories?.forEach((mainCategory) {
        log("3333--${mainCategory.categoryName}");
        mainCategory.category?.forEach((category) {
          // log(category.categoryId.toString());
          if (category.categoryId == selectedMainCat.value.categoryId) {
            subCategoryList.clear();
            subCategoryList.add(SubCategoryModel(
              categoryName: "Subject",
              subCategoryId: 15200,
              categoryId: 15250,
            ));
            category.subCategory?.forEach((subCategory) {
              log("3333-3333-----$subCategory");
              subCategoryList.add(SubCategoryModel(
                categoryId: category.categoryId,
                categoryName: subCategory.subCateName,
                subCategoryId: subCategory.subCateId,
              ));
            });
            log(category.subCategory.toString());
            notifyListeners();
            isFilter.notifyListeners();
          }
          selectedSubCat.value = subCategoryList.first;
          notifyListeners();
          isFilter.notifyListeners();
        });
      });
    } else {
      teachersignInM.data?.categories?.forEach((mainCategory) {
        mainCategory.category.forEach((category) {
          // log(category.categoryId.toString());
          if (category.categoryId == selectedMainCat.value.categoryId) {
            subCategoryList.clear();
            subCategoryList.add(SubCategoryModel(
              categoryName: "Subject",
              subCategoryId: 15200,
              categoryId: 15250,
            ));
            category.subCategory.forEach((subCategory) {
              subCategoryList.add(SubCategoryModel(
                categoryId: category.categoryId,
                categoryName: subCategory.subCateName,
                subCategoryId: subCategory.subCateId,
              ));
            });
            log(category.subCategory.toString());
            notifyListeners();
            isFilter.notifyListeners();
          }
          selectedSubCat.value = subCategoryList.first;
          notifyListeners();
          isFilter.notifyListeners();
        });
      });
    }
  }

  /// Select Sub Category Drop down
  void selectSubcategory({SubCategoryModel? value}) {
    selectedSubCat.value = value!;
    log(selectedSubCat.value.toJson().toString());

    isFilter.notifyListeners();
  }

  static Route<void> _myRouteBuilder(BuildContext context, Object? arguments) {
    return MaterialPageRoute<void>(
      settings:
          RouteSettings(name: RoutesConst.bookDetail, arguments: arguments),
      builder: (BuildContext context) => const BookDetailPage(),
    );
  }

  /// On Tap Book Details Page Navigation
  Future<void> onBookDetailsTap(
      {required BuildContext context,
      BookDetailsM? bookObj,
      List<BookDetailsM>? bookList,
      bool? navigation,
      bool? isSimilarOrNot}) async {
    similarBookList.clear();
    bookList?.forEach((element) {
      if (bookObj?.bkId != element.bkId) {
        similarBookList.add(element);
      }
    });
    if (navigation ?? false) {
      navigatorKey.currentState?.pushNamed(RoutesConst.bookDetail, arguments: [
        bookObj,
        StudentRouteArguments().getArgument(RoutesConst.bookDetail)
      ]);
      // Navigator.of(context).pushNamed(RoutesConst.bookDetail, arguments: [
      //   bookObj,
      //   StudentRouteArguments().getArgument(RoutesConst.bookDetail)
      // ]);
      // Get.toNamed(RoutesConst.bookDetail, arguments: [
      //   bookObj,
      //   StudentRouteArguments().getArgument(RoutesConst.bookDetail)
      // ]);
      // if (isSimilarOrNot == true) {
      //   navigatorKey.currentState?.pushReplacementNamed(
      //     RoutesConst.bookDetail,
      //     arguments: [bookObj, StudentRouteArguments().getArgument(RoutesConst.bookDetail)],
      //   );
      // } else {
      //
      // }
    } else {
      // Get.toNamed(RoutesConst.bookDetail, arguments: [
      //   bookObj,
      //   StudentRouteArguments().getArgument(RoutesConst.bookDetail)
      // ]);
      // if (isSimilarOrNot == true) {
      //   navigatorKey.currentState?.pushReplacementNamed(
      //     RoutesConst.bookDetail,
      //     arguments: [bookObj, StudentRouteArguments().getArgument(RoutesConst.bookDetail)],
      //   );
      // } else {
      //   Get.to(BookDetailPage(), arguments: [
      //     bookObj,
      //     StudentRouteArguments().getArgument(RoutesConst.bookDetail)
      //   ]);
      // }
    }
    notifyListeners();
  }
}
