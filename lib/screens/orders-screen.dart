import 'package:ecommerce_flutter/widgets/app-drawer.dart';
import 'package:ecommerce_flutter/widgets/order-item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show OrderProvider;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Screen'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<OrderProvider>(context, listen: false)
              .fetchAndSetOrders(),
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapShot.error != null) {
                return Center(
                  child: Text('An error Occured'),
                );
              } else {
               return Consumer<OrderProvider>(
                  builder: (ctx, orderData, child) =>
                      ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx,index)=>
                       OrderItem(
                         orderData.orders[index])
                        ),
                );
              }
            }
          }),
    );
  }
}
