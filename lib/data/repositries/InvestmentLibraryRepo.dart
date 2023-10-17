import 'package:dio/dio.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class InvestmentLibraryRepo{

  final DioClient dioClient;
  final SaveUserData saveUserData;

  InvestmentLibraryRepo({required this.dioClient,required this.saveUserData});

  Future<ApiResponse> getInvestmentLibraries() async {
    try {
      Response response = await dioClient.get(
        AppURL.kInvestmentLibraryURI,
        token: saveUserData.getUserToken(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}
