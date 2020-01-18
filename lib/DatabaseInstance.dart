
import 'package:news_app/database/ApplicationDatabase.dart';

class DbInstance{

   static Future<ApplicationDatabase> getInstance() async {
    final dbInstance =  await $FloorApplicationDatabase.databaseBuilder(
        "user_database").build();
    return dbInstance;
  }

}