import 'package:katon/models/book_info_model.dart';

class LibraryBookM {
  bool? status;
  String? message;
  Data? data;

  LibraryBookM({this.status, this.message, this.data});

  LibraryBookM.fromJson(Map<String, dynamic> json) {
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
  List<BookDetailsM>? books;

  Data({this.books});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bookList'] != null) {
      books = <BookDetailsM>[];
      json['bookList'].forEach((v) {
        books!.add(BookDetailsM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (books != null) {
      data['bookList'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
