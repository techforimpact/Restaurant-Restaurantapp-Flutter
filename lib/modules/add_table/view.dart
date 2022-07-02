// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import '../../controller/general_controller.dart';
// import '../../utils/colors.dart';
// import '../../widgets/custom_dialog.dart';
// import 'logic.dart';
// import 'state.dart';

// class AddBiteBagPage extends StatefulWidget {
//   const AddBiteBagPage({Key? key}) : super(key: key);

//   @override
//   _AddBiteBagPageState createState() => _AddBiteBagPageState();
// }

// class _AddBiteBagPageState extends State<AddBiteBagPage> {
//   final AddTableLogic logic = Get.put(AddTableLogic());
//   final AddBiteBagState state = Get.find<AddTableLogic>().state;

//   final GlobalKey<FormState> _addBiteBagFormKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       Get.find<GeneralController>().updateFormLoader(false);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AddTableLogic>(
//       builder: (_addTableLogic) => GetBuilder<GeneralController>(
//         builder: (_generalController) => GestureDetector(
//           onTap: () {
//             Get.find<GeneralController>().focusOut(context);
//           },
//           child: ModalProgressHUD(
//             inAsyncCall: _generalController.formLoader!,
//             progressIndicator: const CircularProgressIndicator(
//               color: customThemeColor,
//             ),
//             child: Scaffold(
//               appBar: AppBar(
//                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                 elevation: 0,
//                 leading: InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: const Icon(
//                     Icons.arrow_back_ios,
//                     color: customThemeColor,
//                     size: 25,
//                   ),
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 child: SafeArea(
//                   child: Form(
//                     key: _addBiteBagFormKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .02,
//                         ),

//                         ///---image
//                         InkWell(
//                           onTap: () {
//                             imagePickerDialog(context);
//                           },
//                           child: Container(
//                             height: MediaQuery.of(context).size.height * .1,
//                             width: MediaQuery.of(context).size.width * .2,
//                             decoration: BoxDecoration(
//                                 color: customTextGreyColor.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: _addTableLogic.tableImage != null
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: Image.file(
//                                       _addTableLogic.tableImage!,
//                                       fit: BoxFit.cover,
//                                     ))
//                                 : const Icon(
//                                     Icons.add_a_photo,
//                                     color: customThemeColor,
//                                     size: 25,
//                                   ),
//                           ),
//                         ),
//                         Text(
//                           'Table Image',
//                           style: state.labelTextStyle,
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .02,
//                         ),
                       
//                         ///---table-name-field
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                           child: TextFormField(
//                             controller: _addTableLogic.tableNameController,
//                             keyboardType: TextInputType.text,
//                             cursorColor: Colors.black,
//                             decoration: InputDecoration(
//                               labelText: "Table name",
//                               labelStyle: state.labelTextStyle,
//                               border: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.black.withOpacity(0.5))),
//                               enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.black.withOpacity(0.5))),
//                               focusedBorder: const UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: customThemeColor)),
//                               errorBorder: const UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.red)),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Field Required';
//                               } else {
//                                 return null;
//                               }
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .01,
//                         ),

//                         ///---Table Chairs Count
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                           child: TextFormField(
//                             controller: _addTableLogic.tableChairsCountController,
//                             keyboardType: TextInputType.number,
//                             cursorColor: Colors.black,
//                             decoration: InputDecoration(
//                               labelText: "Table Chairs Count ",
//                               labelStyle: state.labelTextStyle,
//                               border: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.black.withOpacity(0.5))),
//                               enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.black.withOpacity(0.5))),
//                               focusedBorder: const UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: customThemeColor)),
//                               errorBorder: const UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.red)),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Field Required';
//                               } else {
//                                 return null;
//                               }
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .01,
//                         ),

                        

//                         ///---Table-note-field
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                           child: TextFormField(
//                             controller: _addTableLogic.tableNoteController,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: 3,
//                             minLines: 1,
//                             cursorColor: Colors.black,
//                             decoration: InputDecoration(
//                               labelText: "Table note",
//                               labelStyle: state.labelTextStyle,
//                               border: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.black.withOpacity(0.5))),
//                               enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.black.withOpacity(0.5))),
//                               focusedBorder: const UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: customThemeColor)),
//                               errorBorder: const UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.red)),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Field Required';
//                               } else {
//                                 return null;
//                               }
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .03,
//                         ),

//                         ///---add-bite-bag-button
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                           child: InkWell(
//                             onTap: () async {
//                               _generalController.focusOut(context);
//                               if (_addBiteBagFormKey.currentState!.validate()) {
//                                 if (_addTableLogic.tableImage != null) {
//                                   _generalController.updateFormLoader(true);
//                                   _addTableLogic.uploadFile(
//                                       _addTableLogic.tableImage, context);
//                                 } else {
//                                   showDialog(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       builder: (BuildContext context) {
//                                         return CustomDialogBox(
//                                           title: 'FAILED!',
//                                           titleColor: customDialogErrorColor,
//                                           descriptions:
//                                               'Please Upload Bite Bag Image',
//                                           text: 'Ok',
//                                           functionCall: () {
//                                             Navigator.pop(context);
//                                           },
//                                           img: 'assets/dialog_error.svg',
//                                         );
//                                       });
//                                 }
//                               } else {
//                                 Get.snackbar(
//                                   'Fill All Fields Please...',
//                                   '',
//                                   colorText: Colors.white,
//                                   backgroundColor: customThemeColor.withOpacity(0.7),
//                                   snackPosition: SnackPosition.BOTTOM,
//                                   margin: const EdgeInsets.all(15),
//                                 );
//                               }
//                             },
//                             child: Container(
//                               height: 55,
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                 color: customThemeColor,
//                                 borderRadius: BorderRadius.circular(30),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: customThemeColor.withOpacity(0.19),
//                                     blurRadius: 40,
//                                     spreadRadius: 0,
//                                     offset: const Offset(
//                                         0, 22), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               child: Center(
//                                 child:
//                                     Text("ADD", style: state.buttonTextStyle),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .01,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List TableImagesList = [];
//   void imagePickerDialog(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return CupertinoAlertDialog(
//             actions: <Widget>[
//               CupertinoDialogAction(
//                   isDefaultAction: true,
//                   onPressed: () async {
//                     Navigator.pop(context);
//                     setState(() {
//                       TableImagesList = [];
//                     });
//                     TableImagesList.add(await ImagePickerGC.pickImage(
//                         enableCloseButton: true,
//                         context: context,
//                         source: ImgSource.Camera,
//                         barrierDismissible: true,
//                         imageQuality: 10,
//                         maxWidth: 400,
//                         maxHeight: 600));
//                     setState(() {
//                       Get.find<AddTableLogic>().tableImage =
//                           File(TableImagesList[0].path);
//                     });
//                     log(TableImagesList[0].path);
//                   },
//                   child: Text(
//                     "Camera",
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline5!
//                         .copyWith(fontSize: 18),
//                   )),
//               CupertinoDialogAction(
//                   isDefaultAction: true,
//                   onPressed: () async {
//                     Navigator.pop(context);
//                     setState(() {
//                       TableImagesList = [];
//                     });
//                     TableImagesList.add(await ImagePickerGC.pickImage(
//                         enableCloseButton: true,
//                         context: context,
//                         source: ImgSource.Gallery,
//                         barrierDismissible: true,
//                         imageQuality: 10,
//                         maxWidth: 400,
//                         maxHeight: 600));
//                     setState(() {
//                       Get.find<AddTableLogic>().tableImage =
//                           File(TableImagesList[0].path);
//                     });
//                     log(TableImagesList[0].path);
//                   },
//                   child: Text(
//                     "Gallery",
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline5!
//                         .copyWith(fontSize: 18),
//                   )),
//             ],
//           );
//         });
//   }
// }
