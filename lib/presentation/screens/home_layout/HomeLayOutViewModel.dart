import 'package:flutter/material.dart';
import 'package:speech/data/model/response/InvestmentToursModel.dart';
import 'package:speech/data/model/response/SectorModel.dart';


import '../favorite/favorite_screen.dart';
import '../home/Home/home_screen.dart';
import '../orders_chat/orders_screen.dart';
import '../setting/setting_screen.dart';


class HomeLayoutViewModel with ChangeNotifier {

  HomeLayoutViewModel();

  ///variables
  bool _isLoading = false;

  ///getters
  bool get isLoading => _isLoading;


  ///calling APIs Functions



  SectorModel? _sectorModel;
  SectorModel? get sectorModel => _sectorModel;

  InvestmentToursModel? _investmentToursModel;
  InvestmentToursModel? get investmentToursModel => _investmentToursModel;

  List pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const OrdersScreen(),
    SettingScreen(),
  ];

  int currentIndex=0;

  changeIndex({required int index}) {
    currentIndex=index;
    notifyListeners();
  }
}
