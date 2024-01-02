import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/presentation/screens/home_layout/HomeLayOutViewModel.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import '../../../core/config/app_Images.dart';
import '../home/Home/HomeViewModel.dart';
import '../setting/SettingViewModel.dart';
import 'package:sizer/sizer.dart';
class HomeLayoutScreen extends StatefulWidget {
  HomeLayoutScreen({Key? key}) : super(key: key);
  @override

  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {


  @override
  void initState() {
    Provider.of<HomeLayoutViewModel>(context,listen: false).currentIndex=0;
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context,listen: false);
    homeViewModel.getFavoriteProjects(context);
    homeViewModel.getSpecialProjects(context);
    homeViewModel.getAllProjects(context);
    homeViewModel.getHomeInvestmentTours(context);
    homeViewModel.getHomeSectors(context);
    Provider.of<SettingViewModel>(context,listen: false).getProfileData(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeLayoutViewModel>(
      builder: (context, value, child) =>
          Scaffold(
        bottomNavigationBar: SizedBox(
            height: 5.7.h,
          child: StylishBottomBar(
            option: AnimatedBarOptions(
              barAnimation: BarAnimation.fade,
              iconStyle: IconStyle.animated,
            ),
            items: [
              BottomBarItem(
                  icon:Icon(Icons.home_filled,size: 3.5.h,),
                  selectedColor: AppColors.primaryColor,
                  unSelectedColor: AppColors.hintText,
                  title:  Image.asset(AppImages.bottom,height: 1.6.h,)
              ),
              BottomBarItem(
                  icon: Icon(Icons.favorite,size: 3.5.h,),
                  selectedColor: AppColors.primaryColor,
                  unSelectedColor: AppColors.hintText,
                  title:  Image.asset(AppImages.bottom,height: 1.6.h,)
              ),
              BottomBarItem(
                  icon:Icon(Icons.handshake,size: 3.5.h,),
                  selectedColor: AppColors.primaryColor,
                  unSelectedColor: AppColors.hintText,
                  title:  Image.asset(AppImages.bottom,height: 1.6.h,)
              ),
              BottomBarItem(
                  icon: Icon(Icons.menu,size: 3.5.h,),
                  selectedColor: AppColors.primaryColor,
                  unSelectedColor: AppColors.hintText,
                  title:  Image.asset(AppImages.bottom,height: 1.6.h,)
              ),

            ],
            fabLocation: StylishBarFabLocation.center,
            currentIndex: Provider.of<HomeLayoutViewModel>(context,listen: false).currentIndex ,
            onTap: (index) {
              Provider.of<HomeLayoutViewModel>(context,listen: false).changeIndex(index: index);

            },
          ),
        ),
        body:Provider.of<HomeLayoutViewModel>(context,listen: false).pages[value.currentIndex],
      ),
    );
  }
}