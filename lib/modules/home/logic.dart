import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

import '../../controller/general_controller.dart';
import 'state.dart';

class HomeLogic extends GetxController {
  final state = HomeState();

  DocumentSnapshot? currentRestaurantData;
  double? averageRating = 0;
  double? totalEarning = 0;
  int? totalOrder = 0;
  currentRestaurant() async {
    averageRating = 0;
    totalEarning = 0;
    totalOrder = 0;
    log('pressed--->>$totalEarning');
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('restaurants')
        .where("uid_id",
            isEqualTo: Get.find<GeneralController>().boxStorage.read('uid'))
        .get();

    if (query.docs.isNotEmpty) {
      log('RESTAURANT---->>>${query.docs[0].get('name')}');
      if (query.docs[0].get('ratings').length > 0) {

        averageRating = 0;
        for (int i = 0; i < query.docs[0].get('ratings').length; i++) {
          averageRating = query.docs[0].get('ratings')[i] + averageRating;
        }
        averageRating = averageRating! / query.docs[0].get('ratings').length;
      }
      currentRestaurantData = query.docs[0];
      update();
    } else {}
    QuerySnapshot queryForOrders = await FirebaseFirestore.instance
        .collection('orders')
        .where("restaurant_id", isEqualTo: query.docs[0].get('id'))
        .get();
    if (queryForOrders.docs.isNotEmpty) {



      totalEarning = 0;
      totalOrder = 0;
      for (var element in queryForOrders.docs) {
        if((element.get('date_time') as Timestamp).toDate()
            .isAfter(DateTime.now().subtract(const Duration(days: 8)))){
          totalOrder = totalOrder!+1;
          totalEarning =
              totalEarning! + double.parse(element.get('net_price').toString());
        }
      }
      update();
      if (int.parse(query.docs[0].get('commission').toString()) > 0) {
        totalEarning = (totalEarning! -
                (totalEarning! *
                    (int.parse(query.docs[0].get('commission').toString()) /
                        100)))
            .toPrecision(2);
        update();
      }
      update();
    } else {}
  }

  AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();
  void handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
    update();
  }

  ScrollController scrollController = ScrollController();

  int? tabIndex = 0;
  updateTabIndex(int? newValue) {
    tabIndex = newValue;
    update();
  }

  User? currentUserForFcm;
  String? fcmToken;
  updateToken() async {
    currentUserForFcm = FirebaseAuth.instance.currentUser;
    if (!Get.find<GeneralController>().boxStorage.hasData('fcmToken')) {
      await FirebaseMessaging.instance.getToken().then((value) {
        fcmToken = value;
        Get.find<GeneralController>().boxStorage.write('fcmToken', 'Exist');
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserForFcm!.uid)
          .update({'token': fcmToken});
    }
  }
}
