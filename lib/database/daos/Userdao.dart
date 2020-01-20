

import 'package:floor/floor.dart';
import 'package:news_app/database/entities/User.dart';

@dao
abstract class Userdao{

  @Query("select * from table_user")
  Future<List<User>> getUsersList();

  @Insert(onConflict: OnConflictStrategy.IGNORE)
  Future<void> insertUser(User user);

  @update
  Future<void> updateUser(User user);

  @Query("select * from table_user where id == :id")
  Future<User> getUserFromId(int id);

  @delete
  Future<void> deleteUser(User user);

  @Query("select * from table_user")
  Stream<List<User>> getAllUsers();


}