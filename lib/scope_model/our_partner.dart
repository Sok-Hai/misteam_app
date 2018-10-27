import 'package:scoped_model/scoped_model.dart';
import 'package:bbu_app/models/our_partner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/url.dart';

class OurPartnerModel extends Model {
  
  List<OurPartner> _ourPartners = [];
  final String _ourPartnersUrl = Url.baseUrl + 'posts?categories=24&fields=,id,title.rendered,date,content.rendered,excerpt.rendered,better_featured_image.source_url&order=desc';
  bool _isLoadingOurPartner = true;
  int selectedOurPartnerIndex = 0;
  int _pageCount = 0;
  Future<Null> fetchOurPartnerData(int page) async{
    try{
       _isLoadingOurPartner = true;
      String ourPartnerUrl = _ourPartnersUrl + '&page=' + page.toString();
      http.Response responeData = await http.get(ourPartnerUrl); 
     
      _pageCount = int.parse(responeData.headers['x-wp-totalpages']);
      
      final List<dynamic> listData = json.decode(responeData.body);
      final List<OurPartner> _ourPartnersList = [];
      
      listData.forEach((dynamic value){
        OurPartner ourPartner = OurPartner(
          id: value['id'],
          date:  value['date'],
          title: value['title']['rendered'],
          image: value['better_featured_image']['source_url'],
          shortContent: value['excerpt']['rendered'],
          longContent: value['content']['rendered']
        );
      
        _ourPartnersList.add(ourPartner);
      });   
      _ourPartners = _ourPartnersList;
      _isLoadingOurPartner = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR OurPartner===============');
      print(e.toString());
      print('===========ERROR OurPartner===============');
      _isLoadingOurPartner = false;
      notifyListeners();
    }
   
  }

  

  List<OurPartner> get getOurPartner{
    return _ourPartners;
  }

  bool get isLoadingOurPartner {
    return _isLoadingOurPartner;
  }

  void setSelectedIndexOurPartner(int index) {
    this.selectedOurPartnerIndex = index;
  }
  
  OurPartner get ourPartner {
    if(selectedOurPartnerIndex > -1) {
      return _ourPartners[selectedOurPartnerIndex];
    }
    return null;
  }

  void setIndexForOurPartner(int id) {
   selectedOurPartnerIndex = _ourPartners.indexWhere((OurPartner ourPartner) {
      return ourPartner.id == id;
    });
  }

  

 Future<Null> fetchOurPartner10Data(int page) async{
    try{
       _isLoadingOurPartner = true;
      String ourPartnerUrl = _ourPartnersUrl + '&page=' + page.toString();
      http.Response responeData = await http.get(ourPartnerUrl); 

      final List<dynamic> listData = json.decode(responeData.body);
   
      listData.forEach((dynamic value){
        OurPartner ourPartner = OurPartner(
          id: value['id'],
          date:  value['date'],
          title: value['title']['rendered'],
          image: value['better_featured_image']['source_url'],
          shortContent: value['excerpt']['rendered'],
          longContent: value['content']['rendered']
        );
         _ourPartners.add(ourPartner);
      });   
      _isLoadingOurPartner = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR===============');
      print(e.toString());
      print('===========ERROR===============');
      _isLoadingOurPartner = false;
      notifyListeners();
    }
   
  }

  int get getPageCountOurPartner {
    return _pageCount;
  }
  
  

  



}
