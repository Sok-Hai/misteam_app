
import 'package:scoped_model/scoped_model.dart';
import 'package:bbu_app/models/video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/url.dart';

class VideoModel extends Model {
  
  
  List<Video> _videos = [];
  final String _videosUrl = Url.baseUrl + 'api/videos_training';
  bool _isLoadingVideo = true;
  int selectedVideoIndex = 0;
  int _pageCount = 0;
  
  Future<Null> fetchVideoData(int page, int category_id) async{
    _videos = new List<Video>();
    try{
       _isLoadingVideo = true;
      String videoUrl = '$_videosUrl?category_id=${category_id.toString()}&page=${page.toString()}';
      http.Response responeData = await http.get(videoUrl); 
    
      
      final Map<String, dynamic> listData = json.decode(responeData.body);
      final List<Video> _videosList = [];
      _pageCount = listData['data']['page_count'];

     

      listData['data']['video_training'].forEach((dynamic value){
        Video video = Video(
          id: value['id'],
          title:  value['title'],
          content: value['content'],
          youtubeId: value['youtube_id'],
          order: value['order'],
          thumbnail: 'https://img.youtube.com/vi/${value["youtube_id"]}/0.jpg'
        );
      
        _videosList.add(video);
      
      });   
      _videos = _videosList;
      _isLoadingVideo = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR Video===============');
      print(e.toString());
      print('===========ERROR Video===============');
      _isLoadingVideo = false;
      notifyListeners();
    }
   
  }

  

  List<Video> get getVideo{
    return _videos;
  }

  bool get isLoadingVideo {
    return _isLoadingVideo;
  }

  void setSelectedIndexVideo(int index) {
    this.selectedVideoIndex = index;
  }
  
  Video get video {
    if(selectedVideoIndex > -1) {
      return _videos[selectedVideoIndex];
    }
    return null;
  }

  void setIndexForVideo(int id) {
   selectedVideoIndex = _videos.indexWhere((Video video) {
      return video.id == id;
    });
  }

  

 Future<Null> fetchVideo10Data(int page, int category_id) async{
  

    try{
       _isLoadingVideo = true;
      String videoUrl = '$_videosUrl?category_id=${category_id.toString()}&page=${page.toString()}';
      http.Response responeData = await http.get(videoUrl); 
    
      
      final Map<String, dynamic> listData = json.decode(responeData.body);
      _pageCount = listData['data']['page_count'];

      listData['data']['video_training'].forEach((dynamic value){
        Video video = Video(
          id: value['id'],
          title:  value['title'],
          content: value['content'],
          youtubeId: value['youtube_id'],
          order: value['order'],
          thumbnail: 'https://img.youtube.com/vi/${value["youtube_id"]}/0.jpg'
        );
      
        _videos.add(video);
      });   
      _isLoadingVideo = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR Video===============');
      print(e.toString());
      print('===========ERROR Video===============');
      _isLoadingVideo = false;
      notifyListeners();
    }
   
  }

  int get getPageCountVideo {
    return _pageCount;
  }
  
  

  



}
