// import 'package:image/image.dart' as img;

// List<Uint8List> habdleTiffForm(Uint8List byteArray) {
//   final decoder = img.TiffDecoder();
//   decoder.startDecode(byteArray);

//   final info = decoder.info;
//   final frameCount = info?.numFrames ?? 1;

//   final pages = <Uint8List>[];
//   for (int i = 0; i < frameCount; i++) {
//     final imgFrame = decoder.decodeFrame(i);
//     if (imgFrame != null) {
//       pages.add(
//         Uint8List.fromList(
//           img.encodePng(imgFrame),
//         ),
//       );
//     }
//   }
//   return pages;
// }
