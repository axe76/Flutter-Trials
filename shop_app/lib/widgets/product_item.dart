import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context); 

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
            onPressed: (){productData.toggleFavourite();},
            color: Theme.of(context).accentColor,
          ),
          title: Text(productData.title, textAlign: TextAlign.center,),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (){},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}