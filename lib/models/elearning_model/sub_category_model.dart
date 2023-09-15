import 'dart:convert';

class SubCategoryModel {
  SubCategoryModel({
    this.subCategoryId,
    this.categoryId,
    this.categoryName,
  });

  final int? categoryId;
  final int? subCategoryId;
  final String? categoryName;

  static String encode(List<SubCategoryModel> subCategoryModel) => json.encode(
        subCategoryModel
            .map<Map<String, dynamic>>(
                (mainCategory) => SubCategoryModel.toMap(mainCategory))
            .toList(),
      );

  static List<SubCategoryModel> decode(String mainCategoryModel) =>
      (json.decode(mainCategoryModel) as List<dynamic>)
          .map<SubCategoryModel>((item) => SubCategoryModel.fromJson(item))
          .toList();

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "subCategoryId": subCategoryId,
      };
  static Map<String, dynamic> toMap(SubCategoryModel sCategory) => {
        "categoryId": sCategory.categoryId,
        "categoryName": sCategory.categoryName,
        "subCategoryId": sCategory.subCategoryId,
      };
}
