import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title,this.price);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(
      context,
      listen: false //Here because this is details screen, we dont want to rebuild every time the data in Provider changes.
      ).findById(productId);

    return Scaffold(
      appBar: AppBar(title: Text('${loadedProduct.title} and ${productId}'),),
      body: Container(
        height: 300,
        width: double.infinity,
        child: Image.network(
          loadedProduct.imageUrl,
          fit: BoxFit.cover,
          ),
      ),
    );
  }
}