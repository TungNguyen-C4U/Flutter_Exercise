import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _showFavoritesOnly = false; // app-wide state | filter
  List<Product> get items {
    // if (_showFavoritesOnly) { return _items.where((prodItem) => prodItem.isFavorite).toList(); }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() { _showFavoritesOnly = true; notifyListeners();}

  // void showAll() {_showFavoritesOnly = false; notifyListeners();}

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://flutter-shopapp-fe0ff-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);

      /// dynamic tell nested Map
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });

      /// Note: _items is not final so we replace it with new one
      _items = loadedProducts;
      notifyListeners();

      ///Flow where listen: here > products_overview_screen > products_grid (listen through Provider)
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://flutter-shopapp-fe0ff-default-rtdb.firebaseio.com/products.json';
    /**
         * async: wrapped fx always returns Future
         * await: wait to finish first then come to next line of code
         * >> Can remove then and catchError | respone then come from await
         * catchError replace by try catch
         */
    // return
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );

      /// This block belongs to then
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct); //.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      /// This belongs to catchError
      throw error;
    }
    // .then((response) {}).catchError((error) {});
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    /// Not update isFavorite because we change it usually?
    if (prodIndex >= 0) {
      // Only final at runtime
      final url =
          'https://flutter-shopapp-fe0ff-default-rtdb.firebaseio.com/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-shopapp-fe0ff-default-rtdb.firebaseio.com/$id.json';
    /**
     * optimistic updating: Store in memory then rollback if found error
     */
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    // var because we want to change it after runtime
    var existingProduct = _items[existingProductIndex];

    /// Delete it immediately
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    // .then((response) {
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);

      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
    //
    // }).catchError((_) {_items.insert(existingProductIndex, existingProduct);}); // Not work

    /// Move below http for asyc execute
    // _items.removeAt(existingProductIndex);
    // notifyListeners();
    // _items.removeWhere((prod) => prod.id == id);
  }
}
