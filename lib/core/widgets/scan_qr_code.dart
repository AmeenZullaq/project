// import 'dart:developer';
// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:qr_flutter/features/home/presentation/pages/scanning_info_page.dart';

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
//       body: AiBarcodeScanner(
//         controller: controller,
//         onDispose: () {
//           debugPrint("Scanner disposed");
//         },
//         onDetect: (BarcodeCapture capture) {
//           if (capture.barcodes.isNotEmpty) {
//             final String? scannedValue = capture.barcodes.first.rawValue;
//             log("scannedValue: $scannedValue");

//             /// The `Uint8List` image is only available if `returnImage` is set to `true`.
//             final Uint8List? image = capture.image;
//             log("Barcode image: $image");

//             /// row data of the barcode
//             final Object? raw = capture.raw;
//             log("Barcode raw: $raw");

//             /// List of scanned barcodes if any
//             final List<Barcode> barcodes = capture.barcodes;
//             log("Barcode list: $barcodes");
//             if (scannedValue != null) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ScanningInfoPage(info: scannedValue),// you should create it as you ant
//                 ),
//               );
//             }
//           }
//         },
//         validator: (value) {
//           // Optional validation
//           return value.barcodes.isNotEmpty;
//         },
//       ),
//     );
//   }
// }
           