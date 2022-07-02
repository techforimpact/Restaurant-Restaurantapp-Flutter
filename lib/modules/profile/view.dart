
import 'package:book_a_table_restaurent/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../edit_profile/view.dart';
import '../home/logic.dart';
import '../image_full_view/view.dart';
import 'logic.dart';
import 'state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileLogic logic = Get.put(ProfileLogic());
  final ProfileState state = Get.find<ProfileLogic>().state;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
      builder: (_homeLogic) => Scaffold(
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
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
              child: ListView(
                children: [
                  ///---heading
                  Text(
                    'My Profile',
                    style: state.headingTextStyle,
                  ),

                  ///---info-detail
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal details',
                          style: state.subHeadingTextStyle,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 7),
                          width: MediaQuery.of(context).size.width,
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///---image
                                Hero(
                                    tag:
                                        '${_homeLogic.currentRestaurantData!.get('image')}',
                                    child: Material(
                                        child: InkWell(
                                      onTap: () {
                                        Get.to(ImageViewScreen(
                                          networkImage:
                                              '${_homeLogic.currentRestaurantData!.get('image')}',
                                        ));
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        height: 90,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .23,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            '${_homeLogic.currentRestaurantData!.get('image')}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ))),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_homeLogic.currentRestaurantData!.get('name')}',
                                      style: state.nameTextStyle,
                                    ),
                                    Text(
                                      '${_homeLogic.currentRestaurantData!.get('email')}',
                                      style: state.detailTextStyle,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    Text(
                                      '${_homeLogic.currentRestaurantData!.get('phone')}',
                                      style: state.detailTextStyle,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    Text(
                                      '${_homeLogic.currentRestaurantData!.get('address')}',
                                      style: state.detailTextStyle,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  ///---help
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Get.toNamed(PageRoutes.help);
                  //     },
                  //     child: Container(
                  //       height: 60,
                  //       width: MediaQuery.of(context).size.width,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 'Help',
                  //                 style: state.tileTitleTextStyle,
                  //               ),
                  //             ),
                  //             const Icon(
                  //               Icons.arrow_forward_ios,
                  //               color: Colors.black,
                  //               size: 20,
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              )),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
          child: InkWell(
            onTap: () {
              Get.to(EditProfilePage(
                restaurantModel: _homeLogic.currentRestaurantData,
              ));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: customThemeColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  'Update',
                  style: state.updateButtonStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
