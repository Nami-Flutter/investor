import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';



class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled".tr();
              break;
            case DioErrorType.connectionTimeout:
              errorDescription = "Connection timeout with API server".tr();
              break;
            case DioErrorType.unknown:
              errorDescription = "Connection to API server failed due to internet connection".tr();
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
              "Receive timeout in connection with API server".tr();
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server".tr();
              break;
            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
              break;
            case DioExceptionType.badResponse:
              // TODO: Handle this case.
              break;
            case DioExceptionType.connectionError:
              // TODO: Handle this case.
              break;
          }
        } else {
          errorDescription = "Unexpected error".tr();
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
