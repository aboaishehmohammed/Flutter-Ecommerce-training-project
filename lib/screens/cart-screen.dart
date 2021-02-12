import 'package:ecommerce_flutter/providers/orders.dart';
import 'package:ecommerce_flutter/widgets/cart-item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show CartProvider;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color),
                      )),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          )
        ,
        SizedBox(height: 10,),
        Expanded(child: 
        ListView.builder(itemBuilder:(ctx,int index)=>CartItem(
          id: cart.items.values.toList()[index].id, 
          title:  cart.items.values.toList()[index].title,
           quantity:  cart.items.values.toList()[index].quantity,
            price:  cart.items.values.toList()[index].price,
          productId:  cart.items.keys.toList()[index],  ) ,
        itemCount: cart.items.length,))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final CartProvider cart;

  const OrderButton({@required this.cart});
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Order Now'),
      textColor: Theme.of(context).primaryColor,
      onPressed:(widget.cart.totalAmount<=0||_isLoading) ?null:() async {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<OrderProvider>(context, listen: false).addOrder(
          widget.cart.items.values.toList(),
          widget.cart.totalAmount,
        );
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
      },
    );
  }
}
