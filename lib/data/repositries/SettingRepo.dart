import 'package:dio/dio.dart';
import 'package:speech/data/model/body/ReportProblemBody.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class SettingRepo{

  final DioClient dioClient;
  final SaveUserData saveUserData;

  SettingRepo({required this.dioClient,required this.saveUserData});


  Future<ApiResponse> logout() async {
    try {

      Response response = await dioClient.post(
        AppURL.kLogoutURI,
        token: saveUserData.getUserToken()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProfileData() async {
    try {

      Response response = await dioClient.get(
        AppURL.kProfileURI,
         token: saveUserData.getUserToken()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
