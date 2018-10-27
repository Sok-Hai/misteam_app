import 'package:flutter/material.dart';

class Service {

  int id;
  String title;
  String date;
  String image;
  String shortContent;
  String longContent;
 
  
  
  Service({
    @required this.id,
    @required this.title,
    @required this.date,
    @required this.image,
    @required this.shortContent,
    @required this.longContent
  });

}