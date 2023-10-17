import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/presentation/widgets/default_text.dart';
import '../../core/config/app_Images.dart';
import '../../injection.dart';
import '../screens/auth/login/logInViewModel.dart';
LoginViewModel loginViewModel=getIt();
class LogoContainer extends StatefulWidget {
  LogoContainer({Key? key, required this.height, this.arrowBack = false,required this.ctx})
      : super(key: key);
  bool arrowBack;
  double height;
  BuildContext ctx;

  @override
  State<LogoContainer> createState() => _LogoContainerState();
}


class _LogoContainerState extends State<LogoContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    AppImages.backGround,
                  ))),
          child: SvgPicture.asset(AppImages.logo,),
        ),
        widget.arrowBack == false
            ?
        Positioned(
                child: Padding(
                padding: EdgeInsets.only(top: 2.h, right: 1.w, left: 1.w),
                child: Row(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: GestureDetector(
                        onTap:() {
                          if (Localizations.localeOf(widget.ctx).languageCode == 'ar') {
                            widget.ctx.setLocale(const Locale('en'));
                          } else {
                           widget.ctx.setLocale(const Locale('ar'));

                          }
                        },
                        child: DefaultText(
                          title: AppStrings.lang.tr(),
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            : Positioned(
                child: Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          NavigationService.goBack();
                        },
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                          size: 15.sp,
                        )),
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: GestureDetector(
                        onTap:() {
                          if (Localizations.localeOf(widget.ctx).languageCode == 'ar') {
                            widget.ctx.setLocale(const Locale('en'));
                          } else {
                            widget.ctx.setLocale(const Locale('ar'));

                          }
                        },
                        child: DefaultText(
                          title: AppStrings.lang.tr(),
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
      ],
    );
  }


}
