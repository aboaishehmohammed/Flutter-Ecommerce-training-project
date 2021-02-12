import 'package:ecommerce_flutter/providers/auth.dart';
import 'package:ecommerce_flutter/providers/cart.dart';
import 'package:ecommerce_flutter/providers/orders.dart';
import 'package:ecommerce_flutter/providers/product.dart';
import 'package:ecommerce_flutter/providers/products.dart';
import 'package:ecommerce_flutter/screens/auth-screen.dart';
import 'package:ecommerce_flutter/screens/cart-screen.dart';
import 'package:ecommerce_flutter/screens/edit-product-screen.dart';
import 'package:ecommerce_flutter/screens/orders-screen.dart';
import 'package:ecommerce_flutter/screens/product-detail-screen.dart';
import 'package:ecommerce_flutter/screens/product-overview-screen.dart';
import 'package:ecommerce_flutter/screens/user-product-screen.dart';
import 'package:ecommerce_flutter/screens/splash-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value:AuthProvider() ,
        ),
        ChangeNotifierProxyProvider<AuthProvider,
        ProductsProvider>(
          create: (_)=>ProductsProvider(),
          update: (ctx,authValue,previousProduct)=>
         previousProduct..getData(authValue.token, authValue.userId,
         previousProduct==null?null:previousProduct.items)
          ,
        ),
        ChangeNotifierProvider.value(
          value:CartProvider() ,
        ),  
        ChangeNotifierProxyProvider<AuthProvider,
        OrderProvider>(
          create: (_)=>OrderProvider(),
          update: (ctx,authValue,previousOrder)=>
         previousOrder..getData(authValue.token, authValue.userId,
         previousOrder==null?null:previousOrder.orders)
          ,
        )
        ,
      ],
          child:  Consumer<AuthProvider>(builder: (ctx,auth,_)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:auth.isAuth?ProductsOverviewScreen():FutureBuilder(
          future: auth.tryAutoLogin(),
          builder: (context, AsyncSnapshot authSnapshot) =>authSnapshot.connectionState==ConnectionState.waiting?SplashScreen():AuthScreen(),
        ),
              routes: {
ProductDetailScreen.routeName:(_)=>ProductDetailScreen(),
CartScreen.routeName:(_)=>CartScreen(),
AuthScreen.routeName:(_)=>AuthScreen(),
OrdersScreen.routeName:(_)=>OrdersScreen(),
UserProductScreen.routeName:(_)=>UserProductScreen(),
EditProductScreen.routeName:(_)=>EditProductScreen()

        },
        
        ),
  
      ),
    );
  }
}


