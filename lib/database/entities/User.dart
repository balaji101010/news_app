


import 'package:floor/floor.dart';

@Entity(tableName: 'table_user')
class User{

  @PrimaryKey(autoGenerate: true)
  final int id;

  final String name;

  final String password;

  User({this.id,this.name,this.password});

  @override
  String toString() {
    return 'User{id: $id, name: $name, password: $password}';
  }


}