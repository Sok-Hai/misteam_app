import 'package:flutter/material.dart';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';
import 'scope_model/main.dart';
import './models/url.dart';
import './pages/home.dart';


import './pages/404_not_found.dart';

/* Product */
import './pages/products/product.dart';
import './pages/products/product_list.dart';

/* Video */
import './pages/videos/video_category.dart';
import './pages/videos/video.dart';

/* Contact */
import './pages/contact.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  MapView.setApiKey(Url.apiKeyIos);
  return runApp(new MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  MainModel model = MainModel();
  Widget build(BuildContext context) {
    return new ScopedModel<MainModel>(
      model: model,
      child: new MaterialApp(
        title: 'MISTEAMS',
        theme: ThemeData(
          backgroundColor: Colors.white,
          accentColor: Color(0xFF18196c),
          primaryColor: Color(0xFF18196c)
        ),
        routes: {
          '/': (BuildContext context) => new HomePage(model),
          '${Url.routeProduct}': (BuildContext context) => new ProductPage(model, 1),
          '${Url.routeService}': (BuildContext context) => new ProductPage(model, 2),
          '${Url.routeOurPartner}': (BuildContext context) => new ProductPage(model, 3),
          '${Url.routeTemplate}': (BuildContext context) => new ProductPage(model, 4),
          '${Url.routeVideoCategory}': (BuildContext context) => new VideoCategoryPage(model),
          '${Url.routeContact}': (BuildContext context) => new ContactPage(model),

       
        },
        onGenerateRoute: (RouteSettings setting) {
          print(setting.name);
          final List<String> routeElement =
              setting.name.split('/'); // '/admin/1'

          if (routeElement[0] != '') {
            
            return null;
          }
         
          switch (routeElement[1]) {
            
              case Url.routeProductList:
              {
               
                final int index = int.parse(routeElement[2]);

                return MaterialPageRoute<bool>(
                  builder: (BuildContext context) => ProductList(model, index),
                );
              }

              case Url.routeVideo:
              {
               
                final int index = int.parse(routeElement[2]);

                return MaterialPageRoute<bool>(
                  builder: (BuildContext context) => VideoPage(model, index),
                );
              }
             
           
          }
        },
        onUnknownRoute: (RouteSettings setting){
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => NotFoundPage(),
          );
        },
      ),
    );
  }
}
