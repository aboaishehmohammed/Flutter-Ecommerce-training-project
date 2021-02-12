import 'package:ecommerce_flutter/providers/cart.dart';
import 'package:ecommerce_flutter/providers/products.dart';
import 'package:ecommerce_flutter/screens/cart-screen.dart';
import 'package:ecommerce_flutter/widgets/app-drawer.dart';
import 'package:ecommerce_flutter/widgets/badge.dart';
import 'package:ecommerce_flutter/widgets/products-grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOption { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isLoading = false;
  var _showOnlyFavorite = false;
  //var _isInit = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) => setState(() => _isLoading = false),
        ).catchError((error)=>
        setState(() => _isLoading = false)
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOption selectedValue) {
                setState(() {
                  if (selectedValue == FilterOption.Favorites) {
                    _showOnlyFavorite = true;
                  } else {
                    _showOnlyFavorite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorite'),
                      value: FilterOption.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOption.All,
                    ),
                  ]),
          Consumer<CartProvider>(
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(CartScreen.routeName)),
              builder: (_, cart, ch) =>
                  Badge(value: cart.itemCount.toString(), 
                  child: ch))
        ],
      ),
      body:_isLoading?Center(
        child: CircularProgressIndicator(),
      ):ProductsGrid(_showOnlyFavorite),
      drawer: AppDrawer(),
    );
  }
}
