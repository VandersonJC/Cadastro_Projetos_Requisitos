
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// const String projectTable        = 'project';
// const String idColumn            = 'id';
// const String nameColumn          = 'name';
// const String dtStartColumn       = 'dt_start';
// const String dtEndColumn         = 'dt_end';
// const String dtEndEsteemedColumn = 'dt_end_esteemed';
// const String refCreatorColumn    = 'ref_creator';

// class ItemHelper
// {
//   static final ItemHelper _instance = ItemHelper.interal();

//   factory ItemHelper() => _instance;

//   ItemHelper.interal();

//   Database? _db;

//   Future<Database> get db async
//   {
//     if(_db != null)
//     {
//       return _db!;
//     }
//     else
//     {
//       _db = await initDb();
//       return _db!;
//     }
//   }

// Future<Database> initDb() async 
// {
//   final databasesPath = await getDatabasesPath();
//   final path = join(databasesPath, '$projectTable.db');

//   return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async
//   {
//     await db.execute(
//       "CREATE TABLE $projectTable( $idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT,$dtStartColumn TEXT, $dtEndColumn TEXT, $dtEndEsteemedColumn TEXT, $refCreatorColumn INTEGER );"
//     );
//   });
// }

// Future<Project> saveProject(Project project) async
// {
//   Database dbItem = await db;
//   project.id = await dbItem.insert(projectTable, project.toMap());
//   return project;
// }

// Future<Project> getProject(int id) async
// {
//   Database dbItem = await db;
//   List<Map> maps  = await dbItem.query(projectTable,
//     columns: [idColumn, nameColumn, dtStartColumn, dtEndColumn, dtEndEsteemedColumn, refCreatorColumn],
//      where: "$idColumn = ?",
//      whereArgs: [id]);
  
//     if( maps.length > 0 )
//     {
//       return Project.fromMap(maps.first);
//     }
//     else
//     {
//       Project? project;
//       return project!; 
//     }
// }

// Future<int>deleteProject(int id) async
// {
//   Database dbItem = await db;
//   return await dbItem.delete(projectTable, where: "$idColumn = ?", whereArgs: [id]);
// }

// Future<int>updateProject(Project project) async
// {
//   Database dbItem = await db;
//   return await dbItem.update(projectTable, project.toMap() , where: "$idColumn = ?", whereArgs: [project.id]);
// }

// Future<List<Project>> getAllProjects() async
// {
//   Database dbItem = await db;
//   List listMap = await dbItem.rawQuery("SELECT * FROM $projectTable");
//   List<Project> listItems = [];
//   for(Map m in listMap)
//   {
//     listItems.add(Project.fromMap(m));
//   }
//   return listItems;
// }

// Future<int> getNumber() async
// {
//   Database dbItem = await db;
//   return Sqflite.firstIntValue(await dbItem.rawQuery("SELECT COUNT(*) FROM $projectTable"))!;
// }

// Future close() async
// {
//   Database dbItem = await db;
//   dbItem.close();
// }

// }

// class User
// { 

//   User();

//   int? id;
//   String? name;
//   String? dt_start;
//   String? dt_end;
//   String? dt_end_esteemed;
//   int? ref_creator;

//   Map<String, dynamic> toMap()
//   {
//     var map = <String, dynamic>
//     {
//       nameColumn: name,
//       dtStartColumn: dt_start,
//       dtEndColumn: dt_end,
//       dtEndEsteemedColumn: dt_end_esteemed,
//       refCreatorColumn: ref_creator
//     };
//     if( id != null )
//     {
//       map[idColumn] = id;
//     }

//     return map;
//   }

//   Project.fromMap(Map<dynamic,dynamic> map)
//   {
//     id              = map[idColumn];
//     name            = map[nameColumn];
//     dt_start        = map[dtStartColumn];
//     dt_end          = map[dtEndColumn];
//     dt_end_esteemed = map[dtEndEsteemedColumn];
//     ref_creator     = map[refCreatorColumn];
//   }

//   @override
//   String toString() {
//     // TODO: implement toString
//     return "Project: id $id - nome $name - data inicio $dt_start - data final $dt_end - data final estimada $dt_end_esteemed - criador $ref_creator";
//   }
// }  
     
     
     
  
