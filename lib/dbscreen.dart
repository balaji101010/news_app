import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/database/ApplicationDatabase.dart';
import 'package:news_app/database/entities/User.dart';

import 'DatabaseInstance.dart';

class DBUser extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return UserState();
  }
}

class UserState extends State<DBUser> {

  ApplicationDatabase database;

  List<User> users;
  
  @override
  void initState(){
    super.initState();
    DbInstance.getInstance().then((value){
      database = value;
    });
  }

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController pswdcontroller = new TextEditingController();

  void storeToDatabase(String name, String password) {
    database.userdao.insertUser(new User(id:2,name: name,password:password));
  }
  
  void getFromDatabase(){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database'),
      ),
      body: Column(
        children: <Widget>[
          TextField(controller: namecontroller),
          TextField(controller: pswdcontroller),
          MaterialButton(
            onPressed: () {
              storeToDatabase(namecontroller.text.toString(),
                  pswdcontroller.text.toString());
            },
          ),
          MaterialButton(
            onPressed: (){
              getFromDatabase();
            },
          )
        ],
      ),
    );
  }
}
