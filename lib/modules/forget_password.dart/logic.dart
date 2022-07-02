import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class ForgetPasswrodLogic extends GetxController {
  final state = ForgetPasswordState();

  String? email;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
