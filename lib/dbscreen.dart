import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserState();
  }
}

class UserState extends State<User> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController pswdcontroller = new TextEditingController();

  void storeToDatabase(String name, String password) {
    
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
          )
        ],
      ),
    );
  }
}
