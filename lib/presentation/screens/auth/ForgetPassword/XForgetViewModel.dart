import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/repositries/ForgetPasswordRepo.dart';
import 'package:speech/presentation/screens/auth/ForgetPassword/ConfirmCode.dart';
import 'package:speech/presentation/screens/auth/login/login_screen.dart';
import '../../../../../core/utils/api_checker.dart';
import '../../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/UserModel.dart';
import '../../../../data/repositries/SaveUserData.dart';
import '../../../widgets/SnackBar.dart';
import '../../home_layout/home_layout_screen.dart';
import 'NewPassowrd.dart';



class ForgetPasswordViewModel with ChangeNotifier {
  ForgetPasswordRepo forgetPasswordRepo;
  final SaveUserData saveUserData;
  ForgetPasswordViewModel({required this.forgetPasswordRepo,required this.saveUserData});


  ///variables
  bool _isSendEmailLoading = false;
  bool _isNewPassLoading = false;
  bool _isConfirmCodeLoading = false;


  ///getters
  bool get isSendEmailLoading => _isSendEmailLoading;
  bool get isNewPassLoading => _isNewPassLoading;
  bool get isConfirmCodeLoading => _isConfirmCodeLoading;

  ///calling APIs Functions
  // UserModel? _userModel;
  // UserModel? get userModel => _userModel;

  UserModel userModel=UserModel();


  Future<ApiResponse> sendEmail({required context,required String email}) async {
    _isSendEmailLoading = true;
    notifyListeners();
    ApiResponse responseModel = await forgetPasswordRepo.sendEmail(email:email );
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      snackBar(context: context,message:"codeSentSuccessfully".tr() ,color: Colors.green);
      NavigationService.pushReplacement(const ConfirmCode());
      _isSendEmailLoading = false;
    } else {
      snackBar(context: context,message:"emailCantFound".tr() ,color: Colors.green);
      _isSendEmailLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isSendEmailLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> confirmCode({required context,required String email,required String code}) async {
    _isConfirmCodeLoading = true;
    notifyListeners();
    ApiResponse responseModel = await forgetPasswordRepo.confirmCode(email:email,code: code );
    userModel=UserModel.fromJson(responseModel.response!.data);
    if(userModel.data != null && userModel.code == 200){
      snackBar(context: context, message: userModel.message.toString(), color: Colors.green);
      if(userModel.data?.id != null){
        saveUserData.saveUserId("${userModel.data?.id}");
        saveUserData.saveUserToken("${userModel.data?.token}");
        saveUserData.saveUserName("${userModel.data?.name}");
        saveUserData.saveUserPhone("${userModel.data?.phone}");
        saveUserData.saveUserEmail("${userModel.data?.email}");
      }
      saveUserData.saveLoggedIn(true);
      NavigationService.pushReplacement((const NewPassword()),);
    } else {
      _isConfirmCodeLoading = false;
       snackBar(context: context, message: "Code Or Password Not Correct".tr(), color: Colors.red);
    }
    _isConfirmCodeLoading = false;
    notifyListeners();
    return responseModel;
  }



  Future<ApiResponse> newPassword({required context,required String password}) async {
    _isNewPassLoading = true;
    notifyListeners();
    ApiResponse responseModel = await forgetPasswordRepo.newPassword(password: password );
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      snackBar(context: context,message:"welcome".tr() ,color: Colors.green);
      NavigationService.pushAndRemoveUntil( HomeLayoutScreen());
      _isNewPassLoading = false;
    } else {
      _isNewPassLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isNewPassLoading = false;
    notifyListeners();
    return responseModel;
  }



}
