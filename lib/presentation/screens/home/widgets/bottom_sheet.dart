import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/presentation/screens/home/Home/HomeViewModel.dart';
import 'package:speech/presentation/widgets/AnimatedButton.dart';
import '../../../../core/config/app_colors.dart';
import '../../../widgets/default_text.dart';

class BottomSheetSetFilter extends StatefulWidget {
  const BottomSheetSetFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetSetFilter> createState() => _BottomSheetSetFilterState();
}

class _BottomSheetSetFilterState extends State<BottomSheetSetFilter> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, data, child) => DefaultTabController(
          length: 2,
          child: Card(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultText(
                    title: "filter".tr(),
                    size: 10,
                    color: const Color(0xffB2B5BC),
                  ),
                  TabBar(
                    onTap: (int currentIndex) {
                      index = currentIndex;
                      setState(() {});
                    },
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: "sectorKind".tr(),
                      ),
                      Tab(
                        text: "tourKind".tr(),
                      ),
                    ],
                  ),
                  index == 0
                      ? SizedBox(
                          height: (Provider.of<HomeViewModel>(context)
                                      .sectorModel!
                                      .data!
                                      .length *
                                  50) +
                              100,
                          child: _kind(
                            sector: true,
                            length: data.sectorModel!.data!.length,
                            height: (data.sectorModel!.data!.length * 50),
                            titles: data.sectorModel!.data!,
                          ))
                      : SizedBox(
                          height: (Provider.of<HomeViewModel>(context)
                                      .investmentToursModel!
                                      .data!
                                      .length *
                                  50) +
                              100,
                          child: _kind(
                            sector: false,
                            length: data.investmentToursModel!.data!.length,
                            height:
                                (data.investmentToursModel!.data!.length * 50),
                            titles: data.investmentToursModel!.data!,
                          ),
                        )
                ],
              ),
            ),
          )),
    );
  }

  List checked = [];

  Widget _kind({
    required bool sector,
    required int length,
    required double height,
    titles,
  }) {
    return Consumer<HomeViewModel>(
      builder: (context, data, child) => Column(
        children: [
          SizedBox(
            height: height,
            child: ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: (sector == true)
                          ? data.sectorBool[index]
                          : data.investmentTourBool[index],
                      shape: const CircleBorder(),
                      onChanged: (bool? value) async {
                        if (sector == true) {
                          data.sectorBool[index] = !data.sectorBool[index];
                        } else {
                          data.investmentTourBool[index] =
                              !data.investmentTourBool[index];
                        }
                        data.notifyListeners();
                      },
                    ),
                    DefaultText(
                      title: '${titles[index].title}',
                      size: 14.sp,
                      color: const Color(0xff686A71),
                    )
                  ],
                );
              },
            ),
          ),
          _button(data)
        ],
      ),
    );
  }

  Widget _button(data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: AnimatedButton(
        isLoading: data.isSearchLoading,
        title: 'ok'.tr(),
        backGroundColor: AppColors.primaryColor,
        textColor: Colors.white,
        onPressed: () async {
          await data.getSearchProject(context);
          data.notifyListeners();
          NavigationService.goBack();
        },
      ),
    );
  }
}
