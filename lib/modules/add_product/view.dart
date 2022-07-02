import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:multiselect/multiselect.dart';

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_dialog.dart';
import 'logic.dart';
import 'state.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final AddProductLogic logic = Get.put(AddProductLogic());
  final AddProductState state = Get.find<AddProductLogic>().state;

  final GlobalKey<FormState> _addProductFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateFormLoader(false);
    });
    logic.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductLogic>(
      builder: (_addProductLogic) => GetBuilder<GeneralController>(
        builder: (_generalController) => GestureDetector(
          onTap: () {
            Get.find<GeneralController>().focusOut(context);
          },
          child: ModalProgressHUD(
            inAsyncCall: _generalController.formLoader!,
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: customThemeColor,
                    size: 25,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: _addProductFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),

                        ///---image
                        InkWell(
                          onTap: () {
                            imagePickerDialog(context);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * .1,
                            width: MediaQuery.of(context).size.width * .2,
                            decoration: BoxDecoration(
                                color: customTextGreyColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: _addProductLogic.productImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _addProductLogic.productImage!,
                                      fit: BoxFit.cover,
                                    ))
                                : const Icon(
                                    Icons.add_a_photo,
                                    color: customThemeColor,
                                    size: 25,
                                  ),
                          ),
                        ),
                        Text(
                          'Product Image',
                          style: state.labelTextStyle,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: DropDownMultiSelect(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 0.0),
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
                            onChanged: (List<String> x) {
                              setState(() {
                                _addProductLogic.selectedCategories = x;
                              });
                            },
                            options: _addProductLogic.categoriesDropDownList,
                            selectedValues: _addProductLogic.selectedCategories,
                            whenEmpty: 'Product Category',
                          ),
                        ),

                    
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .0,
                        ),

                        ///---product-name-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: _addProductLogic.nameController,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Product Name",
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
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///---product-quantity-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: _addProductLogic.quantityController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Product Quantity",
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
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///---product-original-price-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            onChanged: (String? newValue) {
                              if (_addProductLogic.originalPriceController.text
                                      .isNotEmpty &&
                                  _addProductLogic.discountedPriceController
                                      .text.isNotEmpty) {
                                setState(() {
                                  _addProductLogic.discountValueController
                                      .text = double.parse((((int.parse(
                                                          _addProductLogic
                                                              .originalPriceController
                                                              .text
                                                              .toString()) -
                                                      int.parse(_addProductLogic
                                                          .discountedPriceController
                                                          .text
                                                          .toString())) /
                                                  int.parse(_addProductLogic
                                                      .originalPriceController
                                                      .text
                                                      .toString())) *
                                              100)
                                          .toString())
                                      .toPrecision(1)
                                      .toString();
                                });
                                log('DISCOUNTED VALUE--->>${_addProductLogic.discountValueController.text}');
                              } else {
                                _addProductLogic.discountValueController.text =
                                    '0';
                              }
                            },
                            controller:
                                _addProductLogic.originalPriceController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Original Price",
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
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///---product-discounted-price-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            onChanged: (String? newValue) {
                              if (_addProductLogic.originalPriceController.text
                                      .isNotEmpty &&
                                  _addProductLogic.discountedPriceController
                                      .text.isNotEmpty) {
                                setState(() {
                                  _addProductLogic.discountValueController
                                      .text = double.parse((((int.parse(
                                                          _addProductLogic
                                                              .originalPriceController
                                                              .text
                                                              .toString()) -
                                                      int.parse(_addProductLogic
                                                          .discountedPriceController
                                                          .text
                                                          .toString())) /
                                                  int.parse(_addProductLogic
                                                      .originalPriceController
                                                      .text
                                                      .toString())) *
                                              100)
                                          .toString())
                                      .toPrecision(1)
                                      .toString();
                                });
                                log('DISCOUNTED VALUE--->>${_addProductLogic.discountValueController.text}');
                              } else {
                                _addProductLogic.discountValueController.text =
                                    '0';
                              }
                            },
                            controller:
                                _addProductLogic.discountedPriceController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Price After Discount",
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
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///---product-discount-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                _addProductLogic.discountValueController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Discount Percentage",
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
                              return null;
                              // if (value!.isEmpty) {
                              //   return 'Field Required';
                              // } else if (double.parse(_addProductLogic
                              //             .discountValueController.text
                              //             .toString())
                              //         .toInt() <
                              //     30) {
                              //   return 'Discount Must Be Greater Than Equal To 30%';
                              // } else {
                              //   return null;
                              // }
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///---chef-note-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: _addProductLogic.chefNoteController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            minLines: 1,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Chef's Note",
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
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),

                        ///---add-product-button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: InkWell(
                            onTap: () async {
                              _generalController.focusOut(context);
                              if (_addProductFormKey.currentState!.validate() &&
                                  _addProductLogic
                                      .selectedCategories.isNotEmpty) {
                                if (_addProductLogic.productImage != null) {
                                  _generalController.updateFormLoader(true);
                                  _addProductLogic.uploadFile(
                                      _addProductLogic.productImage, context);
                                } else {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          title: 'FAILED!',
                                          titleColor: customDialogErrorColor,
                                          descriptions:
                                              'Please Upload Product Image',
                                          text: 'Ok',
                                          functionCall: () {
                                            Navigator.pop(context);
                                          },
                                          img: 'assets/dialog_error.svg',
                                        );
                                      });
                                }
                              } else {
                                Get.snackbar(
                                  'Fill All Fields Please...',
                                  '',
                                  colorText: Colors.white,
                                  backgroundColor:
                                      customThemeColor.withOpacity(0.7),
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(15),
                                );
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
                                child:
                                    Text("ADD", style: state.buttonTextStyle),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
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

  List productImagesList = [];
  void imagePickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      productImagesList = [];
                    });
                    productImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Camera,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (productImagesList != null) {
                      setState(() {
                        Get.find<AddProductLogic>().productImage =
                            File(productImagesList[0].path);
                      });
                      log(productImagesList[0].path);
                    }
                  },
                  child: Text(
                    "Camera",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  )),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      productImagesList = [];
                    });
                    productImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Gallery,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (productImagesList != null) {
                      setState(() {
                        Get.find<AddProductLogic>().productImage =
                            File(productImagesList[0].path);
                      });
                      log(productImagesList[0].path);
                    }
                  },
                  child: Text(
                    "Gallery",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  )),
            ],
          );
        });
  }
}
