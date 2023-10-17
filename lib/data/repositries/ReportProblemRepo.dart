import 'package:dio/dio.dart';
import 'package:speech/data/model/body/ReportProblemBody.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class ReportProblemRepo{

  final DioClient dioClient;
  final SaveUserData saveUserData;

  ReportProblemRepo({required this.dioClient,required this.saveUserData});

  Future<ApiResponse> getProblems() async {
    try {
      Response response = await dioClient.get(
        AppURL.kGetProblemsURI,
        token: saveUserData.getUserToken(),

      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> reportProblem(ReportProblemBody reportProblemBody) async {
    try {
      Response response = await dioClient.post(
        AppURL.kReportProblemURI,
        data: reportProblemBody.toJson(),
        token: saveUserData.getUserToken()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
