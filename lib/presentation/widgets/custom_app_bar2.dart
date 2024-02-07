import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';




class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? titleColor;
  final bool isBackButtonExist;
  final VoidCallback? onBackPress;
  // final IconData? icon;
  final bool showIcon;
  final Widget? titleWidget;
  final Widget? leading;
  final double? height;
  final Color? color;

  final List<Widget>? actions;
  final Widget? logo;
  final bool isCenterTitle;
  final Widget? bottomWidget;
  final double? bottomSize;
  final Color? bottomColor;
  final Widget? centerLogo;
  final IconData? iconBack;

  const CustomAppBar2(
      {Key? key,
        this.title,
        this.titleWidget,
        this.centerLogo,
        this.titleColor,
        this.isBackButtonExist = true,
        this.isCenterTitle = false,
        this.showIcon = false,
        // this.icon,
        this.bottomWidget,
        this.bottomSize,
        this.leading,
        this.bottomColor,
        this.height,
        this.logo,
        this.color,
        this.actions,
        this.onBackPress,
        this.iconBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(((height ?? 60) -(bottomSize ??0 )  ).h),
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,//Theme.of(context).backgroundColor,
        title: titleWidget??(title != null
            ? Text(title ?? '',style: TextStyle(fontSize: 14),)
            : centerLogo ?? const SizedBox.shrink()),
        centerTitle: isCenterTitle,
        leading:leading ?? (
            isBackButtonExist
                ? IconButton(icon: Icon(iconBack ?? Icons.arrow_back, color:titleColor?? Colors.black), onPressed: onBackPress ?? () => Navigator.pop(context),)
                // ? IconButton(icon: Icon(iconBack ?? Icons.arrow_back_ios, color:titleColor?? Theme.of(context).primaryColorDark), onPressed: onBackPress ?? () => Navigator.pop(context),)
                : const SizedBox()
        ),
        elevation: 0.0,
        leadingWidth: isBackButtonExist?null:0,
        bottomOpacity: 0.0,
        flexibleSpace: Container(decoration: BoxDecoration(color: color??Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: logo ?? const SizedBox()),

              if(bottomWidget!=null)
              Column(
                children: [
                  Container(
                    height: (bottomSize?? 20).h,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                    ),
                    child: bottomWidget??const SizedBox.expand(),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: actions,
      ),
    );
  }
  @override
  Size get preferredSize => Size(double.maxFinite, height ?? 60);
}
