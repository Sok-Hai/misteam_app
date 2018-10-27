import 'package:scoped_model/scoped_model.dart';
import 'package:bbu_app/models/contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/url.dart';

class ContactModel extends Model {
  
  
  List<Contact> _contacts = [];
  final String _contactsUrl = Url.baseUrl + 'api/contacts';
  bool _isLoadingContact = true;
  int selectedContactIndex = 0;
  
  Future<Null> fetchContactData() async{
    _contacts = new List<Contact>();
    try{
       _isLoadingContact = true;
      http.Response responeData = await http.get(_contactsUrl); 
    
      
      final Map<String, dynamic> listData = json.decode(responeData.body);
      final List<Contact> _contactsList = [];
     
     

      listData['data'].forEach((dynamic value){
        Contact contact = Contact(
          id: value['id'],
          name: value['name'],
          mobile: value['mobile'].split("/"),
          email: value['email'],
          
        );
      
        _contactsList.add(contact);
      
      });   
      _contacts = _contactsList;
      _isLoadingContact = false;
      notifyListeners();

    } catch(e) {
      
      print('===========ERROR Contact===============');
      print(e.toString());
      print('===========ERROR Contact===============');
      _isLoadingContact = false;
      notifyListeners();
    }
   
  }

  

  List<Contact> get getContact{
    return _contacts;
  }

  bool get isLoadingContact {
    return _isLoadingContact;
  }

  void setSelectedIndexContact(int index) {
    this.selectedContactIndex = index;
  }
  
  Contact get contact {
    if(selectedContactIndex > -1) {
      return _contacts[selectedContactIndex];
    }
    return null;
  }

  void setIndexForContact(int id) {
   selectedContactIndex = _contacts.indexWhere((Contact contact) {
      return contact.id == id;
    });
  }

  


}
