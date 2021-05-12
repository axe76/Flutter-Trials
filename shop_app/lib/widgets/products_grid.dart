import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/product.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFavourites;

  ProductsGrid(this.isFavourites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = isFavourites? productsData.favouriteItems:productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10  
      ), 
      itemBuilder: (ctx,index){
        return ChangeNotifierProvider.value(
          value: products[index],//now creating provider for every product
            child: ProductItem(),
        );
      },
      itemCount: products.length,
    );
  }
}