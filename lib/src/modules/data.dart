import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mysql1/mysql1.dart' as mysql;
import 'package:postgres/postgres.dart' as pg;
import 'dart:async';
import 'dart:io';

part 'data.g.dart';

abstract class DatabaseConfig {
  Future<dynamic> connect();
}

class SQLiteConfig implements DatabaseConfig {
  @override
  Future<DatabaseConnection> connect() async {
    return DatabaseConnection(NativeDatabase(File('cheetah_database.sqlite')));
  }
}

class MySQLConfig implements DatabaseConfig {
  final String host;
  final int port;
  final String user;
  final String password;
  final String database;

  MySQLConfig({
    required this.host,
    required this.port,
    required this.user,
    required this.password,
    required this.database,
  });

  @override
  Future<mysql.MySqlConnection> connect() async {
    return mysql.MySqlConnection.connect(mysql.ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: database,
    ));
  }
}

class PostgreSQLConfig implements DatabaseConfig {
  final String host;
  final int port;
  final String user;
  final String password;
  final String database;

  PostgreSQLConfig({
    required this.host,
    required this.port,
    required this.user,
    required this.password,
    required this.database,
  });

  @override
  Future<pg.Connection> connect() async {
    final connection = await pg.Connection.open(pg.Endpoint(
      host: host,
      port: port,
      database: database,
      username: user,
      password: password,
    ));
    return connection;
  }
}

class DatabaseManager {
  late DatabaseConfig _config;
  dynamic _connection;

  void setConfig(DatabaseConfig config) {
    _config = config;
  }

  Future<dynamic> getConnection() async {
    _connection ??= await _config.connect();
    return _connection;
  }
}

final databaseManager = DatabaseManager();

@DataClassName('User')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get email => text().unique()();
}

@DriftDatabase(tables: [Users])
class DatabaseService extends _$DatabaseService {
  DatabaseService(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 1;

  Future<void> runInTransaction(Future<void> Function() action) async {
    return transaction(() => action());
  }
}
