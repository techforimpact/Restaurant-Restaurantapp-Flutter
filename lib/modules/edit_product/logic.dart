import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import 'state.dart';
import 'dart:math' as math;

class EditProductLogic extends GetxController {
  final state = EditProductState();
  TextEditingController nameController = TextEditingController();
  TextEditingController chefNoteController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();
  TextEditingController discountedPriceController = TextEditingController();
  File? productImage;
  String? downloadURL;

  ///------------------------fetch-categories-open
  List<String> selectedCategories = [];
  List<String> categoriesDropDownList = [];
  fetchCategories() async {
    categoriesDropDownList = [];
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('categories').get();
    if (query.docs.isNotEmpty) {
      query.docs.forEach((element) {
        categoriesDropDownList.add(element.get('name'));
      });
      update();
      log('CategoryList--->>$categoriesDropDownList');
    } else {
      Get.find<GeneralController>().updateFormLoader(false);
    }
  }

  ///------------------------fetch-categories-close

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
        FirebaseFirestore.instance.collection('products').doc(id).update({
          'name': nameController.text,
          'chef_note': chefNoteController.text,
          'category': selectedCategories,
          'quantity': int.parse(quantityController.text.toString()),
          'original_price': double.parse(originalPriceController.text.toString()).toPrecision(2),
          'dis_price': double.parse(discountedPriceController.text.toString()).toPrecision(2),
          'discount':
              double.parse(discountValueController.text.toString()).toInt(),
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

      uploadTask = ref.putFile(productImage!);

      downloadURL = await (await uploadTask).ref.getDownloadURL();
      log('URL---->>$downloadURL');
      try {
        FirebaseFirestore.instance.collection('products').doc(id).set({
          'name': nameController.text,
          'chef_note': chefNoteController.text,
          'category': selectedCategories,
          'quantity': int.parse(quantityController.text.toString()),
          'original_price': int.parse(originalPriceController.text.toString()),
          'dis_price': int.parse(discountedPriceController.text.toString()),
          'discount': int.parse(discountValueController.text.toString()),
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
      return Future.value(uploadTask);
    }
  }

  setData(DocumentSnapshot? productModel) {
    for (int i = 0; i < productModel!.get('category').length; i++) {
      selectedCategories.add(productModel.get('category')[i]);
    }
    nameController = TextEditingController(text: productModel.get('name'));
    chefNoteController =
        TextEditingController(text: productModel.get('chef_note'));
    quantityController =
        TextEditingController(text: productModel.get('quantity').toString());
    originalPriceController = TextEditingController(
        text: productModel.get('original_price').toString());
    discountValueController =
        TextEditingController(text: productModel.get('discount').toString());
    discountedPriceController =
        TextEditingController(text: productModel.get('dis_price').toString());
    downloadURL = productModel.get('image');
  }
}
