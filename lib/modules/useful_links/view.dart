import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';
import 'logic.dart';
import 'state.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final PrivacyPolicyLogic logic = Get.put(PrivacyPolicyLogic());

  final PrivacyPolicyState state = Get.find<PrivacyPolicyLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 15,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Useful Links',
          style: state.appBarTextStyle,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: customThemeColor.withOpacity(0.19),
                        blurRadius: 40,
                        spreadRadius: 0,
                        offset: const Offset(
                            0, 22), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              launch('http://www.bookatable.in/privacy-policy');
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/privacy_policy.png'),
                                Text(
                                  'Privacy Policy',
                                  style: state.titleTextStyle,
                                )
                              ],
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              launch('http://www.bookatable.in/terms');
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/terms_n_conditions.png'),
                                Text(
                                  'Terms & Conditions',
                                  style: state.titleTextStyle,
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              launch('http://www.bookatable.in/privacy-policy');
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/refund_policy.png'),
                                Text(
                                  'Refund Policy',
                                  style: state.titleTextStyle,
                                )
                              ],
                            ),
                          )),
                          const Spacer()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
