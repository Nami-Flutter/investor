import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speech/data/model/body/AddInvestementModel.dart';
import 'package:speech/data/repositries/ProjectDetailsRepo.dart';
import 'package:speech/presentation/screens/home/investment_success_screen.dart';
import 'package:speech/presentation/widgets/SnackBar.dart';
import '../../../../core/utils/api_checker.dart';
import '../../../../data/model/response/OrdersStoreModel.dart';
import '../../../../data/model/response/ProjectDetailsModel.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../home_layout/home_layout_screen.dart';
import '../../pay_web_view/pay_web_view.dart';

class ProjectDetailsViewModel with ChangeNotifier {

  final ProjectDetailsRepo projectDetailsRepo;


  ProjectDetailsViewModel({required this.projectDetailsRepo,});


  ///variables
  bool _isLoading = false;


  ProjectDetailsModel projectDetailsModel=ProjectDetailsModel();


  ///getters
  bool get isLoading => _isLoading;

  ///calling APIs Functions

  set specialProjects(ProjectDetailsModel projectDetailsModel) {
    notifyListeners();
  }

  set addInvestment(AddInvestmentModel addInvestmentModel) {
    notifyListeners();
  }



  OrdersStoreModel ordersStoreModel =OrdersStoreModel();

  Future<ApiResponse> addInvestmentRequest(
      {required int business_pioneer_id,required int project_id,required  context}) async {
    _isLoading = true;
    notifyListeners();
    final AddInvestmentModel _body = AddInvestmentModel(business_pioneer_id: business_pioneer_id ,project_id: project_id);
    ApiResponse responseModel = await projectDetailsRepo.addInvestment(_body);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _isLoading = false;
      ordersStoreModel = OrdersStoreModel.fromJson(responseModel.response?.data);
      snackBar(context: context, message:'successfullyAddedInvestment'.tr() , color:  Colors.green);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const InvestmentSuccess(),));
      Navigator.push(context, MaterialPageRoute(builder: (context) => PayWebViewScreen(id: ordersStoreModel.data?.order?.id ?? 0,),));

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