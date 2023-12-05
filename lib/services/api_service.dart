import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/dio_exception.dart';
import 'package:katon/screens/auth/login/login_page.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../widgets/loading_indicator.dart';

class ApiService {
  final _dio = Dio();
  Response? response;

  static final ApiService instance = ApiService._apiService();

  ApiService._apiService() {
    // _dio.interceptors.add(PrettyDioLogger(
    //   requestHeader: true,
    //   requestBody: true,
    //   responseHeader: true,
    //   compact: false,
    // ));
  }

  Future<Response> postHTTP(
      {String? url,
      dynamic body,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      log(url!);
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      log("token get success ${AppPreference().getBool("isLoggedIn")}");
      return response;
    } on DioError catch (err) {
      // print("object${err.response?.data}");
      final errorMessage = DioExceptions.fromDioError(err).toString();
      // log("object${err.error.toString()}");
      log("error message---${errorMessage}");
      // throw errorMessage;
      CustomLoadingIndicator.instance.hide();
      SnackBarService().showSnackBar(
        message: err.response!.data["message"].toString(),
        type: SnackBarType.error,
      );
      throw errorMessage;
    } catch (e) {
      // SnackBarService().showSnackBar(
      //   message: e["messa"].toString(),
      //   type: SnackBarType.error,
      // );
      rethrow;
    }
  }

  Future<Response> deleteHTTP(
      {String? url,
      dynamic body,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      print("url----${url}");
      Response response = await _dio.delete(url!,
          queryParameters: queryParameters,
          data: body,
          options: Options(headers: headers));
      return response;
    } on DioError catch (err) {
      final errorMessage = DioExceptions.fromDioError(err).toString();
      throw errorMessage;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> putHTTP(
      {String? url,
      dynamic body,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await _dio.put(url!,
      
          data: body,
          queryParameters: queryParams,
          options: Options(headers: headers));
      return response;
    } on DioError catch (err) {
      final errorMessage = DioExceptions.fromDioError(err).toString();
      throw errorMessage;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> getHTTP(String url,
      {Map<String, dynamic>? queryParameters}) async {
    String token = AppPreference().getString(PreferencesKey.token);
    try {
      log("url----$url----$queryParameters");
      Response response = await _dio.get(url,
          queryParameters: queryParameters,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': "application/json"
          }));
      log(response.toString());
      return response;
    } on DioError catch (err) {
      if (response?.statusCode == 401) {
        Get.offAll(() => LoginPage());
        rethrow;
      } else {
        // final errorMessage = DioExceptions.fromDioError(err).toString();
        throw DioExceptions.fromDioError(err);
      }
    } on Exception {
      rethrow;
    }
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      String token = AppPreference().getString(PreferencesKey.token);
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': "application/json"
        }),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      print("data---1---${url}----${queryParameters}");
      return response;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    } on Exception {
      rethrow;
    }
  }
}
