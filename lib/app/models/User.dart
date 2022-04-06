import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String userTable = 'user';
const String idColumn = 'id';
const String nameColumn = 'name';
const String loginColumn = 'login';
const String passwordColumn = 'password';

class UserHelper {
  static final UserHelper _instance = UserHelper.interal();

  factory UserHelper() => _instance;

  UserHelper.interal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, '$userTable.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $userTable( $idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $loginColumn TEXT, $passwordColumn TEXT);");
    });
  }

  Future<User> saveUser(User user) async {
    Database dbUser = await db;
    user.id = await dbUser.insert(userTable, user.toMap());
    return user;
  }

  Future<User> getUser(int id) async {
    Database dbUser = await db;
    List<Map> maps = await dbUser.query(userTable,
        columns: [idColumn, nameColumn, loginColumn, passwordColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return User.fromMap(maps.first);
    } else {
      User? user;
      return user!;
    }
  }

  Future<int> deleteUser(int id) async {
    Database dbUser = await db;
    return await dbUser
        .delete(userTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    Database dbUser = await db;
    return await dbUser.update(userTable, user.toMap(),
        where: "$idColumn = ?", whereArgs: [user.id]);
  }

  Future<List<User>> getAllUser() async {
    Database dbUser = await db;
    List listMap = await dbUser.rawQuery("SELECT * FROM $userTable");
    List<User> listUser = [];
    for (Map m in listMap) {
      listUser.add(User.fromMap(m));
    }
    return listUser;
  }

  Future<int> getNumber() async {
    Database dbUser = await db;
    return Sqflite.firstIntValue(
        await dbUser.rawQuery("SELECT COUNT(*) FROM $userTable"))!;
  }

  Future<bool> authLogin(String login, String password) async {
    Database dbUser = await db;
    List listMap = await dbUser.rawQuery(
        "SELECT $idColumn FROM $userTable WHERE $loginColumn = '$login' AND $passwordColumn = '$password'");

    return (listMap.length > 0) ? true : false;
  }

  Future close() async {
    Database dbUser = await db;
    dbUser.close();
  }
}

class User {
  User();

  int? id;
  String? name;
  String? login;
  String? password;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      nameColumn: name,
      loginColumn: login,
      passwordColumn: password,
    };
    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  User.fromMap(Map<dynamic, dynamic> map) {
    id = map[idColumn];
    name = map[nameColumn];
    login = map[loginColumn];
    password = map[passwordColumn];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "User: id $id - nome $name";
  }
}
