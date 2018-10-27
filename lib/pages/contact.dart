import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scope_model/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  final MainModel model;

  ContactPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return new _ContactPage();
  }
}


class _ContactPage extends State<ContactPage> {
  void initState() {
    super.initState();
    widget.model.fetchContactData();
  }

  void dispose() {
    super.dispose();
  }

  _launchURL(String url) async {
    // const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildMainList(BuildContext context) {
    return new ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = new Center(
        child: new Text('No Data Found...!'),
      );
      if (model.getContact.length > 0 && !model.isLoadingContact) {
        content = _buildListView(context, model);
      } else if (model.isLoadingContact) {
        content = Center(
          child: CircularProgressIndicator(),
        );
      }
      return content;
    });
  }

  Widget _buildListView(BuildContext context, MainModel model) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        model.setSelectedIndexContact(index);

        return _buildCardView(
            id: model.contact.id,
            name: model.contact.name,
            mobile: model.contact.mobile,
            email: model.contact.email);
      },
      itemCount: model.getContact.length,
    );
  }

  Widget _buildOverllowTextView(String title, TextStyle textStyle,
      {TextOverflow textOverflow = TextOverflow.ellipsis, int maxNo = 1}) {
    return new Text(
      title,
      overflow: textOverflow,
      style: textStyle,
      maxLines: maxNo,
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildOverllowTextViewLaunch(String launch, String title, TextStyle textStyle,
      {TextOverflow textOverflow = TextOverflow.ellipsis, int maxNo = 1}) {
    return GestureDetector(
        onTap: () => _launchURL('$launch$title'),
        child: Text(
        title,
        overflow: textOverflow,
        style: textStyle,
        maxLines: maxNo,
        textAlign: TextAlign.justify,
      )
    );
  }

  Widget _buildDateTextView(String title, TextStyle textStyle, bool isWrap) {
    return Row(
      children: <Widget>[
        new Icon(Icons.timer, size: 13.0),
        new SizedBox(
          width: 5.0,
        ),
        new Text(
          title,
          softWrap: isWrap,
          style: textStyle,
        )
      ],
    );
  }

  Widget _buildCardView({int id, String name, List<String> mobile, String email}) {
    List<Widget> mobileList = [];
    mobile.forEach((String value){
      return mobileList.add(
        _buildOverllowTextViewLaunch(
          'tel:',
          value.trim(),
          TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0),
        )
      );
    });
    return Card(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new SizedBox(
                  height: 5.0,
                ),
                _buildOverllowTextView(
                  '$name',
                  TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                new SizedBox(
                  height: 5.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildOverllowTextView(
                      'Mobile: ',
                      TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    Column(
                      children: mobileList
                    )
                  ],
                ),
                new SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    _buildOverllowTextView(
                      'Email: ',
                      TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    _buildOverllowTextViewLaunch(
                      'mailto:',
                      '$email',
                      TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Contact"),
        ),
        body: new Column(children: <Widget>[
          new Expanded(
            child: new Container(
              margin: EdgeInsets.all(5.0),
              child: _buildMainList(context),
            ),
          )
        ]));
  }
}
