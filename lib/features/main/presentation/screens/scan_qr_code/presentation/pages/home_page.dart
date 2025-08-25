// import 'dart:ui';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: Text(LocaleKeys.nVSDocumentAuthenticator.tr()),
//         centerTitle: true,
//         leading: PopupMenuButton(
//           itemBuilder: (context) {
//             return [
//               PopupMenuItem(
//                 child: Text(LocaleKeys.english.tr()),
//                 onTap: () {
//                   context.setLocale(const Locale('en'));
//                 },
//               ),
//               PopupMenuItem(
//                 child: Text(LocaleKeys.arabic.tr()),
//                 onTap: () {
//                   context.setLocale(const Locale('ar'));
//                 },
//               ),
//             ];
//           },
//         ),
//         flexibleSpace: ClipRect(
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Image.asset(
//                 Assets.imagesBackground,
//                 fit: BoxFit.cover,
//               ),
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
//                 child: Container(
//                   color: Colors.white.withOpacity(0.5),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               Assets.imagesBackground,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     height: 50.h,
//                   ),
//                   Align(
//                     alignment: Alignment.topCenter,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20.r),
//                       child: Image.asset(
//                         Assets.imagesQrCodeIcon,
//                         color: Colors.black,
//                         fit: BoxFit.cover,
//                         width: 170.w,
//                         height: 170.h,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50.h,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.pushNamed(context, AppRoutes.scannerPage);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 20.w, vertical: 10.h),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12.r),
//                         color: AppColors.primary,
//                       ),
//                       child: Text(
//                         LocaleKeys.scanDocumentQR.tr(),
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           color: AppColors.cardBorderColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 220.h,
//                   ),
//                   Text(
//                     LocaleKeys.copyright.tr(),
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
