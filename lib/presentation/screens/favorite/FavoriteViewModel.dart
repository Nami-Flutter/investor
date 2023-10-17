import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech/data/repositries/FavoriteRepo.dart';
import 'package:speech/presentation/screens/home/Home/HomeViewModel.dart';
import '../../../../core/utils/api_checker.dart';
import '../../../../data/model/response/base/api_response.dart';

class FavoriteViewModel with ChangeNotifier {

  final FavoriteRepo favoriteRepo;


  FavoriteViewModel({required this.favoriteRepo,});


  ///variables
  bool _isLoading = false;


  ///getters
  bool get isLoading => _isLoading;

  ///calling APIs Functions





  Future<ApiResponse> addFavoriteProject(
      {required int projectId,required  context}) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse responseModel = await favoriteRepo.addFavorite(projectId);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _isLoading = false;

        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(responseModel.response!.data["message"]),
          backgroundColor: Colors.green,));

      Provider.of<HomeViewModel>(context,listen: false).getAllProjects(context);
      Provider.of<HomeViewModel>(context,listen: false).getFavoriteProjects(context);
      notifyListeners();
      _isLoading = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(responseModel.response!.data["message"]),
        backgroundColor: Colors.green,));
      _isLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


}