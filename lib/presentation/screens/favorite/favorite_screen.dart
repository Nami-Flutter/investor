import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/config/app_Images.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/injection.dart';
import 'package:speech/presentation/screens/favorite/favorite_container.dart';
import 'package:speech/presentation/screens/home/Home/HomeViewModel.dart';
import 'package:speech/presentation/widgets/appbar.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/presentation/widgets/default_text.dart';

import '../../../core/config/app_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

HomeViewModel homeViewModel=getIt();

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  Future _onRefresh()async{
    Provider.of<HomeViewModel>(context,listen: false).getFavoriteProjects(context);
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =  GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) => RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _onRefresh,
          child: Column(
            children: [
              CustomAppBar(prefixIcon: Text(""), suffixIcon: Text(""),),
              SizedBox(height: .5.h,),
              _filterRow(),
              SizedBox(height: 2.h,),
              _listView(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          DefaultText(title: AppStrings.favorite.tr(),
            size: 17,
            fontWeight: FontWeight.w500,),
          const Expanded(child: SizedBox()),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(AppImages.filterIcon,color: Colors.transparent,),),
        ],
      ),
    );
  }

  Widget _listView(context) {
    return Expanded(
      child:homeViewModel.isFavoriteLoading?
          const Center(child: CircularProgressIndicator() ,)
          :
      ListView.separated(
          itemBuilder: (context, index) => FavoriteContainer(favouriteProjectsModel: Provider.of<HomeViewModel>(context).favouriteProjectsModel,index: index),
          separatorBuilder: (context, index) => SizedBox(height: 2.h,),
          itemCount:Provider.of<HomeViewModel>(context).favouriteProjectsModel.data!.length ),
    );
  }



  Widget _noData() {
    return Center(
        child: Text(
          ("noData").tr(),
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.hintText,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
          maxLines: 4,
        ));
  }
}