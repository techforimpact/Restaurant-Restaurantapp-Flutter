// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:math' as math;
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// import '../../controller/general_controller.dart';
// import '../../controller/post_service.dart';
// import '../../controller/url.dart';
// import '../../utils/colors.dart';
// import '../home/logic.dart';
// import 'state.dart';

// class AddTableLogic extends GetxController {
//   final state = AddBiteBagState();

//   TextEditingController tableNameController = TextEditingController();
//   TextEditingController tableChairsCountController = TextEditingController();
//   TextEditingController tableNoteController = TextEditingController();
//   File? tableImage;
//   String? downloadURL;

//   ///------------------------fetch-categories-open
//   List<String> categoriesDropDownList = [];


//   ///------------------------fetch-categories-close
//   ///
//   ///---random-string-open
//   String chars =
//       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//   math.Random rnd = math.Random();

//   String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
//       length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

//   Future<firebase_storage.UploadTask?> uploadFile(
//       File? file, BuildContext context) async {
//     if (file == null) {
//       Get.find<GeneralController>().updateFormLoader(false);

//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('No file was selected'),
//       ));

//       return null;
//     }

//     firebase_storage.UploadTask uploadTask;

//     final String pictureReference =
//         "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
//     firebase_storage.Reference ref =
//         firebase_storage.FirebaseStorage.instance.ref().child(pictureReference);

//     uploadTask = ref.putFile(tableImage!);

//     downloadURL = await (await uploadTask).ref.getDownloadURL();
//     log('URL---->>$downloadURL');
//     try {
//       FirebaseFirestore.instance.collection('tables').add({
//         'restaurant': Get.find<HomeLogic>().currentRestaurantData!.get('name'),
//         'restaurant_id': Get.find<HomeLogic>().currentRestaurantData!.get('id'),
//         'table_chairs_count': int.parse(tableChairsCountController.text.toString()),
//         'table_name': tableNameController.text,
//         'table_note': tableNoteController.text,
//         'image': downloadURL,
//         'id': getRandomString(5),
//         'reservation_from':DateTime.now(),
//         'reservation_to':DateTime.now().add(const Duration(hours: 1)),
//         'is_reserve': false
//       });
//       Get.find<GeneralController>().updateFormLoader(false);
//       List fcmTokenList = [];
//       QuerySnapshot fcmTokenQuery = await FirebaseFirestore.instance
//           .collection('users')
//           .where('role', isEqualTo: 'customer')
//           .get();
//       for (var element in fcmTokenQuery.docs) {
//         fcmTokenList.add(element.get('token'));
//       }
//       for (var element in fcmTokenList) {
//         postMethod(
//             context,
//             fcmService,
//             {
//               'notification': <String, dynamic>{
//                 'body': 'Here is New Bite Bag For You',
//                 'title': 'ALERT!',
//                 "click_action": "FLUTTER_NOTIFICATION_CLICK",
//               },
//               'priority': 'high',
//               'to': element
//             },
//             false,
//             method1);
//       }
//       Get.back();
//       Get.snackbar(
//         'SUCCESS!',
//         'Table Added Successfully...',
//         colorText: Colors.white,
//         backgroundColor: customThemeColor.withOpacity(0.7),
//         snackPosition: SnackPosition.BOTTOM,
//         margin: const EdgeInsets.all(15),
//       );
//     } on FirebaseAuthException catch (e) {
//       Get.find<GeneralController>().updateFormLoader(false);
//       Get.snackbar(
//         e.code,
//         '',
//         colorText: Colors.white,
//         backgroundColor: customThemeColor.withOpacity(0.7),
//         snackPosition: SnackPosition.BOTTOM,
//         margin: const EdgeInsets.all(15),
//       );
//       log(e.toString());
//     }
//     return Future.value(uploadTask);
//   }
// }
