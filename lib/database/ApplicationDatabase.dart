
import 'package:floor/floor.dart';
import 'package:news_app/database/daos/Userdao.dart';
import 'package:news_app/database/entities/User.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part "ApplicationDatabase.g.dart";


@Database(entities: [User], version: 1)
abstract class ApplicationDatabase extends FloorDatabase {
  Userdao get userdao;
}

