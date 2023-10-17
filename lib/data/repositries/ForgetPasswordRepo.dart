import 'package:dio/dio.dart';
import 'package:speech/data/repositries/SaveUserData.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';


class ForgetPasswordRepo {
  final DioClient dioClient;
  SaveUserData saveUserData;

  ForgetPasswordRepo({required this.dioClient,required this.saveUserData});


  Future<ApiResponse> sendEmail({required String email}) async {
    try {
      Response response = await dioClient.post(
        AppURL.kSendEmailURI,
        data: {
          "email":email
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> confirmCode({required String email,required String code}) async {
    try {
      Response response = await dioClient.post(
        AppURL.kConfirmCodeURI,
        data: {
          "email":email,
          "code":code,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> newPassword({required String password}) async {
    try {
      Response response = await dioClient.post(
        AppURL.kNewPasswordURI,
        data: {
          "new_password":password,
          "password_confirmation":password,
        },
          token: saveUserData.getUserToken()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}
