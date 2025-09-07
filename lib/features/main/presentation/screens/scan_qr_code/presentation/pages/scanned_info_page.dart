// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:qr_flutter/core/helper/alert_dialog.dart';
// import 'package:qr_flutter/core/widgets/custom_app_bar.dart';
// import 'package:qr_flutter/features/home/data/models/meta_model.dart';
// import 'package:qr_flutter/features/home/domain/entitis/raw_value_entity.dart';
// import 'package:qr_flutter/features/home/presentation/widgets/info_item.dart';
// import 'package:qr_flutter/generated/locale_keys.g.dart';

// class ScannedInfoPage extends StatefulWidget {
//   final List<KeyValueObject> listKeyValueModel;
//   final RawValueEntity rawValueEntity;
//   final bool isHashVerified;
//   const ScannedInfoPage({
//     super.key,
//     required this.listKeyValueModel,
//     required this.rawValueEntity,
//     required this.isHashVerified,
//   });

//   @override
//   State<ScannedInfoPage> createState() => _ScannedInfoPageState();
// }

// class _ScannedInfoPageState extends State<ScannedInfoPage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.isHashVerified) {
//         showAlertDialog(
//           context: context,
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.verified,
//                 color: Colors.green,
//                 size: 64.sp,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 LocaleKeys.metadataVerified.tr(),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Center(
//                 child: Text(
//                   LocaleKeys.ok.tr(),
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       } else {
//         showAlertDialog(
//           context: context,
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.cancel,
//                 color: Colors.red,
//                 size: 64.sp,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 LocaleKeys.qrCodeTampered.tr(),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Center(
//                 child: Text(
//                   LocaleKeys.ok.tr(),
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: Text(LocaleKeys.qRCodeInfo.tr()),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InfoItem(
//               label: LocaleKeys.authorityName.tr(),
//               value: widget.rawValueEntity.authorityName ?? '',
//             ),
//             InfoItem(
//               label: LocaleKeys.documentURL.tr(),
//               value: widget.rawValueEntity.documentURL ?? '',
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: List.generate(
//                 widget.listKeyValueModel.length,
//                 (index) => InfoItem(
//                   label: widget.listKeyValueModel[index].key ?? '',
//                   value: widget.listKeyValueModel[index].value ?? '',
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 25.sp,
//             ),
//             if (widget.isHashVerified) ...[
//               Text(
//                 LocaleKeys.metadataVerified.tr(),
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 LocaleKeys.clickUrlForDocument.tr(),
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 LocaleKeys.verifyMetadataWithDocument.tr(),
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ] else ...[
//               Text(
//                 LocaleKeys.qrCodeTampered.tr(),
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
