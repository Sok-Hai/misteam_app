import 'package:flutter/material.dart';

class Product {

  int id;
  String title;
  String shortContent;
  String content;
  String thumnail;
  String date;
  List galleries;
 
  
  
  Product({
    @required this.id,
    @required this.title,
    @required this.shortContent,
    @required this.content,
    @required this.thumnail,
    @required this.date,
    @required this.galleries
  });

}