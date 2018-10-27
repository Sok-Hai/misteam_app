import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../../scope_model/main.dart';
import '../../models/url.dart';

class VideoPage extends StatefulWidget {
  final MainModel model;
  final int category_id;

  VideoPage(this.model, this.category_id);

  @override
  State<StatefulWidget> createState() {
    return new _VideoPage();
  }
}

class _VideoPage extends State<VideoPage> {
  int page = 1;
  ScrollController controller;

  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    widget.model.fetchVideoData(page, widget.category_id);
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
      if (model.getVideo.length > 0 && !model.isLoadingVideo) {
        content = _buildListView(context, model);
      } else if (model.isLoadingVideo) {
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
        model.setSelectedIndexVideo(index);

        return _buildCardView(
            id: model.video.id,
            title: model.video.title,
            content: model.video.content,
            youtubeId: model.video.youtubeId,
            thumnail: model.video.thumbnail);
      },
      itemCount: model.getVideo.length,
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

  // Widget _buildHTMLTextView(String title) {
  //   String htmlText = title;
  //   if(title.length > 100) {
  //     htmlText = title.substring(0,100) + ' ...';
  //   }
  //   return Html(
  //     data: htmlText,
  //   );

  // }

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

  void playYoutubeVideo(String youtubeId) {
    FlutterYoutube.playYoutubeVideoByUrl(
        apiKey: "<API_KEY>",
        videoUrl: "https://www.youtube.com/watch?v=$youtubeId",
        autoPlay: true);
  }

  Widget _buildCardView(
      {int id,
      String title,
      String content,
      String youtubeId,
      String thumnail}) {
    return new GestureDetector(
      onTap: () {
        playYoutubeVideo(youtubeId);
      },
      child: Card(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Flexible(
                child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new SizedBox(
                  height: 5.0,
                ),
                FadeInImage(
                  image: NetworkImage(thumnail),
                  placeholder: AssetImage(Url.noImage),
                  fit: BoxFit.contain,
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: _buildOverllowTextView(
                      '$title',
                      TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                      maxNo: 3),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Video"),
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
      if (page <= widget.model.getPageCountVideo) {
        widget.model.fetchVideo10Data(page, widget.category_id);
        // print('====================================== Last Index $page setState......!! ====================================== ');
      }
    }
  }
}
