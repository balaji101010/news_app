

import 'package:floor/floor.dart';
import 'package:news_app/database/entities/User.dart';

@dao
abstract class Userdao{

  @Query("select * from table_user")
  Future<List<User>> getUsersList();

  @Insert(onConflict: OnConflictStrategy.IGNORE)
  Future<void> insertUser(User user);

}