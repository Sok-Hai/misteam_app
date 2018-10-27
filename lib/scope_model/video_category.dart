import 'package:scoped_model/scoped_model.dart';
import 'package:bbu_app/models/video_category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/url.dart';

class VideoCategoryModel extends Model {
  
  
  List<VideoCategory> _videoCategorys = [];
  final String _videoCategorysUrl = Url.baseUrl + 'api/videos_training_category';
  bool _isLoadingVideoCategory = true;
  int selectedVideoCategoryIndex = 0;
  int _pageCount = 0;
  
  Future<Null> fetchVideoCategoryData(int page) async{
    _videoCategorys = new List<VideoCategory>();
    try{
       _isLoadingVideoCategory = true;
      String videoCategoryUrl = '$_videoCategorysUrl?page=${page.toString()}';
      http.Response responeData = await http.get(videoCategoryUrl); 
    
      
      final Map<String, dynamic> listData = json.decode(responeData.body);
      final List<VideoCategory> _videoCategorysList = [];
      _pageCount = listData['data']['page_count'];

     

      listData['data']['video_training'].forEach((dynamic value){
        VideoCategory videoCategory = VideoCategory(
          id: value['id'],
          name: value['name']
        );
      
        _videoCategorysList.add(videoCategory);
      
      });   
      _videoCategorys = _videoCategorysList;
      _isLoadingVideoCategory = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR VideoCategory===============');
      print(e.toString());
      print('===========ERROR VideoCategory===============');
      _isLoadingVideoCategory = false;
      notifyListeners();
    }
   
  }

  

  List<VideoCategory> get getVideoCategory{
    return _videoCategorys;
  }

  bool get isLoadingVideoCategory {
    return _isLoadingVideoCategory;
  }

  void setSelectedIndexVideoCategory(int index) {
    this.selectedVideoCategoryIndex = index;
  }
  
  VideoCategory get videoCategory {
    if(selectedVideoCategoryIndex > -1) {
      return _videoCategorys[selectedVideoCategoryIndex];
    }
    return null;
  }

  void setIndexForVideoCategory(int id) {
   selectedVideoCategoryIndex = _videoCategorys.indexWhere((VideoCategory videoCategory) {
      return videoCategory.id == id;
    });
  }

  

 Future<Null> fetchVideoCategory10Data(int page) async{
  

    try{
       _isLoadingVideoCategory = true;
      String videoCategoryUrl = '$_videoCategorysUrl?page=${page.toString()}';
      http.Response responeData = await http.get(videoCategoryUrl); 
    
      
      final Map<String, dynamic> listData = json.decode(responeData.body);
      _pageCount = listData['data']['page_count'];

      listData['data']['video_training'].forEach((dynamic value){
        VideoCategory videoCategory = VideoCategory(
          id: value['id'],
          name: value['name']
        );
      
        _videoCategorys.add(videoCategory);
      });   
      _isLoadingVideoCategory = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR VideoCategory===============');
      print(e.toString());
      print('===========ERROR VideoCategory===============');
      _isLoadingVideoCategory = false;
      notifyListeners();
    }
   
  }

  int get getPageCountVideoCategory {
    return _pageCount;
  }
  
  

  



}
