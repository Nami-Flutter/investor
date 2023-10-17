import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/app_colors.dart';

class PopUpMenu extends StatelessWidget {
   PopUpMenu({Key? key, required this.popUpMenuButtons,required this.controller}) : super(key: key);

  CustomPopupMenuController controller ;

  List<Widget> popUpMenuButtons;


  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      barrierColor: Colors.black45,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.all(15),
          width: 40.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: popUpMenuButtons),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: -10,
      controller: controller,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: const Icon(Icons.attachment_outlined,
            color: AppColors.primaryColor),
      ),
    );
  }
}
