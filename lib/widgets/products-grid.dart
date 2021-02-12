import 'package:ecommerce_flutter/providers/products.dart';
import 'package:ecommerce_flutter/widgets/product-item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  const ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? productData.favoriteItems : productData.items;
    return
    products.isEmpty?Center(
      child: Text("There is no product"),
    ):
     GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(value:products[i],
      child:ProductItem() ,
       ),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
