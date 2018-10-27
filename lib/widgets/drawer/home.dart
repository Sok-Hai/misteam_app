import 'package:flutter/material.dart';
import '../../models/url.dart';

class HomePageDrawer extends StatelessWidget {
  Widget _buildHomePageDrawer(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        new DrawerHeader(
          child: new Center(
            child: new Image(
              image: AssetImage('assets/logo.png'),
              width: 100.0,
              height: 100.0,
            ),
          ),
          decoration: new BoxDecoration(color: Theme.of(context).accentColor),
        ),
        new ListTile(
          leading: new Icon(Icons.home),
          title: new Text('Home'),
          onTap: () {
            print('Tap on Home');
          },
          
        ),
        new ListTile(
          leading: new Icon(Icons.shop),
          title: new Text('Product'),
          onTap: () {
            print('Product');
            Navigator.pop(context);
            Navigator.pushNamed(context, '${Url.routeProduct}');
          },
        ),
        new ListTile(
          leading: new Icon(Icons.settings_applications),
          title: new Text('Services'),
          onTap: () {
            print('Services');
            Navigator.pop(context);
            Navigator.pushNamed(context, '${Url.routeService}');
          },
        ),
        new ListTile(
          leading: new Icon(Icons.group),
          title: new Text('Our Partner'),
          onTap: () {
            print('Our Partner');
            Navigator.pop(context);
            Navigator.pushNamed(context, '${Url.routeOurPartner}');
          },
        ),
        new ListTile(
          leading: new Icon(Icons.insert_drive_file),
          title: new Text('Template'),
          onTap: () {
            print('Tap on Template');
            Navigator.pop(context);
            Navigator.pushNamed(context, '${Url.routeTemplate}');
          },
        ),
        new ListTile(
          leading: new Icon(Icons.contact_mail),
          title: new Text('Contact Us'),
          onTap: () {
            print('Tap on Contact Us');
            Navigator.pop(context);
            Navigator.pushNamed(context, '${Url.routeContact}');
          },
        ),
        new ListTile(
          leading: new Icon(Icons.video_library),
          title: new Text('Videos Trainning'),
          onTap: () {
            print('Tap on Videos Trainning');
            Navigator.pop(context);
            Navigator.pushNamed(context, '${Url.routeVideoCategory}');
          },
        ),
        new ListTile(
          leading: new Icon(Icons.info_outline),
          title: new Text('About Us'),
          onTap: () {
            print('Tap on About Us');
            Navigator.pop(context);
            Navigator.pushNamed(context, '${Url.route404NotFound}');
          },
        ),
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildHomePageDrawer(context);
  }
}
