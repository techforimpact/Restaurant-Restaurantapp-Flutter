// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// import 'state.dart';

// class TableDetailLogic extends GetxController {
//   final state = TableDetailState();

//   int? cartCount = 1;
//   updateCartCount(int? newValue) {
//     cartCount = newValue;
//     update();
//   }

//   double? averageRating = 0;
//   currentProduct(DocumentSnapshot? productModel, String? collection) async {
//     QuerySnapshot query = await FirebaseFirestore.instance
//         .collection(collection!)
//         .where("id", isEqualTo: productModel!.get('id'))
//         .get();

//     if (query.docs.isNotEmpty) {
//       log('PRODUCT---->>>${query.docs[0].get('name')}');
//       if (query.docs[0].get('ratings').length > 0) {
//         for (int i = 0; i < query.docs[0].get('ratings').length; i++) {
//           averageRating = query.docs[0].get('ratings')[i] + averageRating;
//         }
//         averageRating = averageRating! / query.docs[0].get('ratings').length;
//       }
//       update();
//     } else {}
//   }
// }
