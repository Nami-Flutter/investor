import 'dart:io';


import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logging_interceptor.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;
  final SharedPreferences sharedPreferences;

  late Dio dio;
  // late String token;
  late String countryCode;

  DioClient(
      this.baseUrl,
      Dio dioC, {
        required this.loggingInterceptor,
        required this.sharedPreferences,
      }) {
     // token = sharedPreferences.getString(AppConstants.userTOKEN) ?? "";
    // token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc2F3bi5yb21vei5jb1wvYXBwXC9sb2dpbiIsImlhdCI6MTY4NTE0NjUxMCwibmJmIjoxNjg1MTQ2NTEwLCJqdGkiOiJNclNyS3RLWHN3bXdRcXhxIiwic3ViIjoxMjMsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.5Dv1m9gk_oOU2MOGvSDcwEtaiqxzEgiqcqRZ7xhpsJ0";
    // countryCode = sharedPreferences.getString(AppConstants.COUNTRY_CODE) ?? AppConstants.languages[0].countryCode;
    dio = dioC;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = Duration(milliseconds: 30000)
      ..options.receiveTimeout = Duration(milliseconds: 30000)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
         // 'Authorization': '$token',
        // 'Authorization': 'Bearer $token',
        // AppConstants.LANG_KEY : countryCode == 'US'? 'en':countryCode.toLowerCase(),

      };
    dio.interceptors.add(loggingInterceptor);
  }

  // void updateHeader(String token, String countryCode) {
  //   token = token == null ? this.token : token;
  //   countryCode = countryCode == null ? this.countryCode == 'US' ? 'en': this.countryCode.toLowerCase(): countryCode == 'US' ? 'en' : countryCode.toLowerCase();
  //   // this.token = token;
  //   this.countryCode = countryCode;
  //   print('===Country code====>$countryCode');
  //   dio.options.headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': 'Bearer $token',
  //     // AppConstants.LANG_KEY: countryCode == 'US'? 'en':countryCode.toLowerCase(),
  //   };
  // }

  Future<Response> get(String uri, {
    Map<String, dynamic>? queryParameters,
     Options? options,
    String?token,
     CancelToken? cancelToken,
     ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> post(String uri, {
    data,
    Map<String, dynamic>? queryParameters,
     Options? options,
    String?token,
     CancelToken? cancelToken,
     ProgressCallback? onSendProgress,
     ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
Future<Response> postWithImage(String uri, {
    data,
    Map<String, dynamic>? queryParameters,
     Options? options,
     CancelToken? cancelToken,
     ProgressCallback? onSendProgress,
     ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.post(
        uri,
        data: FormData(),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> put(String uri, {
    data,
    Map<String, dynamic>? queryParameters,
     Options? options,
     CancelToken? cancelToken,
     ProgressCallback? onSendProgress,
     ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> delete(String uri, {
    data,
    Map<String, dynamic>? queryParameters,
     Options? options,
     CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }

  }

  Future<Response> deletePath(String path) async {
    try {
      var response = await dio.delete(
        path,

      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
