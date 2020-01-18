


import 'package:floor/floor.dart';

@Entity(tableName: 'table_user')
class User{

  @PrimaryKey(autoGenerate: true)
  int id;

  String name;

  String password;

  User({this.id,this.name,this.password});

}