import 'package:dio/dio.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';


class PersonalKnowledgeRepo{

  final DioClient dioClient;


  PersonalKnowledgeRepo({required this.dioClient});

  Future<ApiResponse> getSectors() async {
    try {
      Response response = await dioClient.get(
        AppURL.kSectorURI,

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategories() async {
    try {
      Response response = await dioClient.get(
        AppURL.kCategoryURI,

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}