import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:news_app/api/ApiClient.dart';
import 'package:news_app/detailScreen.dart';
import 'package:news_app/models/ErrorResponse.dart';
import 'package:news_app/models/SearchResponse.dart';

import 'constants.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Retrofit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  static final BaseOptions options = new BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static final Dio dio = new Dio(options);

  final ApiClient apiClient = new ApiClient(dio);

  @override
  _MyHomePageState createState() => _MyHomePageState(apiClient);
}

class _MyHomePageState extends State<MyHomePage> {
  SearchResponse searchResponse;
  ApiClient apiClient;
  String errorMsg;
  TextEditingController controller = new TextEditingController();
  bool showLoader = true;

  _MyHomePageState(this.apiClient);

  @override
  void initState() {
    super.initState();
    apiClient.getSearchResults("india", Constants.API_KEY).then((value) {
      setState(() {
        showLoader = false;
        searchResponse = value;
        print(searchResponse.toString());
      });
    }, onError: (error) {
      String errorString = error.response.toString();
      var ress = jsonDecode(errorString);
      ErrorResponse errorResponse = ErrorResponse.fromJson(ress);
      setState(() {
        showLoader = false;
        errorMsg = errorResponse.message;
      });
    });
  }

  void callApi(String search) {

    setState(() {
      showLoader = true;
    });

    apiClient.getSearchResults(search, Constants.API_KEY).then((value) {
      setState(() {
        showLoader = false;
        searchResponse = value;
        print(searchResponse.toString());
      });
    }, onError: (error) {
      String errorString = error.response.toString();
      var ress = jsonDecode(errorString);
      ErrorResponse errorResponse = ErrorResponse.fromJson(ress);
      setState(() {
        showLoader = false;
        errorMsg = errorResponse.message;
      });
    });
  }

  void goToDetail(Article article) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Detail(article);
    }));
  }

  Widget newsHeader(Article article) {
    return Container(
      child: Column(
        children: <Widget>[
          article.urlToImage != null
              ? Image.network(
                  article.urlToImage,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: 400,
                )
              : Image.asset(
                  "images/default.jpeg",
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: 400,
                ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: Text(
                article.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ))
        ],
      ),
    );
  }

  Widget newsChilds(Article article) {
    return Container(
      child: GestureDetector(
        onTap: () {
          goToDetail(article);
        },
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

  Widget successWidget(SearchResponse response) {
    return showLoader
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: searchResponse.articles.length,
            itemBuilder: (context, position) {
              if (position % 2 == 0) return Divider();
              return newsChilds(searchResponse.articles[position]);
            });
  }

  Widget errorWidget(String errorMsg) {
    return AlertDialog(
      content:
          Text(errorMsg, style: TextStyle(fontSize: 20, color: Colors.red)),
    );
  }

  Widget appBar() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 9,
          child: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(8)),
            child: TextFormField(
              controller: controller,
              maxLines: 1,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(Icons.search)),
                  hintText: "Search",
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  contentPadding: EdgeInsets.only(right: 1)),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: InkWell(
                onTap: () {
                  callApi(controller.text.toString());
                },
                child: Icon(
                  Icons.check_circle,
                  color: Colors.black,
                  size: 30,
                )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(child: Center(child: appBar())),
        ),
        body: errorMsg == null
            ? successWidget(searchResponse)
            : errorWidget(errorMsg));
  }
}
