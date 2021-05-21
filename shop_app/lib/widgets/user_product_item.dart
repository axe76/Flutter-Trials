import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffoldCOntext = Scaffold.of(context);//we do this here and not directly in the delete catch block as context is changing, 
    //so when we call it down there app doesnt know which context to look at
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),//Here the image url is given to a network image provider
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children:[
            IconButton(
              icon: Icon(Icons.edit), 
              color: Theme.of(context).primaryColor, 
              onPressed: (){
                Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
            },),
            IconButton(
              icon: Icon(Icons.delete), 
              color: Theme.of(context).errorColor, 
              onPressed: ()async{
                try{
                  await Provider.of<ProductsProvider>(context, listen: false).deleteProduct(id);
                }catch (error){
                  scaffoldCOntext.showSnackBar(SnackBar(
                    content: Text('Could not delete item.'),
                    )
                  );
                }
            },),
          ]
        ),
      ),
    );
  }
}