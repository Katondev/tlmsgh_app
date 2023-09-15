import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:katon/models/elearning_model/category_model.dart';
import 'package:katon/models/elearning_model/sub_category_model.dart';
import 'package:katon/models/live_class_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';

class LiveClassProvider extends ChangeNotifier {
  SignInModel signInM = SignInModel();
  LiveClassModel? liveClassModel;
  bool connections = false;
  bool _isLoading = false;
  int pageNo = 0;
  int tabbarIndex = 0;
  bool isScheduled = false;

  List<CategoryModel> mainCategoryMList = <CategoryModel>[];
  List<SubCategoryModel> subCategoryList = <SubCategoryModel>[];
  SubCategoryModel selectedSubCat = SubCategoryModel();
  CategoryModel selectedMainCat = CategoryModel();

  bool get value => _isLoading;

  bool get connection => connections;

  Future getAllCategoryInfo() async {
    /// Get all category
    if (mainCategoryMList.isEmpty) {
      final String mainCategoryData =
          AppPreference().getString(PreferencesKey.mainCategory);
      mainCategoryMList = CategoryModel.decode(mainCategoryData);

      mainCategoryMList.insert(
        0,
        CategoryModel(
          categoryName: "select_category".tr,
          categoryId: 15250,
        ),
      );
      selectedMainCat = mainCategoryMList.first;
    }

    /// get All sub Category
    if (subCategoryList.isEmpty) {
      final String subCategoryData =
          AppPreference().getString(PreferencesKey.subCategory);
      subCategoryList = SubCategoryModel.decode(subCategoryData);

      subCategoryList.insert(
        0,
        SubCategoryModel(
          categoryName: "Select Sub Category",
          subCategoryId: 15200,
          categoryId: 15250,
        ),
      );
      selectedSubCat = subCategoryList.first;
    }
  }

  Future<void> resetOnTap() async {
    selectedMainCat = mainCategoryMList.first;
    selectedSubCat = subCategoryList.first;
    await getAllLiveClass(
        bkSubCategory: "", bkCategory: "", page: 1, limit: 12);
  }

  // Future getData() async {
  //   pageNo = 0;
  //   final String booksString =
  //       AppPreference().getString(PreferencesKey.myLibraryData);
  //   if (booksString.isNotEmpty) {
  //     liveClassModel?.data?.liveSession = BookDetailsM.decode(booksString);
  //   }
  //   double totalPage = books.length / 12;
  //   if (totalPage <= 1.00) {
  //     totalNumberOfPages = 1;
  //   } else if (totalPage <= 2.00) {
  //     totalNumberOfPages = 2;
  //   } else {
  //     totalNumberOfPages = int.parse(totalPage.toStringAsFixed(0));
  //   }
  // }

  Future<void> getAllLiveClass(
      {String? bkCategory,
      String? bkSubCategory,
      int? page,
      int? limit,
      int? tcId}) async {
    try {
      connections = false;
      _setLoading(true);
      notifyListeners();

      await ApiService.instance
          .get(ApiRoutes.liveClass,
              queryParameters: AppPreference().isTeacherLogin
                  ? {
                      "tc_id": tcId,
                      "bk_category": bkCategory,
                      "bk_subCategory": bkSubCategory,
                      "page": page,
                      "limit": limit,
                      "userType": "${AppPreference().uType}"
                    }
                  : {
                      "bk_category": bkCategory,
                      "bk_subCategory": bkSubCategory,
                      "page": page,
                      "limit": limit,
                      "userType": "${AppPreference().uType}"
                    })
          .then((value) {
        liveClassModel = LiveClassModel.fromJson(value.data);

        notifyListeners();
      });

      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
    notifyListeners();
  }

  // ScheduledLiveClass

  Future<void> getScheduledLiveClass({
    String? bkCategory,
    String? bkSubCategory,
  }) async {
    try {
      connections = false;
      _setLoading(true);
      isScheduled = true;
      notifyListeners();

      await ApiService.instance
          .get(ApiRoutes.scheduledliveClass, queryParameters: {
        "ls_category": "",
        "ls_subCategory": "",
      }).then((value) {
        liveClassModel = LiveClassModel.fromJson(value.data);

        notifyListeners();
      });

      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
    notifyListeners();
  }

  // HistoryLiveClass

  Future<void> getHistoryLiveClass({
    String? bkCategory,
    String? bkSubCategory,
  }) async {
    try {
      connections = false;
      _setLoading(true);
      isScheduled = false;
      notifyListeners();

      await ApiService.instance
          .get(ApiRoutes.historyliveClass, queryParameters: {
        "ls_category": "",
        "ls_subCategory": "",
      }).then((value) {
        liveClassModel = LiveClassModel.fromJson(value.data);

        notifyListeners();
      });

      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
    notifyListeners();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void submitOnTap() {
    getAllLiveClass(
      bkCategory: selectedMainCat.categoryName == "Select Main Category"
          ? ""
          : "${selectedMainCat.categoryName}",
      bkSubCategory: selectedSubCat.categoryName == "Select Sub Category"
          ? ""
          : selectedSubCat.categoryName ?? '',
      page: 1,
      limit: 12,
    );
  }

  void selectSubCategory({CategoryModel? value}) {
    selectedMainCat = value!;
    signInM.data?.categories?.forEach((mainCategory) {
      mainCategory.category?.forEach((category) {
        if (category.categoryId == selectedMainCat.categoryId) {
          subCategoryList.clear();
          subCategoryList.add(
            SubCategoryModel(
              categoryName: "Select Sub Category",
              subCategoryId: 15200,
              categoryId: 15250,
            ),
          );
          category.subCategory?.forEach((subCategory) {
            subCategoryList.add(SubCategoryModel(
              categoryId: category.categoryId,
              categoryName: subCategory.subCateName,
              subCategoryId: subCategory.subCateId,
            ));
          });
        }
        selectedSubCat = subCategoryList.first;
      });
    });
    notifyListeners();
  }

  void selectSubcategory({SubCategoryModel? value}) {
    selectedSubCat = value!;
    notifyListeners();
  }
}
