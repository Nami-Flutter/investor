import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:speech/data/model/response/SectorModel.dart';
import 'package:speech/data/repositries/personal_knowledge_repo.dart';
import '../../../../../core/utils/api_checker.dart';
import '../../../../../data/model/response/CategoriesModel.dart';
import '../../../../../data/model/response/base/api_response.dart';

class PersonalKnowledgeViewModel with ChangeNotifier {

  final PersonalKnowledgeRepo personalKnowledgeRepo;
  PersonalKnowledgeViewModel({required this.personalKnowledgeRepo,});


  ///variables
  bool _isSectorLoading = false;
  bool _isCatLoading = false;

  ///getters
  bool get isSectorLoading => _isSectorLoading;
  bool get isCatLoading => _isCatLoading;

  ///calling APIs Functions
  SectorModel? _sectorModel;
  SectorModel? get sectorModel => _sectorModel;
  CategoriesModel? _categoriesModel;
  CategoriesModel? get categoriesModel => _categoriesModel;


  List <DropDownValueModel> sectorList=[  ];
  List <DropDownValueModel> categoriesList=[  ];


  set personalKnowledge (SectorModel sectorModel) {
    notifyListeners();
  }


  Future<ApiResponse> getSectors( context,) async {
    _isSectorLoading = true;
    notifyListeners();

    ApiResponse responseModel = await personalKnowledgeRepo.getSectors();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isSectorLoading = false;
      _sectorModel = SectorModel.fromJson(responseModel.response?.data);
     for(int i=0;i<_sectorModel!.data!.length;i++){
       sectorList.add(
         DropDownValueModel(
         value: _sectorModel!.data![i].id,
         name: _sectorModel!.data![i].title.toString(),
       ),);
     }
    }

    else
    {
    _isSectorLoading = false;
    ApiChecker.checkApi(context, responseModel);
    }
    _isSectorLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ApiResponse> getCategories( context,) async {
    _isCatLoading = true;
    notifyListeners();

    ApiResponse responseModel = await personalKnowledgeRepo.getCategories();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isCatLoading = false;
      _categoriesModel = CategoriesModel.fromJson(responseModel.response?.data);
     for(int i=0;i<_categoriesModel!.data!.length;i++){
       categoriesList.add(
         DropDownValueModel(
         value: _categoriesModel!.data![i].id,
         name: _categoriesModel!.data![i].title.toString(),
       ),);
     }
    }

    else
    {
    _isCatLoading = false;
    ApiChecker.checkApi(context, responseModel);
    }
    _isCatLoading = false;
    notifyListeners();
    return responseModel;
  }
  }
