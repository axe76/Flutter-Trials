import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import '../widgets/product_item.dart';

enum FilterOptions{
  Favourites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(icon: Icon(Icons.more_vert) ,itemBuilder: (_){
            return [
              PopupMenuItem(child: Text('Only favourites'),value:FilterOptions.Favourites),
              PopupMenuItem(child: Text('All'), value:FilterOptions.All)
            ];
          },
          onSelected: (FilterOptions selectedValue){
            setState(() {
              if(selectedValue == FilterOptions.Favourites){
                _isFavourites = true;
              }else{
                _isFavourites = false;
              }
            });
          },
          ),
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },),
            builder: (ctx,cart,child){
              return Badge(
            child: child, 
            value: cart.itemCount.toString());
            }
          ),
        ],
        ),
        drawer: AppDrawer(),
      body: ProductsGrid(_isFavourites),
    );
  }
}

