import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/database/ApplicationDatabase.dart';
import 'package:news_app/database/daos/Userdao.dart';
import 'DatabaseInstance.dart';
import 'database/entities/User.dart';

class UserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> {
  ApplicationDatabase _database;
  Userdao dao;
  Stream<List<User>> stream;

  @override
  void initState() {
    super.initState();
    DbInstance.getInstance().then((instance) {
      setState(() {
        _database = instance;
        stream = _database.userdao.getAllUsers();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<User>>(
      stream: stream,
      builder: (context, userList) {
        final List<User> users = userList.data ?? List();
        return userList.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, count) {
                  return ListTile(
                      title: Text(userList.data[count].name),
                      subtitle: Text(userList.data[count].password));
                })
            : Center(child: CircularProgressIndicator());
      },
    ));
  }
}
