// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../core/config/app_colors.dart';
// import '../widgets/default_text.dart';
//
//
// class TakePhotoBottomSheet extends StatefulWidget {
//    TakePhotoBottomSheet({Key? key}) : super(key: key);
//
//   @override
//   State<TakePhotoBottomSheet> createState() => _TakePhotoBottomSheetState();
// }
//
// class _TakePhotoBottomSheetState extends State<TakePhotoBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))
//       ),
//       padding: EdgeInsets.symmetric(vertical: 4.h),
//       child: Row(
//         children: [
//           Expanded(
//             child: GestureDetector(
//               onTap: (){
//                 Navigator.pop(context);
//                 pickImage(pickType:"camera");
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.camera_alt, size: 20.w,color: AppColors.primaryColor),
//                   DefaultText(
//                     title: "الكاميرا",
//                     size: 22,
//                     color: AppColors.normalText,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: GestureDetector(
//               onTap: (){
//                 Navigator.pop(context);
//                 pickImage(pickType:"gallery");
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.camera, size: 20.w,color: AppColors.primaryColor),
//                   DefaultText(
//                     title: "معرض الصور",
//                     size: 22,
//                     color: AppColors.normalText,
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
