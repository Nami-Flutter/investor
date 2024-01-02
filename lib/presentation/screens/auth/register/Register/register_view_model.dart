import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/presentation/screens/home_layout/home_layout_screen.dart';
import 'package:speech/presentation/screens/setting/SettingViewModel.dart';
import 'package:speech/presentation/widgets/SnackBar.dart';
import '../../../../../core/utils/api_checker.dart';
import '../../../../../data/model/body/RegisterBody.dart';
import '../../../../../data/model/response/UserModel.dart';
import '../../../../../data/model/response/base/api_response.dart';
import '../../../../../data/repositries/SaveUserData.dart';
import '../../../../../data/repositries/auth_repo.dart';


class RegisterViewModel with ChangeNotifier {
  var phone,national_num,password,email ,sectorId,categoriesId;
  final AuthRepo authRepo;
  final SaveUserData saveUserData;
  RegisterViewModel({required this.saveUserData, required this.authRepo});


  ///variables
  bool _isLoading = false;

  ///getters
  bool get isLoading => _isLoading;

  ///calling APIs Functions
  UserModel? _userModel;
  UserModel? get userModel => _userModel;


  set registerData (RegisterBody registerBody) {
    notifyListeners();
  }
   var imagePath="";
  var c="0";

  ImagePicker picker = ImagePicker();

  pickImage({required String pickType}) async {
    if (pickType == "camera") {
      var image= await picker.pickImage(source: ImageSource.camera);
      if(image!=null){
        imagePath=image.path;
        c="dd";
      }
      notifyListeners();
    } else {
      var image= await picker.pickImage(source: ImageSource.gallery);
      if(image!=null){
        imagePath=image.path;
        c="dd";
      }
       notifyListeners();
    }
  }

  Future<ApiResponse> registerApi({required context,required nationality,required name,required experience}) async {
    print('data=>>>>>${categoriesId}   $sectorId');
     File? file;
       file = File(imagePath);

      FormData data;
      if(imagePath==""){
        data = FormData.fromMap(
            {"email": email,
              "name": name,
              "type":"investor" ,
              'password': password,
              'password_confirmation': password,
              "national_num":national_num ,
              "phone":phone,
              "nationalty":nationality,
              "experience":experience,
              "category_id":categoriesId,
              "sector_id":sectorId,
            });
      }else{
     data = FormData.fromMap(
        {"email": email,
          "name": name,
          "type":"investor" ,
          'password': password,
          'password_confirmation': password,
          "national_num":national_num ,
          "phone":phone,
          "nationalty":nationality,
          "experience":experience,
          "category_id":categoriesId,
          "sector_id":sectorId,
          "image": await MultipartFile.fromFile(file.path),
        });}
    _isLoading = true;
    notifyListeners();
     ApiResponse responseModel = await authRepo.registerRepo(data);
    if (responseModel.response!=null) {
      _isLoading = false;
       _userModel = UserModel.fromJson(responseModel.response?.data);
      if( _userModel?.code == 200){
        if(_userModel?.data?.email != null){
          saveUserData.saveUserId("${_userModel?.data?.id}");
          saveUserData.saveUserToken("${_userModel?.data?.token}");
          saveUserData.saveUserName("${_userModel?.data?.name}");
          saveUserData.saveUserPhone("${_userModel?.data?.phone}");
          saveUserData.saveUserEmail("${_userModel?.data?.email}");
        }
        snackBar(context: context,message: "accountDataRegisteredSuccessfully".tr(), color:  Colors.green);
        saveUserData.saveLoggedIn(true);
        NavigationService.pushAndRemoveUntil( HomeLayoutScreen());
      }else{
        if(_userModel?.code == 405){
          snackBar(context: context,message: "alreadyRegistered".tr(), color: Colors.red);
        }
        else{
          snackBar(context: context,message: _userModel!.message!.toString(), color: Colors.red);
        }
      }
    } else {
        snackBar(context: context,message:"emailUsed".tr(), color: Colors.red);
        NavigationService.goBack();
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> updateProfile({required context,required nationality,required name,required experience}) async {

    File? file;
    file = File(imagePath);
    FormData data;
    if(imagePath=="") {
       data = FormData.fromMap(
          {"email": email,
            "name": name,
            "phone": Provider
                .of<SettingViewModel>(context, listen: false)
                .userModel
                .data!
                .phone,
            "national_num": national_num,
            "nationalty": nationality,
            "experience": experience,
            "category_id": categoriesId,
            "sector_id": sectorId,
          });
    }else{
       data = FormData.fromMap(
          {"email": email,
            "name": name,
            "phone": Provider
                .of<SettingViewModel>(context, listen: false)
                .userModel
                .data!
                .phone,
            "national_num": national_num,
            "nationalty": nationality,
            "experience": experience,
            "category_id": categoriesId,
            "sector_id": sectorId,
            "image": await MultipartFile.fromFile(file.path),
          });
    }
    _isLoading = true;
    notifyListeners();

    ApiResponse responseModel = await authRepo.updateProfile(data);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _isLoading = false;
      _userModel = UserModel.fromJson(responseModel.response?.data);
      if(_userModel != null && _userModel?.code == 200){
        if(_userModel?.data?.email != null){
          saveUserData.saveUserId("${_userModel?.data?.id}");
          saveUserData.saveUserToken("${_userModel?.data?.token}");
          saveUserData.saveUserName("${_userModel?.data?.name}");
          saveUserData.saveUserPhone("${_userModel?.data?.phone}");
          saveUserData.saveUserEmail("${_userModel?.data?.email}");
        }
        snackBar(context: context,message: "updateDone".tr(), color:  Colors.green);
        NavigationService.pushAndRemoveUntil( HomeLayoutScreen());
      }else{

        _isLoading = false;
        if(_userModel != null && _userModel?.code == 302){
          snackBar(context: context,message: responseModel.response!.data["message"]["error"], color: Colors.red);
        }else{
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text(_userModel?.message ?? ""),
            backgroundColor: Colors.red,));
        }

      }
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


}