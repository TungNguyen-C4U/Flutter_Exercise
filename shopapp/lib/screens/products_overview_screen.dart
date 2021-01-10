import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';

import '../screens/cart_screen.dart';
import '../providers/carts.dart';
import '../widgets/products_grid.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    /**
     * Widget not fully wired up with everything
     * Provider. / ModalRoute. not work here
     * NOTE: if you add listen: false > Can use here
     * OR using Future.delay(...) BUT initState run multiple times not just when Wiget get created
     * OR didChangeDependencies run after fully initialized but before build run
     */
    // Future.delayed(Duration.zero).then((_) {Provider.of<Products>(context).fetchAndSetProducts();});
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // setState to update UI
      setState(() {});
      _isLoading = true;

      /// This now only run whe page first loaded not like above solution
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {});
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Not interested in the data or whether it changes
     * Just concern with showFavoritesOnly() and showAll()
     * > new_ver: use getter
     */

    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              /**
               * setState: change data > change state > reflect UI by rebuild
               * Note: only be used to wrap the actual changes to the state
               */
              setState(
                () {
                  if (selectedValue == FilterOptions.Favorites) {
                    // productsContainer.showFavoritesOnly();
                    _showOnlyFavorites = true;
                  } else {
                    // productsContainer.showAll();
                    _showOnlyFavorites = false;
                  }
                },
              );
            },
            icon: Icon(Icons.more_vert),
            //'itemBuilder' builds the entries 'value' which identify which chosen
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          // Most part of this screen don't care changes in the cart
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            // child here auto pass into the builder
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
