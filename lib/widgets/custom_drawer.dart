
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/general_controller.dart';
import '../modules/home/logic.dart';
import '../modules/home/state.dart';
import '../route_generator.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({Key? key}) : super(key: key);

  @override
  _MyCustomDrawerState createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
          ),
          ListTile(
            onTap: () {
              Get.toNamed(PageRoutes.profile);
            },
            leading: SvgPicture.asset('assets/drawerProfileIcon.svg'),
            title: Text('Profile', style: state.drawerTitleTextStyle),
          ),
          ListTile(
            onTap: () {
              Get.toNamed(PageRoutes.allOrders);
            },
            leading: SvgPicture.asset('assets/drawerCartIcon.svg'),
            title: Text('Orders', style: state.drawerTitleTextStyle),
          ),
          ListTile(
            onTap: () {
              Get.toNamed(PageRoutes.allProducts);
            },
            leading: SvgPicture.asset('assets/Favourites.svg'),
            title: Text('Products', style: state.drawerTitleTextStyle),
          ),
          ListTile(
            onTap: () {
              Get.toNamed(PageRoutes.privacyPolicy);
            },
            leading: SvgPicture.asset('assets/drawerPrivacyIcon.svg'),
            title: Text('Useful Links', style: state.drawerTitleTextStyle),
          ),
          // ListTile(
          //   onTap: () {
          //     Get.toNamed(PageRoutes.help);
          //   },
          //   leading: Image.asset('assets/Chat_bubble.png'),
          //   title: Text('Contact Us', style: state.drawerTitleTextStyle),
          // ),
          const Spacer(),
          ListTile(
            onTap: () {
              Get.find<GeneralController>().firebaseAuthentication.signOut();
            },
            title: Row(
              children: [
                Text('Sign-out', style: state.drawerTitleTextStyle),
                const Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.white,
                  size: 25,
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
        ],
      ),
    );
  }
}
