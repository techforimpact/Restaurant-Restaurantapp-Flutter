import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../controller/general_controller.dart';
import '../../controller/post_service.dart';
import '../../controller/url.dart';
import '../../utils/colors.dart';
import '../home/logic.dart';
import 'state.dart';
import 'dart:math' as math;

class AddProductLogic extends GetxController {
  final state = AddProductState();

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
      for (var element in query.docs) {
        categoriesDropDownList.add(element.get('name'));
      }
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
      File? file, BuildContext context) async {
    if (file == null) {
      Get.find<GeneralController>().updateFormLoader(false);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));

      return null;
    }

    firebase_storage.UploadTask uploadTask;

    final String pictureReference =
        "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(pictureReference);

    uploadTask = ref.putFile(productImage!);

    downloadURL = await (await uploadTask).ref.getDownloadURL();
    log('URL---->>$downloadURL');
    try {
      FirebaseFirestore.instance.collection('products').doc().set({
        'restaurant': Get.find<HomeLogic>().currentRestaurantData!.get('name'),
        'restaurant_id': Get.find<HomeLogic>().currentRestaurantData!.get('id'),
        'name': nameController.text.toString().capitalize.toString(),
        'chef_note': chefNoteController.text,
        'category': selectedCategories,
        'quantity': int.parse(quantityController.text.toString()),
        'original_price': double.parse(originalPriceController.text.toString())
            .toPrecision(2),
        'dis_price': double.parse(discountedPriceController.text.toString())
            .toPrecision(2),
        'discount':
            double.parse(discountValueController.text.toString()).toInt(),
        'image': downloadURL,
        'total_rates': 0,
        'search_key': setSearchParam(
            nameController.text.toString().capitalize.toString()),
        'ratings': [],
        'id': getRandomString(5),
        'couponStatus': false,
        'couponCode': '',
        'couponValue': 0,
        'couponType':'',
      });
      Get.find<GeneralController>().updateFormLoader(false);

      List<String> fcmTokenList = [];
      QuerySnapshot fcmTokenQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'customer')
          .get();
      for (var element in fcmTokenQuery.docs) {
        try {
        fcmTokenList.add(element.get('token'));
          
        } catch (e) {
          print('exception in get token');
        }
      }
      for (var element in fcmTokenList) {
        postMethod(
            context,
            fcmService,
            {
              'notification': <String, dynamic>{
                'body': '${Get.find<HomeLogic>().currentRestaurantData!.get('id')} :  ${Get.find<HomeLogic>().currentRestaurantData!.get('name')} just uploaded new items, check them out before they are gone.',
                'title': 'PRODUCT ALERT !!',
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
              },
              'priority': 'high',
              'to': element
            },
            false,
            method1);
      }
      Get.back();
      Get.snackbar(
        'SUCCESS!',
        'Product Added Successfully...',
        colorText: Colors.white,
        backgroundColor: customThemeColor.withOpacity(0.7),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(15),
      );
    } on FirebaseAuthException catch (e) {
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

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      i = (caseNumber.length) + 1;
    }
    return temp;
  }
}
