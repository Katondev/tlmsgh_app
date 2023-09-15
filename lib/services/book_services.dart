import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:katon/models/books_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';

import '../models/video_books_model.dart';

class BookServices {
  Future<BooksM?> getBooksListWithSearch(
      Map<String, dynamic>? queryParameters) async {
    BooksM? booksM;
    try {
      log(queryParameters.toString());
      Response books = await ApiService.instance
          .get(ApiRoutes.bookWithSearch, queryParameters: queryParameters);
      booksM = BooksM.fromJson(books.data);
      log("booksM--${booksM.toJson()}");
      return booksM;
    } catch (e) {
      rethrow;
    }
  }

  // Future<VideoBooksModel?> getVideoBooksListWithSearch(
  //     Map<String, dynamic>? queryParameters) async {

  // }
}
