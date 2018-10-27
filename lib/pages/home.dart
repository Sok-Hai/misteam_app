import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:map_view/map_view.dart';

import '../scope_model/main.dart';
import '../widgets/drawer/home.dart';
import '../models/url.dart';

class HomePage extends StatefulWidget {
  final MainModel model;

  HomePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  
  Color _borderColor;
  Color _menuButtonColor;
  Color _menuTextColor;
  Color _menuButtonSplashColor;
  MapView mapView = new MapView();
  List<Marker> markers;
  Marker marker;
  
  _HomePage() {
    _borderColor = Colors.white24;
    _menuTextColor = Colors.white;
    _menuButtonColor = Color(0xFF121359);
    _menuButtonSplashColor = Color(0xFF16188E);
    
  
  }

  void initState() {
    super.initState();
    widget.model.fetchBannerData();
  }

void showMap() async{
    markers = await widget.model.fetchMapData();
    Location location = new Location(markers[0].latitude, markers[0].longitude);
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition:
                new CameraPosition(location, 14.0),
            title: 'Location'),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    mapView.onMapReady.listen((_) {
      mapView.setMarkers(markers);
    });

    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });
  }
  Widget _buildMenuItem({String title, String routeUrl, IconData icon}) {
    return  Container(
      decoration:
          new BoxDecoration(border: Border.all(color: this._borderColor, width: 0.5)),
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, routeUrl);
        },
        splashColor: this._menuButtonSplashColor,
        color: this._menuButtonColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon, 
              color: this._menuTextColor,
              size: 35.0,
            ),
            SizedBox(height: 5.0,),
            Text(
              title,
              softWrap: true,
              style: TextStyle(color: this._menuTextColor),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ),
    );
  }


  Widget _buildMenuLocation({String title, Function showMap, IconData icon}) {
    return  Container(
      decoration:
          new BoxDecoration(border: Border.all(color: this._borderColor, width: 0.5)),
      child: FlatButton(
        onPressed: () {
          showMap();
        },
        splashColor: this._menuButtonSplashColor,
        color: this._menuButtonColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon, 
              color: this._menuTextColor,
              size: 35.0,
            ),
            SizedBox(height: 5.0,),
            Text(
              title,
              softWrap: true,
              style: TextStyle(color: this._menuTextColor),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ),
    );
  }



  Widget buildSlideImage() {
    Widget content = Center(child: Text('No banner found....!'),);
    if (widget.model.bannerImage.length > 0 && !widget.model.isLoadingBanner) {
        content = buildCarousel();
      } else if (widget.model.isLoadingBanner) {
        content = Center(
          child: CircularProgressIndicator(),
        );
      }
    return content;
  }

  Widget buildCarousel() {
    return Carousel(
                    images: widget.model.bannerImage,
                    indicatorBgPadding: 15.0,
                  );
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
            appBar: new AppBar(
             
              title: Text('MISTEAMS'),
              
            ),
            drawer: new Drawer(
              child: new HomePageDrawer(),
            ),
            body: Column(children: <Widget>[
              Expanded(
                  child: GridView.count(crossAxisCount: 3, children: <Widget>[
                   _buildMenuItem(
                     title: 'Products',
                     icon: Icons.shop,
                     routeUrl: '${Url.routeProduct}'
                   ),
                  _buildMenuItem(
                     title: 'Services',
                     icon: Icons.settings_applications,
                     routeUrl: '${Url.routeService}'
                   ),
                   _buildMenuItem(
                     title: 'Our Partner',
                     icon: Icons.group,
                     routeUrl: '${Url.routeOurPartner}'
                   ),
                  _buildMenuItem(
                    title: 'Templates',
                    icon: Icons.insert_drive_file,
                    routeUrl: '${Url.routeTemplate}'
                  ),
                   _buildMenuItem(
                     title: 'Contact Us',
                     icon: Icons.contact_mail,
                     routeUrl: '${Url.routeContact}'
                   ),
                  
                   _buildMenuItem(
                     title: 'Videos Trainning',
                     icon: Icons.video_library,
                     routeUrl: '${Url.routeVideoCategory}'
                   ),
                   _buildMenuLocation(
                     title: 'Location',
                     icon: Icons.map,
                     showMap: showMap
                   ),
                   _buildMenuItem(
                     title: 'Menu2',
                     icon: Icons.menu,
                     routeUrl: '${Url.route404NotFound}'
                   ),
                   _buildMenuItem(
                     title: 'Menu3',
                     icon: Icons.menu,
                     routeUrl: '${Url.route404NotFound}'
                   ),
              ])),
              SizedBox(
                  height: 200.0,
                  child: buildSlideImage())
            ]));
      },
    );
  }
}
