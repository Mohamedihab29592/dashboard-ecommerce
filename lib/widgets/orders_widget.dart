import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/inner_screens/orderEdit.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';
import 'text_widget.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key, required this.price, required this.salePrice, required this.productId, required this.userId, required this.imageUrl, required this.userName, required this.quantity, required this.orderDate, required this.userPhone, required this.shipping, required this.title, required this.items, required this.isOnSale, required this.total}) : super(key: key);
  final double price,salePrice,total;
  final String productId, userId,imageUrl,userName,userPhone,shipping, title,items;
  final int quantity;
  final Timestamp orderDate;
  final bool isOnSale;


  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  late String orderDateStr;
  @override
  void initState() {
    var postDate = widget.orderDate.toDate();
    orderDateStr ="${postDate.day}/${postDate.month}/${postDate.year}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;
    Size size = Utils(context).getScreenSize;

    return InkWell(
      onTap: ()
      {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OrderScreenEdit(isOnSale: widget.isOnSale,title: widget.title, price: widget.price, salePrice: widget.salePrice, productId: widget.productId, userId: widget.userId, imageUrl: widget.imageUrl, userName: widget.userName, userPhone: widget.userPhone, shipping: widget.shipping, quantity: widget.quantity, orderDate: widget.orderDate, items: widget.items, total: widget.total,)
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).cardColor.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Flexible(
                  flex: size.width < 650 ? 3 : 1,
                  child: Image.network(
                   widget.imageUrl,

                    fit: BoxFit.fill,
                    // height: screenWidth * 0.15,
                    // width: screenWidth * 0.15,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: widget.title,
                        color: color,
                        textSize: 16,
                        isTitle: true,
                      ),
                      TextWidget(
                        text: '${widget.quantity}x For \$${widget.isOnSale ?widget.salePrice.toStringAsFixed(2):widget.price.toStringAsFixed(2)}',
                        color: color,
                        textSize: 16,
                        isTitle: true,
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            TextWidget(
                              text: 'By',
                              color: Colors.blue,
                              textSize: 16,
                              isTitle: true,
                            ),
                            TextWidget(
                              text: widget.userName,
                              color: color,
                              textSize: 14,
                              isTitle: true,
                            ),
                          ],
                        ),
                      ),
                       Text(
                        orderDateStr,
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
