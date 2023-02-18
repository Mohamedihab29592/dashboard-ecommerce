import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../screens/main_screen.dart';
import '../services/global_method.dart';
import '../services/utils.dart';
import '../widgets/buttons.dart';
import '../widgets/text_widget.dart';

class OrderScreenEdit extends StatefulWidget {
  const OrderScreenEdit({Key? key, required this.title, required this.price, required this.salePrice, required this.productId, required this.userId, required this.imageUrl, required this.userName, required this.userPhone, required this.shipping, required this.quantity, required this.orderDate, required this.items, required this.isOnSale, required this.total}) : super(key: key);
  final double price,salePrice,total;
  final String productId, userId,imageUrl,userName,userPhone,shipping, title,items;
  final int quantity;
  final Timestamp orderDate;
  final bool isOnSale;

  @override
  State<OrderScreenEdit> createState() => _OrderScreenEditState();
}

class _OrderScreenEditState extends State<OrderScreenEdit> {
  // Title and price controllers
  late final TextEditingController _totalController,_phoneController, _titleController, _priceController,_quantityController,_shippingController,_itemController;
  late String orderDateStr;
  late bool _isOnSale;

  @override
  void initState() {
    // set the price and title initial values and initialize the controllers
    _itemController = TextEditingController(text:  widget.items);
    _priceController = TextEditingController(text: widget.price.toString());
    _titleController = TextEditingController(text: widget.title);
    _phoneController = TextEditingController(text: widget.userPhone);
    _totalController = TextEditingController(text: widget.total.toString());

    _quantityController = TextEditingController(text: widget.quantity.toString());
    _shippingController = TextEditingController(text: widget.shipping);
    _isOnSale = widget.isOnSale;
    var postDate = widget.orderDate.toDate();
    orderDateStr ="${postDate.day}/${postDate.month}/${postDate.year}";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final theme = Utils(context).getTheme;
    final color = theme == true ? Colors.white : Colors.black;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );
    return Scaffold(
      // key: context.read<MenuController>().getEditProductscaffoldKey,
      // drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Header(
              //   showTexField: false,
              //   fct: () {
              //     context
              //         .read<MenuController>()
              //         .controlEditProductsMenu();
              //   },
              //   title: 'Edit this product',
              // ),
              Container(
                width: size.width > 650 ? 650 : size.width,
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextWidget(
                        text: 'Product title*',
                        color: color,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _titleController,

                          key: const ValueKey('Title'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Title';
                            }
                            return null;
                          },
                          decoration: inputDecoration,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 20),
                      TextWidget(
                        text: 'Shipping address*',
                        color: color,
                        isTitle: true,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _shippingController,
                        key: const ValueKey('Shipping'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'shipping address is missed';
                          }
                          return null;
                        },

                        decoration: inputDecoration,
                      ),
                      TextWidget(
                        text: 'phone*',
                        color: color,
                        isTitle: true,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _phoneController,
                          key: const ValueKey('phone'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone  is missed';
                            }
                            return null;
                          },

                          decoration: inputDecoration,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Price in \$*',
                                color: color,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(

                                width: 100,
                                child: TextFormField(
                                  controller: _priceController,
                                  key: const ValueKey('Price \$'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Price is missed';
                                    }
                                    return null;
                                  },

                                  decoration: inputDecoration,
                                ),
                              ),


                              const SizedBox(
                                height: 20,
                              ),
                              TextWidget(
                                text: 'Quantity*',
                                color: color,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      controller: _quantityController,
                                      key: const ValueKey('items'),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Items is missed';
                                        }
                                        return null;
                                      },

                                      decoration: inputDecoration,
                                    ),
                                  ),


                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextWidget(
                                text: 'Total*',
                                color: color,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      controller: _totalController,
                                      key: const ValueKey('items'),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Items is missed';
                                        }
                                        return null;
                                      },

                                      decoration: inputDecoration,
                                    ),
                                  ),


                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextWidget(
                                text: 'Stock items*',
                                color: color,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      controller: _itemController,
                                      key: const ValueKey('items'),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Items is missed';
                                        }
                                        return null;
                                      },

                                      decoration: inputDecoration,
                                    ),
                                  ),


                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [

                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextWidget(
                                    text: 'Sale price',
                                    color: color,
                                    isTitle: true,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              !_isOnSale
                                  ? TextWidget(
                                  text: "No Sale",
                                  color: Colors.red)
                                  : Row(
                                children: [
                                  TextWidget(
                                      text: "\$${widget.salePrice
                                          .toStringAsFixed(
                                          2)}",
                                      color: color),
                                  const SizedBox(
                                    width: 10,
                                  ),


                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: size.width > 650
                                    ? 350
                                    : size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),

                                  child: Image.network(widget.imageUrl,fit: BoxFit.fill,),
                                  ),
                                ),
                              ),
                            ),
                  ]
                          ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ButtonsWidget(
                                onPressed: () async {
                                  GlobalMethods.warningDialog(
                                      title: 'Delete?',

                                      subtitle: 'Press okay to confirm',
                                      fct: () async {

                                      },
                                      context: context);
                                },
                                text: 'Delete',
                                icon: IconlyBold.danger,
                                backgroundColor: Colors.red.shade700,
                              ),
                            ),
                            const SizedBox(width: 5,),

                            Expanded(
                              child: ButtonsWidget(
                                onPressed: () {
                                  //_updateProduct();
                                },
                                text: 'Update',
                                icon: IconlyBold.setting,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 5,),

                            Expanded(
                              child: ButtonsWidget(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
                                },
                                text: 'Home',
                                icon: IconlyBold.home,
                                backgroundColor: Colors.blue,
                              ),
                            ),

                          ],
                        ),
                      ),

                        ],
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
