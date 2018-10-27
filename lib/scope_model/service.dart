import 'package:scoped_model/scoped_model.dart';
import 'package:bbu_app/models/service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/url.dart';

class ServiceModel extends Model {
  
  List<Service> _services = [];
  final String _servicesUrl = Url.baseUrl + 'posts?categories=18&fields=,id,title.rendered,date,content.rendered,excerpt.rendered,better_featured_image.source_url&order=desc';
  bool _isLoadingService = true;
  int selectedServiceIndex = 0;
  int _pageCount = 0;
  Future<Null> fetchServiceData(int page) async{
    try{
       _isLoadingService = true;
      String serviceUrl = _servicesUrl + '&page=' + page.toString();
      http.Response responeData = await http.get(serviceUrl); 
     
      _pageCount = int.parse(responeData.headers['x-wp-totalpages']);
      
      final List<dynamic> listData = json.decode(responeData.body);
      final List<Service> _servicesList = [];
      
      listData.forEach((dynamic value){
        Service service = Service(
          id: value['id'],
          date:  value['date'],
          title: value['title']['rendered'],
          image: value['better_featured_image']['source_url'],
          shortContent: value['excerpt']['rendered'],
          longContent: value['content']['rendered']
        );
      
        _servicesList.add(service);
      });   
      _services = _servicesList;
      _isLoadingService = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR Service===============');
      print(e.toString());
      print('===========ERROR Service===============');
      _isLoadingService = false;
      notifyListeners();
    }
   
  }

  

  List<Service> get getService{
    return _services;
  }

  bool get isLoadingService {
    return _isLoadingService;
  }

  void setSelectedIndexService(int index) {
    this.selectedServiceIndex = index;
  }
  
  Service get service {
    if(selectedServiceIndex > -1) {
      return _services[selectedServiceIndex];
    }
    return null;
  }

  void setIndexForService(int id) {
   selectedServiceIndex = _services.indexWhere((Service service) {
      return service.id == id;
    });
  }

  

 Future<Null> fetchService10Data(int page) async{
    try{
       _isLoadingService = true;
      String serviceUrl = _servicesUrl + '&page=' + page.toString();
      http.Response responeData = await http.get(serviceUrl); 

      final List<dynamic> listData = json.decode(responeData.body);
   
      listData.forEach((dynamic value){
        Service service = Service(
          id: value['id'],
          date:  value['date'],
          title: value['title']['rendered'],
          image: value['better_featured_image']['source_url'],
          shortContent: value['excerpt']['rendered'],
          longContent: value['content']['rendered']
        );
         _services.add(service);
      });   
      _isLoadingService = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR===============');
      print(e.toString());
      print('===========ERROR===============');
      _isLoadingService = false;
      notifyListeners();
    }
   
  }

  int get getPageCountService {
    return _pageCount;
  }
  
  

  



}
