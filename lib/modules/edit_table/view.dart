import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import 'logic.dart';
import 'state.dart';

class EditTablePage extends StatefulWidget {
  const EditTablePage({Key? key, this.productModel}) : super(key: key);

  final DocumentSnapshot? productModel;
  @override
  _EditTablePageState createState() => _EditTablePageState();
}

class _EditTablePageState extends State<EditTablePage> {
  final EditTableLogic logic = Get.put(EditTableLogic());
  final EditTableState state = Get.find<EditTableLogic>().state;

  final GlobalKey<FormState> _editProductFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateFormLoader(false);
    });

    logic.setData(widget.productModel);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditTableLogic>(
      builder: (_editTableLogic) => GetBuilder<GeneralController>(
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
                    key: _editProductFormKey,
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
                            child: _editTableLogic.downloadURL == null
                                ? _editTableLogic.tableImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          _editTableLogic.tableImage!,
                                          fit: BoxFit.cover,
                                        ))
                                    : const Icon(
                                        Icons.add_a_photo,
                                        color: customThemeColor,
                                        size: 25,
                                      )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      _editTableLogic.downloadURL!,
                                      fit: BoxFit.cover,
                                    )),
                          ),
                        ),
                        Text(
                          'Product Image',
                          style: state.labelTextStyle,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                       
                        ///---table name
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: _editTableLogic.tableNameController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Table Name",
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

                        ///---table chairs
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            
                            controller:
                                _editTableLogic.tableChairsCountController,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Table chairs",
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

                        ///---reserve from
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            readOnly: true,
                           
                            controller:
                                _editTableLogic.tableReserveFromController,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Reserve from ",
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

                        ///---Reserve To
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                _editTableLogic.tableReserveToController,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Reserve To",
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
                              } 
                              else {
                                return null;
                              }
                            },
                          ),
                        ),
                       
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///---Table-note-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: _editTableLogic.tableNoteController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            minLines: 1,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Table Note",
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
                              if (_editProductFormKey.currentState!
                                  .validate()) {
                                _generalController.updateFormLoader(true);
                                _editTableLogic.uploadFile(
                                    _editTableLogic.tableImage,
                                    context,
                                    widget.productModel!.id);
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
                                child: Text("UPDATE",
                                    style: state.buttonTextStyle),
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
                    setState(() {
                      Get.find<EditTableLogic>().tableImage =
                          File(productImagesList[0].path);
                    });
                    log(productImagesList[0].path);
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
                    setState(() {
                      Get.find<EditTableLogic>().tableImage =
                          File(productImagesList[0].path);
                    });
                    log(productImagesList[0].path);
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
