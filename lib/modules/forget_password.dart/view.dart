
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import 'logic.dart';
import 'state.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ForgetPasswrodLogic logic = Get.put(ForgetPasswrodLogic());
  final ForgetPasswordState state = Get.find<ForgetPasswrodLogic>().state;

  final GlobalKey<FormState> _forgetPasswordFormKey = GlobalKey<FormState>();

  bool? obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswrodLogic>(
      builder: (_forgetPasswordLogic) => GestureDetector(
        onTap: () {
          Get.find<GeneralController>().focusOut(context);
        },
        child: GetBuilder<GeneralController>(
          builder: (_generalController) => ModalProgressHUD(
            inAsyncCall: _generalController.formLoader!,
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            child: Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: _forgetPasswordFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Image.asset(
                            "assets/logo.png",
                            width: MediaQuery.of(context).size.width * .5,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),

                        ///---email-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: _forgetPasswordLogic.emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              labelStyle: state.labelTextStyle,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.5))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.5))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: customThemeColor)),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field Required';
                              } else if (!GetUtils.isEmail(
                                  _forgetPasswordLogic.emailController.text)) {
                                return 'Enter Valid Email';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),

                        ///---login-button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: InkWell(
                            onTap: () async {
                              _generalController.focusOut(context);
                              if (_forgetPasswordFormKey.currentState!
                                  .validate()) {
                                try {
                                  await _forgetPasswordLogic.firebaseAuth
                                      .sendPasswordResetEmail(
                                          email: _forgetPasswordLogic
                                              .emailController.text);

                                  Get.back();

                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset passwprd send to your mail')));
                                } on FirebaseAuthException catch (_) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_.message??'exception')));
                                  
                                }

                              }
                            },
                            child: Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: customThemeColor,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: customThemeColor.withOpacity(0.19),
                                    blurRadius: 40,
                                    spreadRadius: 0,
                                    offset: const Offset(
                                        0, 22), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text("Get Password",
                                    style: state.buttonTextStyle),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
