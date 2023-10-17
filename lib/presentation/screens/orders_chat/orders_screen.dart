import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_Images.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/data/model/response/OrdersModel.dart';
import 'package:speech/presentation/screens/orders_chat/OrdersViewModel.dart';
import '../../../core/routing/navigation_services.dart';
import '../../widgets/default_text.dart';
import 'chat_screens/chat_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<OrdersViewModel>(context, listen: false).tabBarIndex = 0;
    Provider.of<OrdersViewModel>(context, listen: false)
        .getCurrentOrders(context);
    Provider.of<OrdersViewModel>(context, listen: false)
        .getCompletedOrders(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersViewModel>(
      builder: (context, data, child) => DefaultTabController(
          length: 2,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _appBar(),
                SizedBox(
                  height: 3.h,
                ),
                Provider.of<OrdersViewModel>(context, listen: false)
                            .tabBarIndex ==
                        0
                    ? _orders(
                                isLoading: data.isCompletedLoading ,
                                number: data.completedOrdersModel.data!.length,
                                orderImage: AppImages.completeOrders,
                                ordersModel: data.completedOrdersModel,
                              )
                    :  _orders(
                              isLoading:data.isCurrentLoading ,
                                ordersModel: data.currentOrdersModel,
                                number: data.currentOrdersModel.data!.length,
                                orderImage: AppImages.currentOrders,
                              ),
              ],
            ),
          )),
    );
  }

  Widget _appBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.backGround), fit: BoxFit.fill)),
      child: Column(
        children: [
          _imageAppBar(),
          _tabBar(),
        ],
      ),
    );
  }

  Widget _imageAppBar() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: SvgPicture.asset(AppImages.logo, height: 3.h));
  }

  Widget _tabBar() {
    return TabBar(
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
      unselectedLabelColor: Colors.grey.shade400,
      indicatorColor: const Color(0xffE78F2C),
      unselectedLabelStyle: const TextStyle(color: Colors.green),
      onTap: (int index) {
        Provider.of<OrdersViewModel>(context, listen: false).changeIndex(index);
      },
      labelColor: Colors.white,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
      tabs: [
        Tab(
          text: AppStrings.completedOrders.tr(),
        ),
        Tab(
          text: AppStrings.currentOrders.tr(),
        ),
      ],
    );
  }

  Widget _orders({
    required OrdersModel ordersModel,
    required int number,
    required String orderImage,
    required bool isLoading,

  }) {
    return Expanded(
      child: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : ordersModel.data!.isEmpty
          ? _noData()
          :


      ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 1.5.h,
        ),
        itemCount: number,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              NavigationService.push(
                ChatScreen(
                  ordersModel: ordersModel,
                  index: index,
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 2.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(orderImage, height: 3.h),
                        SizedBox(
                          width: 1.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                title: ordersModel.data![index].project!.name
                                    .toString(),
                                size: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              DefaultText(
                                title: ordersModel.data![index].investor!.name
                                    .toString(),
                                size: 13,
                                color: AppColors.normalText,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(AppImages.calenderIcon),
                        SizedBox(
                          width: .5.w,
                        ),
                        DefaultText(
                          title: ordersModel.data![index].created_at.toString(),
                          size: 13,
                          color: AppColors.hintText,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Divider(
                      height: 4.h,
                      thickness: .5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  title: "قيمة الإستثمار :",
                                  size: 13,
                                  color: AppColors.boldText,
                                  fontWeight: FontWeight.w400,
                                ),
                                DefaultText(
                                  title: ordersModel
                                      .data![index].project!.categories!.title
                                      .toString(),
                                  size: 13,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  title: "نوع الجولة :",
                                  size: 13,
                                  color: AppColors.boldText,
                                  fontWeight: FontWeight.w400,
                                ),
                                DefaultText(
                                  title: ordersModel.data![index].project!
                                      .investmentTour!.title
                                      .toString(),
                                  size: 13,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _noData() {
    return Center(
        child: Text(
      ("noData").tr(),
      style: TextStyle(
        fontSize: 22.sp,
        color: AppColors.hintText,
        fontWeight: FontWeight.w300,
      ),
      textAlign: TextAlign.center,
      maxLines: 4,
    ));
  }
}
