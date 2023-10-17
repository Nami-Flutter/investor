import 'package:flutter/material.dart';
import 'package:speech/data/model/response/OrdersModel.dart';
import '../../../../core/utils/api_checker.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../data/repositries/OrdersRepo.dart';

class OrdersViewModel with ChangeNotifier {

  final OrdersRepo ordersRepo;


  OrdersViewModel({required this.ordersRepo,});


  ///variables
  bool _isCurrentLoading = false;
  bool _isCompletedLoading = false;

  int tabBarIndex=0;

  ///getters
  bool get isCurrentLoading => _isCurrentLoading;
  bool get isCompletedLoading => _isCompletedLoading;

  ///calling APIs Functions

  OrdersModel currentOrdersModel=OrdersModel();
  OrdersModel completedOrdersModel=OrdersModel();





  set currentOrders (OrdersModel ordersModel) {
    notifyListeners();
  }


  void changeIndex(index){
    tabBarIndex=index;
    notifyListeners();
  }


  Future<ApiResponse> getCurrentOrders( context,) async {
    _isCurrentLoading = true;

    ApiResponse responseModel = await ordersRepo.getCurrentOrders();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isCurrentLoading = false;
      currentOrdersModel = OrdersModel.fromJson(responseModel.response?.data);
    }

    else
    {
      _isCurrentLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isCurrentLoading = false;
    notifyListeners();
    return responseModel;
  }



  Future<ApiResponse> getCompletedOrders( context,) async {
    _isCompletedLoading = true;
    ApiResponse responseModel = await ordersRepo.getCompletedOrders();

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isCompletedLoading = false;
      completedOrdersModel = OrdersModel.fromJson(responseModel.response?.data);
    }
    else
    {
      _isCompletedLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isCompletedLoading = false;
    notifyListeners();
    return responseModel;
  }


}
