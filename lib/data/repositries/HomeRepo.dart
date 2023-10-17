import 'package:dio/dio.dart';
import 'package:speech/data/repositries/SaveUserData.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';


class ProjectsRepo{

  final DioClient dioClient;
  final SaveUserData saveUserData;

  ProjectsRepo({required this.dioClient,required this.saveUserData});

  Future<ApiResponse> getSpecialProjects() async {
    try {
      Response response = await dioClient.get(
        AppURL.kSpecialProjectsURI,
      token: saveUserData.getUserToken(),

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getAllProjects() async {
    try {
      Response response = await dioClient.get(
        AppURL.kAllProjectsURI,
      token: saveUserData.getUserToken(),
      // token:"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2ludmVzdG9yLmFzY2l0LnNhL2FwaS9pbnZlc3Rvci9hdXRoL2xvZ2luIiwiaWF0IjoxNjkzOTA5MzM3LCJleHAiOjE2OTM5MTI5MzcsIm5iZiI6MTY5MzkwOTMzNywianRpIjoidnRQZHFLMTJQTWx4eURsWCIsInN1YiI6IjUiLCJwcnYiOiI4MzcyM2RhNWRmY2EwYjllNmZjNDZkZmI3Njc2ZDM4ZGVhN2ZlNDQ0In0.bcBxsa1mzx8VSpWDc-HqiXbDiXr4Dw1v-0iNN-RzcYM"

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getFavoriteProjects() async {
    try {
      Response response = await dioClient.get(
        AppURL.kFavoriteProjectsURI,
      token: saveUserData.getUserToken(),

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  Future<ApiResponse> getHomeSectors() async {
    try {
      Response response = await dioClient.get(
        AppURL.kGetHomeSectorsURI,
        token: saveUserData.getUserToken(),

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getHomeInvestmentTours() async {
    try {
      Response response = await dioClient.get(
        AppURL.kGetHomeInvestmentToursURI,
        token: saveUserData.getUserToken(),

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getSearchProject({required String tourId,required String StringsectorIds}) async {
    try {
      Response response = await dioClient.get(
       "${AppURL.kGetSearchProjectURI}?investment_tour_id=$tourId&sector_ids=$StringsectorIds",
        token: saveUserData.getUserToken(),

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




}