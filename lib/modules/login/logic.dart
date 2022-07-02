import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final state = LoginState();

  String? loginPhoneNumber;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
