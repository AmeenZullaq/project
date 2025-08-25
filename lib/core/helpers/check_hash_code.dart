// import 'dart:convert';
// import 'dart:developer';

// import 'package:qr_flutter/core/helper/sha_hashing.dart';
// import 'package:qr_flutter/features/home/data/models/raw_value_model.dart';

// String stringValue1 = '';
// String stringValue2 = '';
// String myHash = '';
// String checkHashCode(
//   RawValueModel rawValueModel,
//   Map<String, dynamic> metaDataMap,
// ) {
//   log('metaDataMap=======================================$metaDataMap');
//   final stringValue0 = rawValueModel.hash!.substring(0, 1);

//   Map<String, String> quotedMapMetaData = metaDataMap.map(
//     (key, value) => MapEntry('"$key"', '"$value"'),
//   );

//   // final stringMetaData = jsonEncode(quotedMapMetaData);
//   // String escapedJsonString = '"${jsonEncode(metaDataMap).replaceAll('"', '\\"')}"';
// // print(escapedJsonString);
//   stringValue1 = "$quotedMapMetaData";
//   if (stringValue1.contains(': ')) {
//     stringValue1 = stringValue1.replaceAll(': ', ':');
//   }
//   if (stringValue1.contains(', ')) {
//     stringValue1 = stringValue1.replaceAll(', ', ',');
//   }

//   stringValue2 =
//       '${rawValueModel.authorityId!}${rawValueModel.authorityName!}NVSQRAS';
//   // log('quotedMapMetaData=======================================$quotedMapMetaData');
//   log('stringValue1=======================================$stringValue1');
//   log('stringValue2=======================================$stringValue2');
//   formatingHash(stringValue0);
//   return myHash;
// }

// void formatingHash(String stringValue0) {
//   log('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
//   if (stringValue0 == '0') {
//     final stringValue = stringValue1 + hashStringMD5(stringValue2);
//     myHash = stringValue0 + hashStringMD5(stringValue);
//   } else if (stringValue0 == '1') {
//     final stringValue = stringValue1 + hashStringSHA1(stringValue2);
//     myHash = stringValue0 + hashStringSHA1(stringValue);
//   } else if (stringValue0 == '2') {
//     final stringValue = stringValue1 + hashStringSHA256(stringValue2);
//     log('stringValue=======================================$stringValue');
//     log(' hashStringSHA256(stringValue2)=======================================${hashStringSHA256(stringValue2)}');
//     log('hashStringSHA256(stringValue)=======================================${hashStringSHA256(stringValue)}');
//     log('hashStringSHA256(stringValue)=======================================${hashStringSHA256(stringValue)}');
//     myHash = stringValue0 + hashStringSHA256(stringValue);
//   } else if (stringValue0 == '3') {
//     final stringValue = stringValue1 + hashStringSHA384(stringValue2);
//     myHash = stringValue0 + hashStringSHA384(stringValue);
//   } else if (stringValue0 == '4') {
//     final stringValue = stringValue1 + hashStringSHA512(stringValue2);
//     myHash = stringValue0 + hashStringSHA512(stringValue);
//   }
// }

// String convertToEscapedJson(Map<String, dynamic> map) {
//   // First convert to JSON string
//   String jsonString = jsonEncode(map);

//   // Then escape the quotes
//   String escapedString = jsonString.replaceAll('"', '\\"');

//   // Wrap in quotes
//   return '"$escapedString"';
// }
