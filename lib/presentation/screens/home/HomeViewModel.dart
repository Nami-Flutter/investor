import 'package:flutter/material.dart';
import 'package:speech/data/model/response/InvestmentToursModel.dart';
import 'package:speech/data/model/response/ProjectsModel.dart';
import 'package:speech/data/model/response/SectorModel.dart';
import 'package:speech/data/repositries/HomeRepo.dart';
import '../../../../core/utils/api_checker.dart';
import '../../../../data/model/response/base/api_response.dart';

class ProjectsViewModel with ChangeNotifier {

  final ProjectsRepo projectsRepo;


  ProjectsViewModel({required this.projectsRepo,});


  ///variables
  bool _isLoading = false;

  List<bool> sectorBool=[];
  List <bool> investmentTourBool=[];

  ///getters
  bool get isLoading => _isLoading;

  ///calling APIs Functions
  ProjectsModel specialProjectsModel=ProjectsModel();
  ProjectsModel allProjectsModel=ProjectsModel();
  ProjectsModel favouriteProjectsModel=ProjectsModel();
  ProjectsModel projectDetailsModel=ProjectsModel();


  SectorModel? _sectorModel;
  SectorModel? get sectorModel => _sectorModel;

  InvestmentToursModel? _investmentToursModel;
  InvestmentToursModel? get investmentToursModel => _investmentToursModel;



  set sector (SectorModel sectorModel) {
    notifyListeners();

  }  set investmentTour (InvestmentToursModel investmentToursModel) {
    notifyListeners();
  }
  set allProjects (ProjectsModel allProjectsModel) {
    notifyListeners();
  }


  Future<ApiResponse> getSpecialProjects(BuildContext context,) async {
    _isLoading = true;

    ApiResponse responseModel = await projectsRepo.getSpecialProjects();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isLoading = false;
      specialProjectsModel = ProjectsModel.fromJson(responseModel.response?.data);
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


  Future<ApiResponse> getAllProjects(BuildContext context,) async {
    _isLoading = true;

    ApiResponse responseModel = await projectsRepo.getAllProjects();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isLoading = false;
      allProjectsModel = ProjectsModel.fromJson(responseModel.response?.data);
      print(allProjectsModel.data?.length);
      print(allProjectsModel.data?[0].businessPioneer?.email);
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


  Future<ApiResponse> getFavoriteProjects(BuildContext context,) async {
    _isLoading = true;

    ApiResponse responseModel = await projectsRepo.getFavoriteProjects();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200){
      _isLoading = false;
      favouriteProjectsModel = ProjectsModel.fromJson(responseModel.response?.data);
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



  Future<ApiResponse> getHomeSectors(BuildContext context,) async {
    _isLoading = true;
    ApiResponse responseModel = await projectsRepo.getHomeSectors();
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isLoading = false;
      _sectorModel = SectorModel.fromJson(responseModel.response?.data);
      for(int index=0;index<_sectorModel!.data!.length;index++){
        sectorBool.add(false);
      }
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




  Future<ApiResponse> getHomeInvestmentTours(BuildContext context,) async {
    _isLoading = true;
    ApiResponse responseModel = await projectsRepo.getHomeInvestmentTours();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isLoading = false;
      _investmentToursModel = InvestmentToursModel.fromJson(responseModel.response?.data);
      print(_investmentToursModel!.data![0].title);
      for(int index=0;index<_investmentToursModel!.data!.length;index++){
        investmentTourBool.add(false);
      }
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

  Future<ApiResponse> getSearchProject(BuildContext context,) async {
    String sectors='';
    String tours='';
    _isLoading = true;
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
      _isLoading = false;
      allProjectsModel = ProjectsModel.fromJson(responseModel.response?.data);
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

}
