import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../scope_model/main.dart';
import '../../models/url.dart';

class ProductPage extends StatefulWidget {
  final MainModel model;
  final int category_id;
  final List<String> pageTitle = [
    'Products',
    'Services',
    'Our Partner',
    'Templates'
  ];
  
  ProductPage(this.model, this.category_id);

  @override
  State<StatefulWidget> createState() {
    return new _ProductPage();
  }
}

class _ProductPage extends State<ProductPage> {
  
  int page = 1;
  ScrollController controller;
  
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    widget.model.fetchProductData(page, widget.category_id);
    
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
      if (model.getProduct.length > 0 && !model.isLoadingProduct) {
        content = _buildListView(context, model);
      } else if (model.isLoadingProduct) {
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
         
          model.setSelectedIndexProduct(index);
          
          return _buildCardView(
              id: model.product.id,
              title:  model.product.title,
              image:  model.product.thumnail,
              date:  model.product.date,
              shortContent: model.product.shortContent
          );
        },
        itemCount: model.getProduct.length,
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


  Widget _buildCardView(
      {int id,
      String title,
      String date,
      String image,
      String shortContent}) {
    return new GestureDetector(
      onTap: () {
       
        Navigator.pushNamed(
            context, '/${Url.routeProductList}/${id.toString()}');
      },
      child: Card(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage(
              image: NetworkImage(image),
              placeholder: AssetImage(Url.noImage),
              height: 120.0,
              width: 120.0,
              fit: BoxFit.contain,
            ),
            new SizedBox(
              width: 10.0,
            ),
            new Flexible(
              child: 
            
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new SizedBox(
                  height: 5.0,
                ),
                _buildOverllowTextView(
                  '$title',
                  TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                
                  
                ),
                new SizedBox(
                  height: 5.0,
                ),
                _buildDateTextView(
                  date, 
                  TextStyle(
                    fontSize: 13.0, 
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                    
                  ),
                  true),
                // new SizedBox(
                //   height: 5.0,
                // ),
                _buildOverllowTextView(
                  shortContent,
                  TextStyle(
                    fontSize: 13.0, 
                  ),
                  maxNo: 3
                ),
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
          title: new Text(widget.pageTitle[widget.category_id - 1]),
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
      if(page <= widget.model.getPageCountProduct) {
        widget.model.fetchProduct10Data(page, widget.category_id);
        // print('====================================== Last Index $page setState......!! ====================================== ');
      }
     
    }
  }


}
