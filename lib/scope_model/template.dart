import 'package:scoped_model/scoped_model.dart';
import 'package:bbu_app/models/template.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/url.dart';

class TemplateModel extends Model {
  
  List<Template> _templates = [];
  final String _templatesUrl = Url.baseUrl + 'posts?categories=19&fields=,id,title.rendered,date,content.rendered,excerpt.rendered,better_featured_image.source_url&order=desc';
  bool _isLoadingTemplate = true;
  int selectedTemplateIndex = 0;
  int _pageCount = 0;
  Future<Null> fetchTemplateData(int page) async{
    try{
       _isLoadingTemplate = true;
      String templateUrl = _templatesUrl + '&page=' + page.toString();
      http.Response responeData = await http.get(templateUrl); 
     
      _pageCount = int.parse(responeData.headers['x-wp-totalpages']);
      
      final List<dynamic> listData = json.decode(responeData.body);
      final List<Template> _templatesList = [];
      
      listData.forEach((dynamic value){
        Template template = Template(
          id: value['id'],
          date:  value['date'],
          title: value['title']['rendered'],
          image: value['better_featured_image']['source_url'],
          shortContent: value['excerpt']['rendered'],
          longContent: value['content']['rendered']
        );
      
        _templatesList.add(template);
      });   
      _templates = _templatesList;
      _isLoadingTemplate = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR Template===============');
      print(e.toString());
      print('===========ERROR Template===============');
      _isLoadingTemplate = false;
      notifyListeners();
    }
   
  }

  

  List<Template> get getTemplate{
    return _templates;
  }

  bool get isLoadingTemplate {
    return _isLoadingTemplate;
  }

  void setSelectedIndexTemplate(int index) {
    this.selectedTemplateIndex = index;
  }
  
  Template get template {
    if(selectedTemplateIndex > -1) {
      return _templates[selectedTemplateIndex];
    }
    return null;
  }

  void setIndexForTemplate(int id) {
   selectedTemplateIndex = _templates.indexWhere((Template template) {
      return template.id == id;
    });
  }

  

 Future<Null> fetchTemplate10Data(int page) async{
    try{
       _isLoadingTemplate = true;
      String templateUrl = _templatesUrl + '&page=' + page.toString();
      http.Response responeData = await http.get(templateUrl); 

      final List<dynamic> listData = json.decode(responeData.body);
   
      listData.forEach((dynamic value){
        Template template = Template(
          id: value['id'],
          date:  value['date'],
          title: value['title']['rendered'],
          image: value['better_featured_image']['source_url'],
          shortContent: value['excerpt']['rendered'],
          longContent: value['content']['rendered']
        );
         _templates.add(template);
      });   
      _isLoadingTemplate = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR===============');
      print(e.toString());
      print('===========ERROR===============');
      _isLoadingTemplate = false;
      notifyListeners();
    }
   
  }

  int get getPageCountTemplate {
    return _pageCount;
  }
  
  

  



}
