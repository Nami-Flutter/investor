import 'package:dio/dio.dart';
import 'package:speech/data/repositries/SaveUserData.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';


class ChatRepo{

  final DioClient dioClient;
  final SaveUserData saveUserData;

  ChatRepo({required this.dioClient,required this.saveUserData});

  Future<ApiResponse> getMessageOrder(orderId) async {
    try {
      Response response = await dioClient.get(
        "${AppURL.kShowMessagesOrdersURI}$orderId",
        token: saveUserData.getUserToken(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> sendMessage(FormData data) async {
    try {
      Response response = await dioClient.post(
        AppURL.kSendMessagesOrdersURI,
        data:data,
        token: saveUserData.getUserToken()

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> changeOrderStatus(var data,orderId) async {
    try {
      Response response = await dioClient.post(
        "${AppURL.kChangeOrdersStatusURI}$orderId",
        data:data,
          token: saveUserData.getUserToken()

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }





}