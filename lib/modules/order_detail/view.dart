import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/fcm_controller.dart';
import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_dotted_divider.dart';
import '../image_full_view/view.dart';
import 'logic.dart';
import 'state.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key? key, this.orderModel}) : super(key: key);
  DocumentSnapshot? orderModel;

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final OrderDetailLogic logic = Get.put(OrderDetailLogic());
  final OrderDetailState state = Get.find<OrderDetailLogic>().state;

  double? commissionDiscount = 0;

  getNetPrice() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('restaurants')
        .where("uid_id",
            isEqualTo: Get.find<GeneralController>().boxStorage.read('uid'))
        .get();

    setState(() {
      commissionDiscount =
          (double.parse(widget.orderModel!.get('net_price').toString()) *
                  (int.parse(query.docs[0].get('commission').toString()) / 100))
              .toPrecision(2);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNetPrice();
  }

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
          'Order',
          style: state.appBarTextStyle,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
          child: ListView(
            children: [
              ///---image
              Hero(
                  tag: '${widget.orderModel!.get('restaurant_image')}',
                  child: Material(
                      child: InkWell(
                    onTap: () {
                      Get.to(ImageViewScreen(
                        networkImage:
                            '${widget.orderModel!.get('restaurant_image')}',
                      ));
                    },
                    child: Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: customThemeColor.withOpacity(0.19),
                          blurRadius: 40,
                          spreadRadius: 0,
                          offset:
                              const Offset(0, 22), // changes position of shadow
                        ),
                      ], borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          '${widget.orderModel!.get('restaurant_image')}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))),

              ///---name
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Text('${widget.orderModel!.get('restaurant')}',
                    textAlign: TextAlign.center,
                    style: state.restaurantNameTextStyle),
              ),

              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 40,
                          spreadRadius: 0,
                          offset:
                              const Offset(0, 22), // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Customer Name',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: customGreenColor)),
                            Text(
                                widget.orderModel!
                                    .get('customerName')
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: customTextGreyColor)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('isTakeAway? ',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: customGreenColor)),
                            Text(
                                widget.orderModel!.get('isTakeAway').toString() ==
                                        'true'
                                    ? 'Yes'
                                    : 'No',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: customTextGreyColor)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      
                      ],
                    ),
                  ),
                ),
              ),

              // ///---otp
              // Center(
              //   child: Container(
              //     height: 40,
              //     width: MediaQuery.of(context).size.width * .5,
              //     decoration: BoxDecoration(
              //         color: customThemeColor,
              //         borderRadius: BorderRadius.circular(30)),
              //     child: Center(
              //       child: Text(
              //         'Order OTP: ${widget.orderModel!.get('otp')}',
              //         style: state.otpTextStyle,
              //       ),
              //     ),
              //   ),
              // ),

              ///---products
              Wrap(
                children: List.generate(
                    widget.orderModel!.get('product_list').length, (index) {
                  return FadedSlideAnimation(
                    beginOffset: const Offset(0, 0.3),
                    endOffset: const Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19),
                         
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              ///---image
                              Hero(
                                tag:
                                    '${widget.orderModel!.get('product_list')[index]['image']}',
                                child: Material(
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(
                                        '${widget.orderModel!.get('product_list')[index]['image']}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              ///---detail
                              Expanded(
                                  child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ///---name
                                      Text(
                                          '${widget.orderModel!.get('product_list')[index]['name']}',
                                          style: state.productNameTextStyle),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .01,
                                      ),

                                      ///---price
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ///---original-price
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  'Rs ${widget.orderModel!.get('product_list')[index]['original_price']}',
                                                  style: state
                                                      .productPriceTextStyle!
                                                      .copyWith(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough)),
                                            ),
                                          ),

                                          ///---dis_price
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  'Rs ${widget.orderModel!.get('product_list')[index]['dis_price']}',
                                                  style: state
                                                      .productPriceTextStyle!
                                                      .copyWith(
                                                          color:
                                                              customThemeColor)),
                                            ),
                                          ),

                                          ///---quantity
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19),
                                                    color: customThemeColor),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 2, 0, 2),
                                                  child: Center(
                                                    child: Text(
                                                        'Qty ${widget.orderModel!.get('product_list')[index]['quantity']}',
                                                        style: state
                                                            .productPriceTextStyle!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              //  SizedBox(
              //   height: MediaQuery.of(context).size.height*.3,
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .5,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ///---total-price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price',
                    style: state.billLabelTextStyle,
                  ),
                  Text(
                    'Rs ${widget.orderModel!.get('total_price')}',
                    style: state.billValueTextStyle,
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              ///---total-discount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount',
                    style: state.billLabelTextStyle,
                  ),
                  Text(
                    'Rs ${widget.orderModel!.get('total_discount')}',
                    style: state.billValueTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),

              ///---gross-price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gross Total',
                    style: state.billLabelTextStyle,
                  ),
                  Text(
                    'Rs ${widget.orderModel!.get('net_price')}',
                    style: state.billValueTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),

              ///---commission
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Commission',
                    style: state.billLabelTextStyle,
                  ),
                  Text(
                    'Rs $commissionDiscount',
                    style: state.billValueTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),

              ///---net-price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net Price',
                    style: state.billLabelTextStyle,
                  ),
                  Text(
                    'Rs ${widget.orderModel!.get('net_price')}',
                    style: state.billValueTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              MySeparator(
                color: customTextGreyColor.withOpacity(0.3),
              ),
              const SizedBox(
                height: 8,
              ),

              ///---grand-total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total',
                    style: state.grandTotalTextStyle,
                  ),
                  Text(
                    'Rs ${(double.parse(widget.orderModel!.get('net_price').toString()) - commissionDiscount!).toPrecision(2)}',
                    style: state.grandTotalTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              ///---button
              widget.orderModel!.get('status') == 'Pending'
                  ? InkWell(
                      onTap: () async {
                        FirebaseFirestore.instance
                            .collection('orders')
                            .doc(widget.orderModel!.id)
                            .update({'status': 'Accepted'});
                        QuerySnapshot query = await FirebaseFirestore.instance
                            .collection('orders')
                            .get();
                        if (query.docs.isNotEmpty) {
                          query.docs.forEach((element) {
                            if (element.id == widget.orderModel!.id) {
                              widget.orderModel = element;
                              setState(() {});
                            }
                          });
                        }

                        QuerySnapshot queryForUser = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .where('uid',
                                isEqualTo: widget.orderModel!.get('uid'))
                            .get();
                        sendNotificationCall(
                            queryForUser.docs[0].get('token'),
                            'Choice! ${widget.orderModel!.get('restaurant')} has accepted your order and has it ready for you to collect!',
                            '');
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: customThemeColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            'Click to Accept',
                            style: state.buttonTextStyle,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              

 widget.orderModel!.get('status') == 'Accepted'
                  ? InkWell(
                      onTap: () async {
                        FirebaseFirestore.instance
                            .collection('orders')
                            .doc(widget.orderModel!.id)
                            .update({'status': 'Preparing Order'});
                        QuerySnapshot query = await FirebaseFirestore.instance
                            .collection('orders')
                            .get();
                        if (query.docs.isNotEmpty) {
                          query.docs.forEach((element) {
                            if (element.id == widget.orderModel!.id) {
                              widget.orderModel = element;
                              setState(() {});
                            }
                          });
                        }

                        QuerySnapshot queryForUser = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .where('uid',
                                isEqualTo: widget.orderModel!.get('uid'))
                            .get();
                        sendNotificationCall(
                            queryForUser.docs[0].get('token'),
                            'Choice! ${widget.orderModel!.get('restaurant')} has preparing your order',
                            '');
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: customThemeColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            'Preparing Order',
                            style: state.buttonTextStyle,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),


               widget.orderModel!.get('status') == 'Preparing Order'
                  ? InkWell(
                      onTap: () async {
                        FirebaseFirestore.instance
                            .collection('orders')
                            .doc(widget.orderModel!.id)
                            .update({'status': 'Order Ready'});
                        QuerySnapshot query = await FirebaseFirestore.instance
                            .collection('orders')
                            .get();
                        if (query.docs.isNotEmpty) {
                          query.docs.forEach((element) {
                            if (element.id == widget.orderModel!.id) {
                              widget.orderModel = element;
                              setState(() {});
                            }
                          });
                        }

                        QuerySnapshot queryForUser = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .where('uid',
                                isEqualTo: widget.orderModel!.get('uid'))
                            .get();
                        sendNotificationCall(
                            queryForUser.docs[0].get('token'),
                            'Choice! ${widget.orderModel!.get('restaurant')} has  ready your order',
                            '');
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: customThemeColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            'Order Ready',
                            style: state.buttonTextStyle,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              

              widget.orderModel!.get('status') == 'Order Ready'
                  ? InkWell(
                      onTap: () async {
                        productOTPDialog(context);
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: customThemeColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            'Mark as Complete',
                            style: state.buttonTextStyle,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              widget.orderModel!.get('status') == 'Complete'
                  ? Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: customTextGreyColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'Completed Successfully',
                          style: state.buttonTextStyle,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController productOTPController = TextEditingController();
  productOTPDialog(BuildContext context1) {
    productOTPController.clear();
    return showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context1,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        },
        transitionBuilder: (BuildContext context, a1, a2, widgett) {
          return Transform.scale(
            scale: a1.value,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: GetBuilder<OrderDetailLogic>(builder: (_orderDetailLogic) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///---header
                        Container(
                          height: 66,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFA500).withOpacity(.21),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20)),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 15, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Enter Order OTP',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                        color: customTextGreyColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: TextFormField(
                            controller: productOTPController,
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            decoration: InputDecoration(
                                labelText: 'Order OTP',
                                labelStyle:
                                    const TextStyle(fontFamily: 'Poppins',color: customThemeColor),
                                border: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: customTextGreyColor)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: customTextGreyColor)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: customThemeColor)),
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                errorText: _orderDetailLogic.validator),
                            onChanged: (value) {
                              _orderDetailLogic.validator == null;
                              _orderDetailLogic.update();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        ///---footer
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 20, 0, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (widget.orderModel!
                                                .get('otp')
                                                .toString() ==
                                            productOTPController.text) {
                                          Navigator.pop(context);
                                          FirebaseFirestore.instance
                                              .collection('orders')
                                              .doc(widget.orderModel!.id)
                                              .update({'status': 'Complete'});
                                          QuerySnapshot query =
                                              await FirebaseFirestore.instance
                                                  .collection('orders')
                                                  .get();
                                          if (query.docs.isNotEmpty) {
                                            query.docs.forEach((element) {
                                              if (element.id ==
                                                  widget.orderModel!.id) {
                                                widget.orderModel = element;
                                                setState(() {});
                                              }
                                            });
                                          }

                                          QuerySnapshot queryForUser =
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .where('uid',
                                                      isEqualTo: widget
                                                          .orderModel!
                                                          .get('uid'))
                                                  .get();
                                          sendNotificationCall(
                                              queryForUser.docs[0].get('token'),
                                              'Your order is now successfully completed. Enjoy those tasty products and take a minute to review this order to redeem ${widget.orderModel!.get('net_price')}',
                                              '');
                                          sendNotificationCall(
                                              queryForUser.docs[0].get('token'),
                                              'Order Completed. Rate your experience with us',
                                              '');
                                        } else {
                                          Navigator.pop(context);
                                          Get.snackbar(
                                            'Incorrect Code',
                                            '',
                                            colorText: Colors.white,
                                            backgroundColor:
                                                Colors.red.withOpacity(0.7),
                                            snackPosition: SnackPosition.BOTTOM,
                                            margin: const EdgeInsets.all(15),
                                          );
                                          // _orderDetailLogic.validator ==
                                          //     'Incorrect Code';
                                          // _orderDetailLogic.update();
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: customThemeColor,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          child: Text(
                                            'SAVE',
                                            style: GoogleFonts.jost(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
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
              }),
            ),
          );
        });
  }
}
