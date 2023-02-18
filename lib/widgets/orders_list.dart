import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart';
import 'orders_widget.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return     StreamBuilder<QuerySnapshot>(
      //there was a null error just add those lines
      stream: FirebaseFirestore.instance
          .collection('orders')
          .snapshots(),

      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState ==
            ConnectionState.active) {
          if (snapshot.data!.docs.isNotEmpty) {
            return     Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children:    [
                        OrdersWidget(
                          isOnSale: snapshot.data!.docs[index]['isOnSale'],
                          total: snapshot.data!.docs[index]['total'],
                          userPhone: snapshot.data!.docs[index]['userPhone'],
                          shipping: snapshot.data!.docs[index]['userShipping'],
                          price: snapshot.data!.docs[index]['price'],
                          salePrice: snapshot.data!.docs[index]['salePrice'],
                          productId: snapshot.data!.docs[index]['productId'],
                          userId: snapshot.data!.docs[index]['userId'],
                          imageUrl: snapshot.data!.docs[index]['imageUrl'],
                          userName: snapshot.data!.docs[index]['userName'],
                          quantity: snapshot.data!.docs[index]['quantity'],
                          orderDate:snapshot.data!.docs[index]['orderDate'],
                          title: snapshot.data!.docs[index]['title'],
                          items: snapshot.data!.docs[index]["items"],
                        ),
                        const Divider(thickness: 3,),
                      ],
                    );
                  }),
            );

          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('Your store is empty'),
              ),
            );
          }
        }
        return const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30),
          ),
        );
      },
    );




  }
}
