import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/model/response/UserModel.dart';
import 'package:speech/presentation/screens/splash_screen.dart';
import 'package:speech/presentation/widgets/SnackBar.dart';
import '../../../../../core/utils/api_checker.dart';
import '../../../../../data/model/response/base/api_response.dart';
import '../../../data/repositries/SettingRepo.dart';

class SettingViewModel with ChangeNotifier {

  final SettingRepo settingRepo;

  SettingViewModel({required this.settingRepo});


  ///variables
  bool _isLoading = false;


  ///getters
  bool get isLoading => _isLoading;

  ///calling APIs Functions

  UserModel userModel=UserModel();




  Future<ApiResponse> logout( context) async {
    snackBar(context: context,message: 'loggedOutSuccessfully'.tr(), color: Colors.green);
    NavigationService.pushAndRemoveUntil(const SplashScreen());
    _isLoading = true;
    notifyListeners();
    ApiResponse responseModel = await settingRepo.logout();
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> getProfileData( context) async {
    _isLoading = true;
    ApiResponse responseModel = await settingRepo.getProfileData();
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {

      userModel=UserModel.fromJson(responseModel.response!.data);
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }



}
