import 'dart:convert';

class FilterCategoryModel {
  int? categoryId;
  String? maincategoryName;
  String? categoryName;
  int? subcategoryId;
  bool? isenabled;

  FilterCategoryModel({
    this.categoryId,
    this.maincategoryName,
    this.categoryName,
    this.subcategoryId,
    this.isenabled,
  });

  factory FilterCategoryModel.fromJson(Map<String, dynamic> json_) =>
      FilterCategoryModel(
        categoryId: json_["categoryId"],
        categoryName: json_["categoryName"],
        maincategoryName: json_["categoryTypeName"],
        subcategoryId: json_["subcategory"],
        isenabled: json_["isenabled"],
      );
  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "categoryTypeName": maincategoryName,
        "subcategory": subcategoryId,
        "isenabled": isenabled,
      };
  static Map<String, dynamic> toMap(FilterCategoryModel mCategory) => {
        "categoryId": mCategory.categoryId,
        "categoryName": mCategory.categoryName,
        "categoryTypeName": mCategory.maincategoryName,
        "subcategory": mCategory.subcategoryId,
        "isenabled": mCategory.isenabled,
      };

  static String encode(List<FilterCategoryModel> mainCategoryModel) =>
      json.encode(
        mainCategoryModel
            .map<Map<String, dynamic>>(
                (mainCategory) => FilterCategoryModel.toMap(mainCategory))
            .toList(),
      );

  static List<FilterCategoryModel> decode(String mainCategoryModel) => (json
          .decode(mainCategoryModel) as List<dynamic>)
      .map<FilterCategoryModel>((item) => FilterCategoryModel.fromJson(item))
      .toList();
}
