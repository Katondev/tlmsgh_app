import 'dart:convert';

import 'package:katon/models/elearning_model/sub_category_model.dart';

class CategoryModel {
  CategoryModel({
    this.categoryId,
    this.categoryName,
    this.maincategoryName,
    this.subcategory,
    this.isenabled = false,
  });

  final int? categoryId;
  final String? categoryName;
  final String? maincategoryName;
  final bool? isenabled;
  final List<SubCategoryModel>? subcategory;

  static String encode(List<CategoryModel> mainCategoryModel) => json.encode(
        mainCategoryModel
            .map<Map<String, dynamic>>(
                (mainCategory) => CategoryModel.toMap(mainCategory))
            .toList(),
      );

  static List<CategoryModel> decode(String mainCategoryModel) =>
      (json.decode(mainCategoryModel) as List<dynamic>)
          .map<CategoryModel>((item) => CategoryModel.fromJson(item))
          .toList();

  factory CategoryModel.fromJson(Map<String, dynamic> json_) => CategoryModel(
      categoryId: json_["categoryId"],
      categoryName: json_["categoryName"],
      maincategoryName: json_["categoryTypeName"],
      subcategory: SubCategoryModel.decode(json.encode(json_["subcategory"])));

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "categoryTypeName": maincategoryName,
        "subcategory": subcategory?.map((e) => e.toJson()).toList(),
        "isenabled": isenabled,
      };
  static Map<String, dynamic> toMap(CategoryModel mCategory) => {
        "categoryId": mCategory.categoryId,
        "categoryName": mCategory.categoryName,
        "categoryTypeName": mCategory.maincategoryName,
        "subcategory": mCategory.subcategory?.map((e) => e.toJson()).toList(),
        "isenabled": mCategory.isenabled,
      };
}
