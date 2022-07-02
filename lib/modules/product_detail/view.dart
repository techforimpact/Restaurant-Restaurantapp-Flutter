
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_dialog.dart';
import '../edit_product/view.dart';
import '../image_full_view/view.dart';
import 'logic.dart';
import 'state.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key, this.productModel, this.isProduct})
      : super(key: key);

  final DocumentSnapshot? productModel;
  final bool? isProduct;
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductDetailLogic logic = Get.put(ProductDetailLogic());
  final ProductDetailState state = Get.find<ProductDetailLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.currentProduct(
        widget.productModel, widget.isProduct! ? 'products' : 'biteBags');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailLogic>(
      builder: (_productDetailLogic) => Scaffold(
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
                ///---image
                Hero(
                    tag: '${widget.productModel!.get('image')}',
                    child: Material(
                        child: InkWell(
                      onTap: () {
                        Get.to(ImageViewScreen(
                          networkImage: '${widget.productModel!.get('image')}',
                        ));
                      },
                      child: Container(
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            '${widget.productModel!.get('image')}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ))),

                ///---name
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Text(
                      widget.isProduct!
                          ? '${widget.productModel!.get('name')}'
                          : 'Bite Bag',
                      textAlign: TextAlign.center,
                      style: state.productNameStyle),
                ),

                ///---price
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: customThemeColor),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                            child: Center(
                              child: Text(
                                  'Rs ${widget.productModel!.get('dis_price')}',
                                  style: state.productPriceStyle),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                            'Rs ${widget.productModel!.get('original_price')}',
                            style: state.productPriceStyle!.copyWith(
                                color: customTextGreyColor,
                                decoration: TextDecoration.lineThrough)),
                      ),
                    ],
                  ),
                ),

                ///---rating-discount
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.star,
                              color: customThemeColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              '${_productDetailLogic.averageRating}',
                              style: state.productPriceStyle!.copyWith(
                                  color: customTextGreyColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                            '${widget.productModel!.get('discount')}% off',
                            style: state.productPriceStyle!.copyWith(
                                color: customTextGreyColor, fontSize: 14)),
                      ),
                    ],
                  ),
                ),

                ///---categories
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Category',
                          textAlign: TextAlign.start,
                          style: state.headingTextStyle),
                      Wrap(
                        children: List.generate(
                            widget.productModel!.get('category').length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                            child: Text(
                                '${widget.productModel!.get('category')[index]}',
                                textAlign: TextAlign.start,
                                style: state.descTextStyle),
                          );
                        }),
                      )
                    ],
                  ),
                ),

                ///---chef's-note
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Chef\'s Note',
                          textAlign: TextAlign.start,
                          style: state.headingTextStyle),
                      Text('${widget.productModel!.get('chef_note')}',
                          textAlign: TextAlign.start,
                          style: state.descTextStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (widget.isProduct ??  false) {
                      Get.to(EditProductPage(
                        productModel: widget.productModel,
                      ));
                    } else {
                      // Get.to(EditBiteBagPage(
                      //   productModel: widget.productModel,
                      // ));
                    }
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
                        'Edit',
                        style: state.editButtonStyle,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: 'ARE YOU SURE?',
                            titleColor: customDialogQuestionColor,
                            descriptions: 'You Want To Delete This Product?',
                            text: 'Ok',
                            functionCall: () {
                              FirebaseFirestore.instance
                                  .collection(widget.isProduct!
                                      ? 'products'
                                      : 'biteBags')
                                  .doc(widget.productModel!.id)
                                  .delete();
                              Get.back();
                              Get.snackbar(
                                'Deleted Successfully',
                                '',
                                colorText: Colors.white,
                                backgroundColor: customThemeColor.withOpacity(0.7),
                                snackPosition: SnackPosition.BOTTOM,
                                margin: const EdgeInsets.all(15),
                              );
                              Navigator.pop(context);
                            },
                            img: 'assets/dialog_Question Mark.svg',
                          );
                        });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: state.editButtonStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
