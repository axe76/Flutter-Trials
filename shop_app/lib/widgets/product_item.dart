import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context); 
    final cart = Provider.of<Cart>(context,listen: false);
    final auth = Provider.of<Auth>(context,listen: false);

    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
        child: GestureDetector(
          child: Image.network(productData.imageUrl),
          onTap: (){
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: productData.id);
          } 
          ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(productData.isFavourite? Icons.favorite:Icons.favorite_border),
            onPressed: (){productData.toggleFavourite(auth.token,auth.userId);},
            color: Theme.of(context).accentColor,
          ),
          title: Text(productData.title, textAlign: TextAlign.center,),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              cart.addItem(productData.id, productData.price, productData.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Added item to cart!'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(label: 'UNDO', onPressed: (){
                  cart.removeSingleItem(productData.id);
                }),
              ));
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}