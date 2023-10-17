import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/model/body/ReportProblemBody.dart';
import 'package:speech/data/repositries/ReportProblemRepo.dart';
import '../../../../../core/utils/api_checker.dart';
import '../../../../../data/model/response/PeoblemsModel.dart';
import '../../../../../data/model/response/base/api_response.dart';
import '../../../../widgets/SnackBar.dart';
import '../../../home_layout/home_layout_screen.dart';

class ReportProblemViewModel with ChangeNotifier {
  var problem_id;
  var details;

  final ReportProblemRepo reportProblemRepo;


  ReportProblemViewModel({required this.reportProblemRepo});


  ///variables
  bool _isLoading = false;
  bool _isProblemReportedLoading = false;
  List <DropDownValueModel> problemsList=[  ];

  ///getters
  bool get isLoading => _isLoading;
  bool get isProblemReportedLoading => _isProblemReportedLoading;

  ///calling APIs Functions
  ProblemsModel? _problemsModel;
  ProblemsModel? get problemsModel => _problemsModel;





  set reportProblem (ProblemsModel problemsModel) {
    notifyListeners();
  }



  Future<ApiResponse> getProblems( context,) async {
    _isLoading = true;

    ApiResponse responseModel = await reportProblemRepo.getProblems();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isLoading = false;
      _problemsModel = ProblemsModel.fromJson(responseModel.response?.data);
      for(int i=0;i<_problemsModel!.data!.length;i++){
        problemsList.add(
          DropDownValueModel(
            value: _problemsModel!.data![i].id,
            name: _problemsModel!.data![i].title.toString(),
          ),);
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


  Future<ApiResponse> reportProblems( context) async {
    _isProblemReportedLoading = true;
    notifyListeners();
    final ReportProblemBody body = ReportProblemBody(problem_id:problem_id ,details: details);
    ApiResponse responseModel = await reportProblemRepo.reportProblem(body);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      snackBar(context: context,message:"problemReported".tr() ,color: Colors.green);
        NavigationService.goBack();
      _isProblemReportedLoading = false;
    } else {
      _isProblemReportedLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isProblemReportedLoading = false;
    notifyListeners();
    return responseModel;
  }



}
