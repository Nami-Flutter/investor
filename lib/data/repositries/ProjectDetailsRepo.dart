import 'package:dio/dio.dart';
import 'package:speech/data/model/body/AddInvestementModel.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class ProjectDetailsRepo{

  final DioClient dioClient;
  final SaveUserData saveUserData;

  ProjectDetailsRepo({required this.dioClient,required this.saveUserData});



  Future<ApiResponse> addInvestment(AddInvestmentModel addInvestmentModel) async {
    try {
      Response response = await dioClient.post(
        AppURL.kAddInvestmentProjectsURI,
        data: addInvestmentModel.toJson(),
        token: saveUserData.getUserToken()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}
