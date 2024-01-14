import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/presentation/widgets/default_text.dart';

import '../../../../core/config/app_Images.dart';

class WhoAreWeScreen extends StatelessWidget {
  const WhoAreWeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: 25.h,
                      width: double.infinity,
                      color: AppColors.primaryColor,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         fit: BoxFit.fill,
                      //         image: AssetImage(
                      //           AppImages.backGround,
                      //         ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                               NavigationService.goBack();
                              },
                              icon: const Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.white,
                              )),
                          Expanded(
                              child: SvgPicture.asset(
                                AppImages.logo,
                            color: Colors.white,
                            height: 5.h,
                          )
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.transparent,
                              ))
                        ],
                      ),
                    ),
                    Positioned(
                        top: 8.h,
                        right: 3.w,
                        child: Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Image.asset(AppImages.backGround2),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                        title: AppStrings.whoAreWe.tr(),
                        size: 14,
                        fontWeight: FontWeight.w400),
                    SizedBox(height: 1.h,),
                    DefaultText(
                        title:
                            "نحن نظاماً متكاملاً للتواصل بين طالبي الاستثمار والمستثمرين، نوفر منصة مريحة وموثوقة لعرض المشاريع والبحث عن المستثمرين المناسبين للاستثمار فيها.",
                        size: 12,
                        fontWeight: FontWeight.w400,
                        maxLines: 4,
                        color: AppColors.hintText),
                    DefaultText(
                      title:
                          "كما نساعد رواد الأعمال على نشر مشاريعهم بكل سهولة ويسر وعرض جميع المعلومات المهمة المتعلقة بالمشروع بطريقة واضحة وشاملة.",
                      size: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.hintText,
                      maxLines: 4,
                    ),
                    DefaultText(
                      title:
                          "تتوفر في التطبيق فرص فريدة للمستثمرين للاستثمار في مشاريع مختلفة ومجالات متنوعة، وذلك بفضل وسيلة التواصل المتاحة بين طالبي الإستثمار والمستثمر.",
                      size: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.hintText,
                      maxLines: 4,
                    ),
                    DefaultText(
                      title:
                          "كما يتميز التطبيق بأنه يوفر وسيلة موثوقة للتفاوض على شروط الاستثمار والتفاصيل الأخرى بشكل مريح وآمن، مما يسمح للمستثمرين بالحصول على تجربة استثمارية مريحة ومربحة.",
                      size: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.hintText,
                      maxLines: 4,
                    ),
                    DefaultText(
                      title:
                          "كما يمنح التطبيق المستثمرين حرية الاطلاع على جميع التفاصيل المتعلقة بالمشروع ومالكه.",
                      size: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.hintText,
                      maxLines: 4,
                    ),
                    DefaultText(
                      title:
                          "وبفضل هذه المزايا، يمكن القول إن تطبيق الاستثمار الخاص بك يجمع بين الراحة والموثوقية والأمان، ويوفر لطالبي الاستثمار والمستثمرين فرصة فريدة للاستثمار وجني الأرباح بشكل مربح وآمن.",
                      size: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.hintText,
                      maxLines: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
