import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class ProductsProvider with ChangeNotifier { //mixin i.e. like inheritance light i.e. just mixing in properties other class. Not crating a child class
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items{
    return [..._items]; //returning a duplicate of _items, not pointer at original list
  }

  List<Product> get favouriteItems{
    return _items.where((item) => item.isFavourite).toList();
  }

  Product findById(String id){
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> fetchAndSetProduct() async{//fetches products from server and sets on products overview page
    final url = Uri.parse('https://flutter-shop-app-b8243-default-rtdb.firebaseio.com/products.json');
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String,dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {//key,val
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavourite: prodData['isFavourite'],
          imageUrl: prodData['imageUrl']
        ));
      }
    );
    _items= loadedProducts;
    notifyListeners();
    }catch(error){
      throw(error);
    }
  }

  Future<void> addProduct(Product product) async { //to return a Future that doesnt pass any data back to then. This is done for loading screen
    //async automatically wraps everything into future so we dont have to return a future in the code below
    try{
    //http post:
      final url = Uri.parse('https://flutter-shop-app-b8243-default-rtdb.firebaseio.com/products.json');//firebase
      final response = await http.post(url, body: json.encode({ //await makes everything wait for this
        'title':product.title,
        'description': product.description,
        'imageUrl':product.imageUrl,
        'price': product.price,
        'isFavourite': product.isFavourite
      }));
      //here we wait for http request followed by response from server instead of immediately executing next line
      //as we want to use data from response
      //local storage logic
      final newProduct = Product(
      id: json.decode(response.body)['name'], 
      description: product.description, 
      title: product.title, 
      price: product.price, 
      imageUrl: product.imageUrl
      );
      _items.add(newProduct);
      print(newProduct.id);
      notifyListeners();
    } catch(error){
        print(error);
        throw error;
    }
      // print(error);
      // throw error; //throws it to object catching error from this method, i.e. in editing screen  
   // here then also returns a future. Hence we return this full statement
  }

  Future<void> updateProduct(String prodId, Product editedProduct) async{
    final currProductIndex = _items.indexWhere((product) => product.id == prodId);
    if(currProductIndex>=0){
      final url = Uri.parse('https://flutter-shop-app-b8243-default-rtdb.firebaseio.com/products/$prodId.json');
      await http.patch(url,body:json.encode({
        'title':editedProduct.title,
        'description': editedProduct.description,
        'imageUrl':editedProduct.imageUrl,
        'price':editedProduct.price,
      }
      )
      );
      _items[currProductIndex] = editedProduct;
      notifyListeners();
    }else{
      print('No existing product');
    }
    
  }

  void deleteProduct(String id){
    final url = Uri.parse('https://flutter-shop-app-b8243-default-rtdb.firebaseio.com/products/$id.json');
    final existingProductIndex = _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    http.delete(url).then(//Here we delete without await to send compiler to next code line for speed of rendering 
      (value) {//if no error in delete http method, set existing prod to null
        existingProduct = null;
      }
    ).catchError((error){
      _items.insert(existingProductIndex,existingProduct);
      notifyListeners();
    });
    _items.removeAt(existingProductIndex);
    notifyListeners();
  }

}