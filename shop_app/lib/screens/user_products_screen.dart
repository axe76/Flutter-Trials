import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products-screen';

  Future<void> _refreshScreen(BuildContext context) async{
    await Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProduct(true); //here listen is false as we only want
    //to call the method
  }

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Products'),
        actions: [
          IconButton(icon: const Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: _refreshScreen(context),//waits for this future to to build rest
          builder: (ctx,snapshot)=> snapshot.connectionState == ConnectionState.waiting? Center(child: CircularProgressIndicator(),) 
          : RefreshIndicator(
          onRefresh: () => _refreshScreen(context),//for pull to refresh function. Has to return a future
          child: Consumer<ProductsProvider>(//this is done so that when _refreshScreen is called the entire widget tree doesnt build again and start an
          //infinite loop, but only the nelow part is rebuilt
              builder: (ctx,productsData,_) => Padding(padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (ctx,i){
                  return Column(
                    children: [
                      UserProductItem(productsData.items[i].id,productsData.items[i].title, productsData.items[i].imageUrl),
                      Divider(thickness: 2,),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}