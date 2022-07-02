import 'package:get/get.dart';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import 'state.dart';
import 'dart:math' as math;

class EditTableLogic extends GetxController {
  final state = EditTableState();
  TextEditingController tableNoteController = TextEditingController();
  TextEditingController tableNameController = TextEditingController();
  TextEditingController tableChairsCountController = TextEditingController();
  TextEditingController tableReserveFromController = TextEditingController();
  TextEditingController tableReserveToController = TextEditingController();
  File? tableImage;
  String? downloadURL;


  ///---random-string-open
  String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  math.Random rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  Future<firebase_storage.UploadTask?> uploadFile(
      File? file, BuildContext context, String? id) async {
    if (file == null) {
      try {
        FirebaseFirestore.instance.collection('tables').doc(id).update({
            'table_name': tableNameController.text,
          'table_note': tableNoteController.text,
          'table_chairs_count': int.parse(tableChairsCountController.text.toString()),
          'image': downloadURL,
        });
        Get.find<GeneralController>().updateFormLoader(false);
        Get.back();
        Get.back();
        Get.snackbar(
          'SUCCESS!',
          'Product Updated Successfully...',
          colorText: Colors.white,
          backgroundColor: customThemeColor.withOpacity(0.7),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
        );
      } on FirebaseException catch (e) {
        Get.find<GeneralController>().updateFormLoader(false);
        Get.snackbar(
          e.code,
          '',
          colorText: Colors.white,
          backgroundColor: customThemeColor.withOpacity(0.7),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
        );
        log(e.toString());
      }
      return null;

    } else {
      firebase_storage.UploadTask uploadTask;

      final String pictureReference =
          "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(pictureReference);

      uploadTask = ref.putFile(tableImage!);

      downloadURL = await (await uploadTask).ref.getDownloadURL();
      log('URL---->>$downloadURL');
      try {
        FirebaseFirestore.instance.collection('tables').doc(id).set({
          'table_name': tableNameController.text,
          'table_note': tableNoteController.text,
          'table_chairs_count': int.parse(tableChairsCountController.text.toString()),
          'image': downloadURL,
        },SetOptions(merge: true));
        Get.find<GeneralController>().updateFormLoader(false);
        Get.back();
        Get.back();
        Get.snackbar(
          'SUCCESS!',
          'Product Updated Successfully...',
          colorText: Colors.white,
          backgroundColor: customThemeColor.withOpacity(0.7),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
        );
      } on FirebaseException catch (e) {
        Get.find<GeneralController>().updateFormLoader(false);
        Get.snackbar(
          e.code,
          '',
          colorText: Colors.white,
          backgroundColor: customThemeColor.withOpacity(0.7),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
        );
        log(e.toString());
      }
      return Future.value(uploadTask);
    }
  }

  setData(DocumentSnapshot? productModel) {
 
    tableNoteController =
        TextEditingController(text: productModel!.get('table_note'));
     tableNameController =
        TextEditingController(text: productModel.get('table_name'));
          tableChairsCountController =
        TextEditingController(text: productModel.get('table_chairs_count').toString());   
    tableReserveFromController =
        TextEditingController(text: productModel.get('reservation_from').toDate().toString().substring(0,16));
    tableReserveToController =
        TextEditingController(text: productModel.get('reservation_to').toDate().toString().substring(0,16));
    downloadURL = productModel.get('image');
    
  }
}
