import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scope_model/main.dart';
import '../../models/url.dart';

class VideoCategoryPage extends StatefulWidget {
  final MainModel model;
  
  VideoCategoryPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return new _VideoCategoryPage();
  }
}

class _VideoCategoryPage extends State<VideoCategoryPage> {
  
  int page = 1;
  ScrollController controller;
  
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    widget.model.fetchVideoCategoryData(page);
    
  }

  void dispose() { 
    super.dispose();
  }

  

  Widget _buildMainList(BuildContext context) {
    return new ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = new Center(
        child: new Text('No Data Found...!'),
      );
      if (model.getVideoCategory.length > 0 && !model.isLoadingVideoCategory) {
        content = _buildListView(context, model);
      } else if (model.isLoadingVideoCategory) {
        content = Center(
          child: CircularProgressIndicator(),
        );
      }
      return content;
    });
  }

  Widget _buildListView(BuildContext context, MainModel model) {
   
      return new ListView.builder(
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          model.setSelectedIndexVideoCategory(index);
          String id = model.videoCategory.id.toString();
          return Card(
            child: ListTile(
              leading: new Icon(Icons.video_library),
              title: Text(
                '${model.videoCategory.name}',
                softWrap: true,
              ),
              onTap: () {
                Navigator.pushNamed(
                context, '/${Url.routeVideo}/$id');
              },
            ),
          );
        },
        itemCount: model.getVideoCategory.length,
      );
    
  }

 
  Widget _buildOverllowTextView(String title, TextStyle textStyle, {TextOverflow textOverflow = TextOverflow.ellipsis, int maxNo = 1}) {
    return new Text(
        title,
        overflow: textOverflow,
        style: textStyle,
        maxLines: maxNo,
        textAlign: TextAlign.justify,
    );

  }

 

  Widget _buildDateTextView(String title, TextStyle textStyle, bool isWrap) {
    return Row(children: <Widget>[
      new Icon(Icons.timer, size: 13.0),
      new SizedBox(width: 5.0,),
      new Text(
        title,
        softWrap: isWrap,
        style: textStyle,
        
      )
    ],);

  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Video Category"),
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
  
  void _scrollListener() {
    if (controller.position.extentAfter == 0) {
      page++;
      if(page <= widget.model.getPageCountVideoCategory) {
        widget.model.fetchVideoCategory10Data(page);
        // print('====================================== Last Index $page setState......!! ====================================== ');
      }
     
    }
  }


}
