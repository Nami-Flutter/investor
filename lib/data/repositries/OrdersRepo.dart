import 'package:dio/dio.dart';
import 'package:speech/data/repositries/SaveUserData.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';


class OrdersRepo{

  final DioClient dioClient;
  final SaveUserData saveUserData;

  OrdersRepo({required this.dioClient,required this.saveUserData});

  Future<ApiResponse> getCurrentOrders() async {
    try {
      Response response = await dioClient.get(
        AppURL.kCurrentOrdersURI,
        token: saveUserData.getUserToken(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getCompletedOrders() async {
    try {
      Response response = await dioClient.get(
        AppURL.kCompletedOrdersURI,
        token: saveUserData.getUserToken(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




}