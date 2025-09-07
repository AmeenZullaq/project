// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:project/core/firebase_service/database_service.dart';

// class FirestoreService extends DatabaseService {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   @override
//   Future<void> addData({
//     required String path,
//     required Map<String, dynamic> data,
//     String? documentId,
//   }) async {
//     if (documentId != null) {
//       await firestore.collection(path).doc(documentId).set(data);
//     } else {
//       await firestore.collection(path).add(data);
//     }
//   }

//   @override
//   Future<dynamic> getData({
//     required String path,
//     String? documentId,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     if (documentId != null) {
//       final data = await firestore.collection(path).doc(documentId).get();
//       return data.data();
//     } else {
//       Query<Map<String, dynamic>> data = firestore.collection(path);
//       if (queryParameters != null) {
//         if (queryParameters['orderBy'] != null) {
//           data = data.orderBy(
//             queryParameters['orderBy'],
//             descending: queryParameters['descending'],
//           );
//         }
//         if (queryParameters['limit'] != null) {
//           data = data.limit(
//             queryParameters['limit'],
//           );
//         }
//       }
//       final result = await data.get();
//       return result.docs.map((e) => e.data()).toList();
//     }
//   }

//   @override
//   Future<void> updateData({
//     required String path,
//     required String documentId,
//     required Map<String, dynamic> data,
//   }) async {
//     await firestore.collection(path).doc(documentId).update(data);
//   }

//   @override
//   Future<bool> checkIfDataExists({
//     required String path,
//     required String docuementId,
//   }) async {
//     final data = await firestore.collection(path).doc(docuementId).get();
//     return data.exists;
//   }
// }
