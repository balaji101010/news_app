import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/SearchResponse.dart';

class Detail extends StatefulWidget {
  Article article;

  Detail(this.article);

  @override
  State<StatefulWidget> createState() {
    return DetailState(article);
  }
}

class DetailState extends State<Detail> {

  Article article;

  DetailState(this.article);

  Widget newsChilds(Article article) {
    return Container(
      child: GestureDetector(
        child: Card(
          borderOnForeground: true,
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              article.urlToImage != null
                  ? Image.network(article.urlToImage,
                          width: double.infinity, fit: BoxFit.cover)
                  : Image.asset("images/default.jpeg",
                          width: double.infinity, fit: BoxFit.cover),

              Container(
                padding: EdgeInsets.all(10),
                child: Text(article.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(article.description,
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newsChilds(article),
    );
  }
}
