import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/model/response/InvestmentLibraryModel.dart';
import 'package:speech/data/repositries/InvestmentLibraryRepo.dart';
import 'package:speech/presentation/widgets/SnackBar.dart';
import '../../../../../core/utils/api_checker.dart';
import '../../../../../data/model/response/base/api_response.dart';

class InvestmentLibraryViewModel with ChangeNotifier {

  final InvestmentLibraryRepo investmentLibraryRepo;


  InvestmentLibraryViewModel({required this.investmentLibraryRepo});


  ///variables
  bool _isLoading = false;
  bool _isDownloadLoading = false;

  ///getters
  bool get isLoading => _isLoading;
  bool get isDownloadLoading => _isDownloadLoading;

  ///calling APIs Functions
  InvestmentLibraryModel investmentLibraryModel=InvestmentLibraryModel();




  set investmentLibrary (InvestmentLibraryModel investmentLibraryModel) {
    notifyListeners();
  }


  Future<ApiResponse> getInvestmentLibraries( context,) async {
    _isLoading = true;

    ApiResponse responseModel = await investmentLibraryRepo.getInvestmentLibraries();
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isLoading = false;
      investmentLibraryModel = InvestmentLibraryModel.fromJson(responseModel.response?.data);
    }
    else
    {
      _isLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  var dio =Dio();

  void downloadAttach({required context,required String url,required String name})async{
    _isDownloadLoading=true;
    notifyListeners();
    Directory directory=await getApplicationDocumentsDirectory();
    var response=await dio.get(url,options: Options(responseType: ResponseType.bytes));
    print(directory.path);
    if (response.statusCode == 200) {
      print("data${response.data}");
      await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: '$name.png',isReturnImagePathOfIOS: false);
      NavigationService.goBack();
      snackBar(context: context, message: "fileSaved".tr(), color:Colors.green);
      _isDownloadLoading = false;
      notifyListeners();
    }
    else
    {
      snackBar(context: context, message: "failedSave".tr(), color:Colors.red);
      _isDownloadLoading = false;
    }
    _isDownloadLoading = false;
    notifyListeners();

  }


}
