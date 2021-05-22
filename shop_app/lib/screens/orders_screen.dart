import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName ='/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {//note to use initState and did change dep, widget has to be stateful
  var _isLoading = false;
  Future _ordersFuture;

  Future _obtainOrdersFuture(){
    return Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Orders'),),
      drawer: AppDrawer(),
      body: FutureBuilder(//alternate method for making loading screen and future based screens
        future: _ordersFuture,
        builder: (ctx,dataSnapshot){
          if(dataSnapshot.connectionState == ConnectionState.waiting){
            return Center(child:CircularProgressIndicator());
          }else{
            if(dataSnapshot.error != null){
              return Text('An error occured');
            }else{
              return ListView.builder(
                  itemBuilder: (ctx,i){
                    return OrderItemTile(orderData.orders[i]);
                  },
                  itemCount: orderData.orders.length,
                  );
            }
          }
        },
        ) 
    );
  }
}