import 'package:flutter/material.dart';

class Video {

  int id;
  String title;
  String content;
  String youtubeId;
  String thumbnail;
  int order;
 
  
  
  Video({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.youtubeId,
    @required this.order,
    @required this.thumbnail
  });

}