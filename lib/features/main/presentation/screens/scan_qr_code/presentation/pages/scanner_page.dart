// import 'dart:convert';
// import 'dart:ui';
// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/core/constants/app_routes.dart';
// import 'package:qr_flutter/core/constants/assets.dart';
// import 'package:qr_flutter/core/helper/check_hash_code.dart';
// import 'package:qr_flutter/core/widgets/custom_app_bar.dart';
// import 'package:qr_flutter/features/home/data/models/raw_value_model.dart';
// import 'package:qr_flutter/generated/locale_keys.g.dart';

// class ScannerPage extends StatefulWidget {
//   const ScannerPage({super.key});

//   @override
//   State<ScannerPage> createState() => _ScannerPageState();
// }

// class _ScannerPageState extends State<ScannerPage> {
//   final MobileScannerController controller = MobileScannerController(
//     detectionSpeed: DetectionSpeed.noDuplicates,
//   );

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: Text(LocaleKeys.nVSDocumentAuthenticator.tr()),
//         centerTitle: true,
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
//       body: Flexible(
//         child: AiBarcodeScanner(
//           controller: controller,
//           hideSheetDragHandler: true,
//           hideSheetTitle: true,
//           hideGalleryButton: true,
//           onDispose: () {
//             debugPrint("Scanner disposed");
//           },
//           validator: (value) {
//             // Optional validation
//             return value.barcodes.isNotEmpty;
//           },
//           onDetect: (BarcodeCapture capture) {
//             if (capture.barcodes.isNotEmpty) {
//               final String? rawValue = capture.barcodes.first.rawValue;
//               // log("scannedValue: $rawValue");

//               // /// The `Uint8List` image is only available if `returnImage` is set to `true`.
//               // final Uint8List? image = capture.image;
//               // log("Barcode image: $image");

//               // /// row data of the barcode
//               // final Object? raw = capture.raw;
//               // log("Barcode raw: $raw");

//               // /// List of scanned barcodes if any
//               // final List<Barcode> barcodes = capture.barcodes;
//               // log("Barcode list: $barcodes");
//               if (rawValue != null) {
//                 final json = jsonDecode(rawValue);
//                 RawValueModel rawValueModel = RawValueModel.fromBarcode(json);
//                 String myFormattedhash =
//                     checkHashCode(rawValueModel, json['MetaData']);
//                 Navigator.pushReplacementNamed(
//                   context,
//                   AppRoutes.scanningInfoPage,
//                   arguments: {
//                     "listKeyValueModel": rawValueModel.listKeyValueModel,
//                     "rawValueEntity": rawValueModel.toEntity(),
//                     "isHashVerified":
//                         myFormattedhash == rawValueModel.hash ? true : false,
//                   },
//                 );
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
