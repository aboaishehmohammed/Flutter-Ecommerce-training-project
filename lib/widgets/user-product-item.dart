import 'package:ecommerce_flutter/providers/products.dart';
import 'package:ecommerce_flutter/screens/edit-product-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffolld = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(context).pushNamed(
                      EditProductScreen.routeName,
                      arguments: id,
                    )),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProduct(id);
                  } catch (e) {
                    scaffolld.showSnackBar(
                      SnackBar(content: Text(
                        'Deleting failed'
                        ,
                        textAlign: TextAlign.center,
                      ))
                    );
                  }
                },
                color:Theme.of(context).errorColor ,
                )
          ],
        ),
      ),
    );
  }
}
