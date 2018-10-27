import 'package:flutter/material.dart';

class Contact {

  int id;
  String name;
  List<String> mobile;
  String email;

  Contact({
    @required this.id,
    @required this.name,
    @required this.mobile,
    @required this.email
  });

}