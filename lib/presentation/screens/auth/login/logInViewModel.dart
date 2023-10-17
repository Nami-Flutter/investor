import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speech/core/routing/navigation_services.dart';
import '../../../../core/utils/api_checker.dart';
import '../../../../data/model/body/LoginBody.dart';
import '../../../../data/model/response/UserModel.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/repositries/SaveUserData.dart';
import '../../../../data/repositries/auth_repo.dart';
import '../../../widgets/SnackBar.dart';
import '../../home_layout/home_layout_screen.dart';


class LoginViewModel with ChangeNotifier {
  final AuthRepo authRepo;
  final SaveUserData saveUserData;
  LoginViewModel({required this.saveUserData, required this.authRepo});


  ///variables
  bool _isLoading = false;

  bool checked=false;

  ///getters
  bool get isLoading => _isLoading;



  ///calling APIs Functions
  UserModel? _userModel;
  UserModel? get userModel => _userModel;


  changeChecked({required bool check}){
    checked=check;
    notifyListeners();
  }


  Future<ApiResponse> login(String email, String password, context) async {
    _isLoading = true;
    notifyListeners();
    final LoginBody body = LoginBody(email: email,password: password);
    ApiResponse responseModel = await authRepo.login(body);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _userModel = UserModel.fromJson(responseModel.response?.data);
      if(_userModel != null && _userModel?.code == 200){
        if(_userModel?.data?.id != null){
          saveUserData.saveUserId("${_userModel?.data?.id}");
          saveUserData.saveUserToken("${_userModel?.data?.token}");
          saveUserData.saveUserName("${_userModel?.data?.name}");
          saveUserData.saveUserPhone("${_userModel?.data?.phone}");
          saveUserData.saveUserEmail("${_userModel?.data?.email}");
        }
        if(checked==true){
          saveUserData.saveRememberMe(true);
          saveUserData.saveUserPassword(password);
        }else{
          saveUserData.saveRememberMe(false);
        }
        snackBar(context: context,message: 'loggedInSuccessfully'.tr(),color: Colors.green );
        saveUserData.saveLoggedIn(true);
        NavigationService.pushAndRemoveUntil(const HomeLayoutScreen(),);
      }else{
        if(_userModel?.code ==422||_userModel?.code==401){
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text('Invalid credential'.tr()),
            backgroundColor: Colors.red,));
        }else{
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text(_userModel?.message ?? ""),
            backgroundColor: Colors.red,));
        }

      }
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


}