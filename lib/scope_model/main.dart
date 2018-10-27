import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:map_view/map_view.dart';

import './product.dart';
import './contact.dart';
import './video_category.dart';
import './video.dart';

import '../models/url.dart';

class MainModel extends Model
    with ProductModel, ContactModel, VideoCategoryModel, VideoModel {
  final List<dynamic> bannerImage = [];
  final List<Marker> markers = [];
  bool isLoadingBanner = true;
  Future<Null> fetchBannerData() async {
    try {
      isLoadingBanner = true;
      final String bannerUrl = Url.baseUrl + 'api/banners';

      http.Response responeData = await http.get(bannerUrl);

      final Map<String, dynamic> listData = json.decode(responeData.body);

      listData['data'].forEach((dynamic value) {
        bannerImage.add(
          NetworkImage('${Url.baseUrl}${Url.bannerPath}${value['banner']}'),
        );
      });
      isLoadingBanner = false;
      notifyListeners();
    } catch (e) {
      print('===========ERROR WP Data===============');
      print(e.toString());
      print('===========ERROR WP Data===============');
      isLoadingBanner = false;
      notifyListeners();
    }
  }

  Future<List<Marker>> fetchMapData() async {
    try {
      final String addressUrl = Url.baseUrl + 'api/addresses';

      http.Response responeData = await http.get(addressUrl);

      final Map<String, dynamic> listData = json.decode(responeData.body);

      listData['data'].forEach((dynamic value) {
        markers.add(
          new Marker(Url.apiKeyStaticMap, value['name'], value['latitude'],
              value['longtitude'],
              color: Colors.red),
        );
      });
      return markers;
    } catch (e) {
      print('===========ERROR WP Data===============');
      print(e.toString());
      print('===========ERROR WP Data===============');

      return markers;
    }
  }
}
