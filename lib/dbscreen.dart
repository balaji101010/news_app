import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/database/ApplicationDatabase.dart';
import 'package:news_app/database/entities/User.dart';
import 'package:news_app/userlist_screen.dart';

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
  void initState() {
    super.initState();
    DbInstance.getInstance().then((value) {
      database = value;
    });
  }

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController pswdcontroller = new TextEditingController();

  Future<void> storeToDatabase(String name, String password) async {
    await database.userdao.insertUser(new User(name: name, password: password));
    getFromDatabase();
  }

  Future<void> updateUser(String name,String password) async {
    await database.userdao.updateUser(new User(name: name, password: password));
    getFromDatabase();
  }

  Future<void> getFromDatabase() async {
    await database.userdao.getUsersList().then((value) {
      value.forEach((user) {
        print(user.toString());
      });
    });
  }

  void getUserfromId(int id){
    database.userdao.getUserFromId(id).then((value){
      print(value.name);
    });
  }

  void getAllUsers(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return UserList();
    }));
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
            color: Colors.black,
            child: Text('ok',style: TextStyle(color: Colors.white),),
            onPressed: () {
              storeToDatabase(namecontroller.text.toString(),
                  pswdcontroller.text.toString());
            },
          ),
          MaterialButton(
            color: Colors.black,
            child: Text('show list',style: TextStyle(color: Colors.white),),
            onPressed: () {
              getAllUsers();
            },
          ),
        ],
      ),
    );
  }
}
