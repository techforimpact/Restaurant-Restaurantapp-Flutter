import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart' as intl;

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import 'logic.dart';
import 'state.dart';
import 'view_map.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, this.restaurantModel}) : super(key: key);

  final DocumentSnapshot? restaurantModel;
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileLogic logic = Get.put(EditProfileLogic());
  final EditProfileState state = Get.find<EditProfileLogic>().state;

  final GlobalKey<FormState> _editProfileFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<EditProfileLogic>().requestLocationPermission(context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateFormLoader(false);
    });
    logic.setData(widget.restaurantModel);
  }

  final timeFormat = intl.DateFormat.jm();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileLogic>(
      builder: (_editProfileLogic) => GetBuilder<GeneralController>(
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
                  onTap: () async {
                    Get.back();
                    // List<Location> locations = await locationFromAddress(
                    //     "saad medical complez faisalabad");
                    // log('Locations from geocoding--->>${locations}');
                    // List<Placemark> placemarks = await placemarkFromCoordinates(
                    //     locations[0].latitude, locations[0].longitude);
                    // log('Adress from geocoding--->>${placemarks}');
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
                    key: _editProfileFormKey,
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
                            child: _editProfileLogic.downloadURL == null
                                ? _editProfileLogic.restaurantImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          _editProfileLogic.restaurantImage!,
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
                                      _editProfileLogic.downloadURL!,
                                      fit: BoxFit.cover,
                                    )),
                          ),
                        ),
                        Text(
                          'Restaurant Image',
                          style: state.labelTextStyle,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),

                        ///---restaurant-name-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: _editProfileLogic.nameController,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Restaurant Name",
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

                        ///---restaurant-location-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () async {
                              Get.to(const MapEditView());
                            },
                            controller: _editProfileLogic.addressController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Restaurant Location",
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

                        ///---open-time
                        Theme(
                          data: ThemeData(
                              primaryColor: customThemeColor,
                              primarySwatch: Colors.amber),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: DateTimeField(
                              format: timeFormat,
                              controller: _editProfileLogic.openTimeController,
                              decoration: InputDecoration(
                                labelText: "Opening Time",
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
                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                _editProfileLogic.openTimeController.text =
                                    time!.format(context).toString();
                                log('--->>>OPEN_TIME-->>${_editProfileLogic.openTimeController.text}');
                                return DateTimeField.convert(time);
                              },
                              validator: (value) {
                                if (_editProfileLogic
                                    .openTimeController.text.isEmpty) {
                                  return 'Field Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///---close-time
                        Theme(
                          data: ThemeData(
                              primaryColor: customThemeColor,
                              primarySwatch: Colors.amber),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: DateTimeField(
                              format: timeFormat,
                              controller: _editProfileLogic.closeTimeController,
                              decoration: InputDecoration(
                                labelText: "Closing Time",
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
                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                _editProfileLogic.closeTimeController.text =
                                    time!.format(context).toString();
                                log('--->>>CLOSE_TIME-->>${_editProfileLogic.closeTimeController.text}');
                                return DateTimeField.convert(time);
                              },
                              validator: (value) {
                                if (_editProfileLogic
                                    .closeTimeController.text.isEmpty) {
                                  return 'Field Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///---website-address-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller:
                                _editProfileLogic.websiteAddressController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Website Address",
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
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///---about-field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: _editProfileLogic.aboutController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "About",
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

                        ///---add-product-button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: InkWell(
                            onTap: () async {
                              _generalController.focusOut(context);
                              if (_editProfileFormKey.currentState!
                                  .validate()) {
                                _generalController.updateFormLoader(true);
                                _editProfileLogic.uploadFile(
                                    _editProfileLogic.restaurantImage,
                                    context,
                                    widget.restaurantModel!.id);
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

  List restaurantImagesList = [];
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
                      restaurantImagesList = [];
                    });
                    restaurantImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Camera,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (restaurantImagesList != null) {
                      setState(() {
                        Get.find<EditProfileLogic>().restaurantImage =
                            File(restaurantImagesList[0].path);
                      });
                      log(restaurantImagesList[0].path);
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
                      restaurantImagesList = [];
                    });
                    restaurantImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Gallery,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (restaurantImagesList != null) {
                      setState(() {
                        Get.find<EditProfileLogic>().restaurantImage =
                            File(restaurantImagesList[0].path);
                      });
                      log(restaurantImagesList[0].path);
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
