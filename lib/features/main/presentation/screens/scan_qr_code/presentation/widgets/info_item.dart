// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class InfoItem extends StatelessWidget {
//   final String label;
//   final String value;

//   const InfoItem({
//     super.key,
//     required this.label,
//     required this.value,
//   });

//   bool _isUrl(String text) {
//     return Uri.tryParse(text)?.hasScheme == true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isUrlValue = _isUrl(value);
//     bool isUrlLabel = label.toLowerCase().contains('url');
    
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(
//               text: "$label : ",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 fontSize: 18,
//               ),
//             ),
//             TextSpan(
//               recognizer: (isUrlLabel && isUrlValue) ? (TapGestureRecognizer()
//                 ..onTap = () async {
//                   try {
//                     final uri = Uri.parse(value);
//                     if (await canLaunchUrl(uri)) {
//                       await launchUrl(
//                         uri,
//                         mode: LaunchMode.inAppBrowserView,
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text(
//                             'Cannot open URL - not supported on this device',
//                           ),
//                         ),
//                       );
//                     }
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           'Failed to open URL: $e',
//                         ),
//                       ),
//                     );
//                   }
//                 }) : null,
//               text: value,
//               style: TextStyle(
//                 color: (isUrlLabel && isUrlValue) ? Colors.blue : Colors.black,
//                 fontSize: 16,
//                 decoration: (isUrlLabel && isUrlValue) ? TextDecoration.underline : null,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
