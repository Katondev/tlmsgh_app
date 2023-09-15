import 'package:katon/models/book_info_model.dart';

class BooksM {
  bool? status;
  String? message;
  Data? data;

  BooksM({this.status, this.message, this.data});

  BooksM.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  BookList? bookList;

  Data({this.bookList});

  Data.fromJson(Map<String, dynamic> json) {
    bookList =
        json['bookList'] != null ? BookList.fromJson(json['bookList']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookList != null) {
      data['bookList'] = bookList!.toJson();
    }
    return data;
  }
}

class BookList {
  int? count;
  List<BookDetailsM>? rows;

  BookList({this.count, this.rows});

  BookList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <BookDetailsM>[];
      json['rows'].forEach((v) {
        rows!.add(BookDetailsM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
