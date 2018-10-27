import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import '../../models/url.dart';
import '../../scope_model/main.dart';

class ProductList extends StatelessWidget {
  final int id;
  final MainModel model;

  ProductList(this.model, this.id);

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

  Widget _buildTitle(String title, TextStyle textStyle) {
    return new Text(
      title,
      softWrap: true,
      style: textStyle,
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildGalleryListView(BuildContext context, List galleries) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return FadeInImage(
          image:
              NetworkImage('${Url.baseUrl}${Url.postPath}${galleries[index]}'),
          placeholder: AssetImage(Url.noImage),
          fit: BoxFit.contain,
        );
      },
      itemCount: galleries.length,
    );
  }

  Widget _buildGallery(String image) {
    return FadeInImage(
      image: NetworkImage('${Url.baseUrl}${Url.postPath}$image'),
      placeholder: AssetImage(Url.noImage),
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    model.setIndexForProduct(id);
    print(model.product.galleries);
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Detail'),
        ),
        body: Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                margin: EdgeInsets.all(10.0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    new SliverList(
                        delegate: new SliverChildListDelegate([
                      new SizedBox(
                        height: 5.0,
                      ),
                      _buildTitle(
                        '${model.product.title}',
                        TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      new SizedBox(
                        height: 5.0,
                      ),
                      _buildDateTextView(
                          model.product.date,
                          TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          true),
                      new SizedBox(
                        height: 5.0,
                      ),
                      FadeInImage(
                        image: NetworkImage(model.product.thumnail),
                        placeholder: AssetImage(Url.noImage),
                        fit: BoxFit.contain,
                      ),
                      Html(
                        data: """
                          ${model.product.content}
                        """,
                      ),
                    ])),
                    new SliverList(
                      
                      delegate: new SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          model.setIndexForProduct(id);
                          return  Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child:  FadeInImage(
                                image: NetworkImage(
                                    '${Url.baseUrl}${Url.postPath}${model.product.galleries[index]}'),
                                placeholder: AssetImage(Url.noImage),
                                fit: BoxFit.contain,
                              ),
                                                     );
                        },
                        childCount: model.product.galleries.length,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
