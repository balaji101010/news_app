// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApplicationDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorApplicationDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ApplicationDatabaseBuilder databaseBuilder(String name) =>
      _$ApplicationDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ApplicationDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ApplicationDatabaseBuilder(null);
}

class _$ApplicationDatabaseBuilder {
  _$ApplicationDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$ApplicationDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ApplicationDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ApplicationDatabase> build() async {
    final database = _$ApplicationDatabase();
    database.database = await database.open(
      name ?? ':memory:',
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ApplicationDatabase extends ApplicationDatabase {
  _$ApplicationDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  Userdao _userdaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations,
      [Callback callback]) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_user` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `password` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  Userdao get userdao {
    return _userdaoInstance ??= _$Userdao(database, changeListener);
  }
}

class _$Userdao extends Userdao {
  _$Userdao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'table_user',
            (User item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _table_userMapper = (Map<String, dynamic> row) =>
      User(id: row['id'] as int, name: row['name'] as String, password: row['password'] as String);

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<List<User>> getUsersList() async {
    return _queryAdapter.queryList('select * from table_user',
        mapper: _table_userMapper);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, sqflite.ConflictAlgorithm.ignore);
  }
}
