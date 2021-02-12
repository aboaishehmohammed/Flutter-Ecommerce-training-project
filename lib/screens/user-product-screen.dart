import 'package:ecommerce_flutter/providers/products.dart';
import 'package:ecommerce_flutter/screens/edit-product-screen.dart';
import 'package:ecommerce_flutter/widgets/app-drawer.dart';
import 'package:ecommerce_flutter/widgets/user-product-item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';
  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (ctx, snapShot) =>
          snapShot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  child: Consumer<ProductsProvider>(
                    builder: (ctx, productData, _) => Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                        itemCount: productData.items.length,
                        itemBuilder: (context, index)
                          =>Column(children: [
UserProductItem(productData.items[index].id,
productData.items[index].title,
productData.items[index].imageUrl ),
Divider()
                          ],)
                        ,
                      ),
                    ),
                  ),
                  onRefresh: () => _refreshProduct(context))
        ,
      ),
    );
  }
}
