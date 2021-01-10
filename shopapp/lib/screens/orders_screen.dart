import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/widgets/app_drawer.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

/// Convert into Stateful ===  Can use initState and didStateChange
class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  // var _isLoading = false;
  /// ModelRoute can not use here - Only Provider internally give option
  /// Never set async for override method (can not override its return)
  // @override
  // void initState() {
  // Future.delayed(Duration.zero).then((_) async {
  // setState(() {
  //   _isLoading = true;
  // });
  //   await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //   setState(() {
  //     _isLoading = false;
  //   });
  // });

  //// If use listen to false
  // _isLoading = true;
  // Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
  //   setState(() {
  //     _isLoading = false;
  //   });
  // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    /// Set up listener here and below listen again > loop
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        // future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        /// Ensure no new future created just because widget rebuild
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occured!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
