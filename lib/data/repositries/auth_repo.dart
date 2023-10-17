import 'package:dio/dio.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/LoginBody.dart';
import '../model/body/RegisterBody.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class AuthRepo {
  final DioClient dioClient;
  final SaveUserData saveUserData;
  AuthRepo({required this.dioClient, required this.saveUserData});



  Future<ApiResponse> login(LoginBody loginBody) async {
    try {
      Response response = await dioClient.post(
        AppURL.kLoginURI,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  Future<ApiResponse> registerRepo(FormData registerBody) async {
    try {
      Response response = await dioClient.post(
        AppURL.kRegisterURI,
        data: registerBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> updateProfile(FormData registerBody) async {
    try {
      Response response = await dioClient.post(
        AppURL.kUpdateProfileURI,
        data: registerBody,
        token: saveUserData.getUserToken()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}


