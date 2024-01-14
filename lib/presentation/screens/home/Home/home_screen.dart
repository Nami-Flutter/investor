import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/presentation/screens/home/Home/HomeViewModel.dart';
import 'package:speech/presentation/screens/home/widgets/SpecialContainer.dart';
import 'package:speech/presentation/screens/home/widgets/home_container.dart';
import 'package:speech/presentation/screens/setting/SettingViewModel.dart';
import 'package:speech/presentation/widgets/SnackBar.dart';
import 'package:speech/presentation/widgets/appbar.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_Images.dart';
import '../../../../core/config/app_strings.dart';
import '../../../../data/model/response/ProjectsModel.dart';
import '../../../widgets/default_text.dart';
import '../../notifications/notifications_screen.dart';
import '../widgets/bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeViewModel>(context, listen: false)
          .getAllProjects(context);
      if(  Provider.of<HomeViewModel>(context,listen: false).sectorModel?.data==null||Provider.of<HomeViewModel>(context,listen: false).investmentToursModel?.data==null){
        Provider.of<HomeViewModel>(context, listen: false)
            .getHomeInvestmentTours(context);
        Provider.of<HomeViewModel>(context, listen: false)
            .getHomeSectors(context);
      }
    });

    // TODO: implement initState
    super.initState();
  }

  Future _onRefresh()async{
    Provider.of<HomeViewModel>(context, listen: false)
        .getSpecialProjects(context);
    Provider.of<HomeViewModel>(context, listen: false)
        .getAllProjects(context);
    if(  Provider.of<HomeViewModel>(context,listen: false).sectorModel?.data==null||Provider.of<HomeViewModel>(context,listen: false).investmentToursModel?.data==null){
      Provider.of<HomeViewModel>(context, listen: false)
          .getHomeInvestmentTours(context);
      Provider.of<HomeViewModel>(context, listen: false)
          .getHomeSectors(context);
    }

    if(Provider.of<SettingViewModel>(context,listen: false).userModel.data==null){
      Provider.of<SettingViewModel>(context,listen: false).getProfileData(context);
    }

  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =  GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) => SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: (){
            return  _onRefresh();
          },
          child: Column(
            children: [
              _appBar(),
              SizedBox(
                height: 3.h,
              ),

              _specialProjectsContainer(value),


                _filterRow(value.allProjectsModel),



              _allProjects(value,value.allProjectsModel)
            ],
          ),
        ),
      ),
    );
  }



  Widget _appBar(){
   return CustomAppBar(
      prefixIcon: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 17,
          child: IconButton(
              onPressed: () {},
              icon: ImageIcon(AssetImage(AppImages.searchIcon,),color: Colors.transparent,))),
      suffixIcon: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 17,
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(),
                    ));
              },
              icon:
              ImageIcon(AssetImage(AppImages.notificationIcon)))),
    );
  }


  Widget  _specialProjectsContainer(value){
    return SizedBox(
      height:  value.specialProjectsModel?.data?.length == 0 ? 0 : 20.h,
      child:
      value.isSpecialLoading==true?
      const Center(child:  CircularProgressIndicator(),)
      :

      ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
          value.specialProjectsModel.data!.isEmpty?
          _noData()
              :
          value.specialProjectsModel.data==null?
          _noInternet():
              Row(
            children: [
              SizedBox(
                width: 4.w,
              ),
              FavContainer(
                specialProjectsModel: value.specialProjectsModel,index: index),
            ],
          ),
          itemCount: value.specialProjectsModel?.data?.length
      )

      ,
    );
}


  Widget _filterRow(ProjectsModel projectsModel){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          DefaultText(
            title: AppStrings.availableChances.tr(),
            size: 14,
            maxLines: 4,
            fontWeight: FontWeight.w400,
          ),
          const Expanded(child: SizedBox()),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                  onTap: () {
                    Provider.of<HomeViewModel>(context,listen: false).sectorModel?.data==null||Provider.of<HomeViewModel>(context,listen: false).investmentToursModel?.data==null?
                          snackBar(context: context, message: "checkYourInternet".tr(), color: Colors.red)
                    :
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30))),
                      isScrollControlled: true,
                      barrierColor: Colors.black45,
                      context: context,
                      builder: (context) =>
                          const BottomSheetSetFilter(),
                    );
                  },
                  child: Image.asset(AppImages.filterIcon))),
        ],
      ),
    );

}


  Widget _allProjects(value, ProjectsModel projectsModel){
    return  Expanded(
      child:  value.isAllProjectsLoading==true?
      const Center(child:  CircularProgressIndicator(),)
          :
      value.allProjectsModel.data!.isEmpty?
          _noData()
          :
      value.allProjectsModel.data==null?
      _noInternet():
      ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 2.h,
          ),
          itemCount: value.allProjectsModel.data!.length,
          itemBuilder: (context, index) =>
              AllProjectsContainer(
                allProjects:projectsModel,
                index: index,
              )),
    );

 }

 Widget _noInternet(){
    return Center(
      child: DefaultText(
          title:"checkYourInternet".tr() ,
          size: 13.sp,
        fontWeight: FontWeight.w300,
        color: AppColors.normalText,
      ),
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
