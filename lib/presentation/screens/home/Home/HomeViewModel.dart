import 'package:flutter/material.dart';
import 'package:speech/data/model/response/InvestmentToursModel.dart';
import 'package:speech/data/model/response/ProjectsModel.dart';
import 'package:speech/data/model/response/SectorModel.dart';
import 'package:speech/data/repositries/HomeRepo.dart';
import '../../../../../core/utils/api_checker.dart';
import '../../../../../data/model/response/base/api_response.dart';

class HomeViewModel with ChangeNotifier {

  final ProjectsRepo projectsRepo;


  HomeViewModel({required this.projectsRepo,});


  ///variables
  bool _isLoading = false;
  bool _isFavoriteLoading = false;
  bool _isSearchLoading = false;
  bool _isAllProjectsLoading = false;
  bool _isSpecialLoading = false;
  bool _isSectorLoading = false;
  bool _isToursLoading = false;

  List<bool> sectorBool=[];
  List <bool> investmentTourBool=[];

  ///getters
  bool get isLoading => _isLoading;
  bool get isFavoriteLoading => _isFavoriteLoading;
  bool get isSearchLoading => _isSearchLoading;
  bool get isAllProjectsLoading => _isAllProjectsLoading;
  bool get isSpecialLoading => _isSpecialLoading;
  bool get isSectorLoading => _isSectorLoading;
  bool get isToursLoading => _isToursLoading;

  ///calling APIs Functions
  ProjectsModel specialProjectsModel=ProjectsModel();
  ProjectsModel allProjectsModel=ProjectsModel();
  ProjectsModel favouriteProjectsModel=ProjectsModel();


  SectorModel? _sectorModel;
  SectorModel? get sectorModel => _sectorModel;

  InvestmentToursModel? _investmentToursModel;
  InvestmentToursModel? get investmentToursModel => _investmentToursModel;



  set sector (SectorModel sectorModel) {
    notifyListeners();

  }
  set investmentTour (InvestmentToursModel investmentToursModel) {
    notifyListeners();
  }
  set allProjects (ProjectsModel allProjectsModel) {
    notifyListeners();
  }


  Future<ApiResponse> getSpecialProjects( context,) async {
    _isSpecialLoading = true;

    ApiResponse responseModel = await projectsRepo.getSpecialProjects();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isSpecialLoading = false;
      specialProjectsModel = ProjectsModel.fromJson(responseModel.response?.data);
    }

    else
    {
      _isSpecialLoading = false;
    }
    _isSpecialLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ApiResponse> getAllProjects( context,) async {
    _isAllProjectsLoading = true;
    ApiResponse responseModel = await projectsRepo.getAllProjects();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {

      allProjectsModel = ProjectsModel.fromJson(responseModel.response?.data);
      getFavoriteProjects(context);
      _isAllProjectsLoading = false;
    }
    else
    {
      _isAllProjectsLoading = false;
    }
    _isAllProjectsLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ApiResponse> getFavoriteProjects( context,) async {
    _isFavoriteLoading = true;

    ApiResponse responseModel = await projectsRepo.getFavoriteProjects();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200){
      _isFavoriteLoading = false;
      favouriteProjectsModel = ProjectsModel.fromJson(responseModel.response?.data);
    }

    else
    {
      _isFavoriteLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isFavoriteLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ApiResponse> getHomeSectors( context,) async {
    _isSectorLoading = true;
    ApiResponse responseModel = await projectsRepo.getHomeSectors();
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isSectorLoading = false;
      _sectorModel = SectorModel.fromJson(responseModel.response?.data);
      for(int index=0;index<_sectorModel!.data!.length;index++){
        sectorBool.add(false);
      }
    }
    else
    {
      _isSectorLoading = false;
    }
    _isSectorLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> getHomeInvestmentTours( context,) async {
    _isToursLoading = true;
    ApiResponse responseModel = await projectsRepo.getHomeInvestmentTours();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isToursLoading = false;
      _investmentToursModel = InvestmentToursModel.fromJson(responseModel.response?.data);
      print(_investmentToursModel!.data![0].title);
      for(int index=0;index<_investmentToursModel!.data!.length;index++){
        investmentTourBool.add(false);
      }
    }

    else
    {
      _isToursLoading = false;

    }
    _isToursLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> getSearchProject( context,) async {
    String sectors='';
    String tours='';
    _isSearchLoading = true;
    for(int i=0;i<sectorBool.length;i++){
      if(sectorBool[i]==true){
        sectors=(sectors=='')?sectors+'${i+1}':sectors+',${i+1}';
      }
    }
    for(int i=0;i<investmentTourBool.length;i++){
      if(investmentTourBool[i]==true){
        tours=(tours=='')?tours+'${i+1}':tours+',${i+1}';
      }
    }
    notifyListeners();
    ApiResponse responseModel = await projectsRepo.getSearchProject(tourId:tours,StringsectorIds: sectors);

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isSearchLoading = false;
      allProjectsModel = ProjectsModel.fromJson(responseModel.response?.data);
    }

    else
    {
      _isSearchLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isSearchLoading = false;
    notifyListeners();
    return responseModel;
  }

}
