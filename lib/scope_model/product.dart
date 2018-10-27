import 'package:scoped_model/scoped_model.dart';
import 'package:bbu_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/url.dart';

class ProductModel extends Model {
  
  
  List<Product> _products = [];
  final String _productsUrl = Url.baseUrl + 'api/posts';
  bool _isLoadingProduct = true;
  int selectedProductIndex = 0;
  int _pageCount = 0;
  
  Future<Null> fetchProductData(int page, int category_id) async{
    _products = new List<Product>();
    try{
      
      _isLoadingProduct = true;
      String productUrl = '$_productsUrl?category_id=${category_id.toString()}&page=${page.toString()}';
      http.Response responeData = await http.get(productUrl); 
    
      print(productUrl);
      final Map<String, dynamic> listData = json.decode(responeData.body);
      final List<Product> _productsList = [];
      _pageCount = listData['data']['page_count'];

     

      listData['data']['posts'].forEach((dynamic value){
        Product product = Product(
          id: value['id'],
          title:  Url.checkNullString(value['title']),
          shortContent: Url.checkNullString(value['short_content']),
          content: Url.checkNullString(value['content']),
          thumnail: '${Url.baseUrl}${Url.postPath}${value['thumnail']}',
          date: value['created_at'],
          galleries: value['galleries']
        );
      
        _productsList.add(product);
      
      });   
      _products = _productsList;
      _isLoadingProduct = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR Product===============');
      print(e.toString());
      print('===========ERROR Product===============');
      _isLoadingProduct = false;
      notifyListeners();
    }
   
  }

  

  List<Product> get getProduct{
    return _products;
  }

  bool get isLoadingProduct {
    return _isLoadingProduct;
  }

  void setSelectedIndexProduct(int index) {
    this.selectedProductIndex = index;
  }
  
  Product get product {
    if(selectedProductIndex > -1) {
      return _products[selectedProductIndex];
    }
    return null;
  }

  void setIndexForProduct(int id) {
   selectedProductIndex = _products.indexWhere((Product product) {
      return product.id == id;
    });
  }

  

 Future<Null> fetchProduct10Data(int page, int category_id) async{
  

    try{
       _isLoadingProduct = true;
      String productUrl = '$_productsUrl?category_id=${category_id.toString()}&page=${page.toString()}';
      http.Response responeData = await http.get(productUrl); 
    
      
      final Map<String, dynamic> listData = json.decode(responeData.body);
      _pageCount = listData['data']['page_count'];

      listData['data']['posts'].forEach((dynamic value){
        Product product = Product(
          id: value['id'],
          title:  Url.checkNullString(value['title']),
          shortContent: Url.checkNullString(value['short_content']),
          content: Url.checkNullString(value['content']),
          thumnail: '${Url.baseUrl}${Url.postPath}${value['thumnail']}',
          date: value['created_at'],
          galleries: value['galleries']
        );
      
        _products.add(product);
      });   
      _isLoadingProduct = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR Product===============');
      print(e.toString());
      print('===========ERROR Product===============');
      _isLoadingProduct = false;
      notifyListeners();
    }
   
  }

  int get getPageCountProduct {
    return _pageCount;
  }
  
  

  



}

