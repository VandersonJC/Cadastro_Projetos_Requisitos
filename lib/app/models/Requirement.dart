
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String requirementTable       = 'requirement';
const String idColumn               = 'id';
const String descriptionColumn      = 'description';
const String tpRequirementColumn    = 'tp_requirement';
const String dtRegisterColumn       = 'dt_register';
const String dtEndColumn            = 'dt_end';
const String priorityColumn         = 'priority';
const String levelComplexityColumn  = 'level_complexity';
const String timeWorkEstemeedColumn = 'time_work_estemeed';
const String refProjectColumn       = 'ref_project';

class ItemHelper
{
  static final ItemHelper _instance = ItemHelper.interal();

  factory ItemHelper() => _instance;

  ItemHelper.interal();

  Database? _db;

  Future<Database> get db async
  {
    if(_db != null)
    {
      return _db!;
    }
    else
    {
      _db = await initDb();
      return _db!;
    }
  }

Future<Database> initDb() async 
{
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, '$requirementTable.db');

  return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async
  {
    await db.execute(
      "CREATE TABLE $requirementTable( $idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $descriptionColumn TEXT, $tpRequirementColumn TEXT, $dtRegisterColumn TEXT, $dtEndColumn TEXT, $priorityColumn TEXT, $levelComplexityColumn TEXT, $timeWorkEstemeedColumn TEXT, $refProjectColumn INTEGER);"
    );
  });
}

Future<Requirement> saveRequirement(Requirement requirement) async
{
  Database dbItem = await db;
  requirement.id = await dbItem.insert(requirementTable, requirement.toMap());
  return requirement;
}

Future<Requirement> getRequirement(int id) async
{
  Database dbItem = await db;
  List<Map> maps  = await dbItem.query(requirementTable,
    columns: [idColumn, descriptionColumn, tpRequirementColumn, dtRegisterColumn, dtEndColumn, priorityColumn, levelComplexityColumn, timeWorkEstemeedColumn, refProjectColumn],
     where: "$idColumn = ?",
     whereArgs: [id]);
  
    if( maps.length > 0 )
    {
      return Requirement.fromMap(maps.first);
    }
    else
    {
      Requirement? requirement;
      return requirement!; 
    }
}

Future<int>deleteRequirement(int id) async
{
  Database dbItem = await db;
  return await dbItem.delete(requirementTable, where: "$idColumn = ?", whereArgs: [id]);
}

Future<int>updateRequirement(Requirement requirement) async
{
  Database dbItem = await db;
  return await dbItem.update(requirementTable, requirement.toMap() , where: "$idColumn = ?", whereArgs: [requirement.id]);
}

Future<List<Requirement>> getAllProjects() async
{
  Database dbItem = await db;
  List listMap = await dbItem.rawQuery("SELECT * FROM $requirementTable");
  List<Requirement> listItems = [];
  for(Map m in listMap)
  {
    listItems.add(Requirement.fromMap(m));
  }
  return listItems;
}

Future<int> getNumber() async
{
  Database dbItem = await db;
  return Sqflite.firstIntValue(await dbItem.rawQuery("SELECT COUNT(*) FROM $requirementTable"))!;
}

Future close() async
{
  Database dbItem = await db;
  dbItem.close();
}

}

class Requirement
{ 

  Requirement();

  int?    id;
  String? description;
  String? tp_requirement;
  String? dt_register;
  String? dt_end;
  String? priority;
  String? level_complexity;
  String? time_work_estemeed;
  int?    ref_project;

  Map<String, dynamic> toMap()
  {
    var map = <String, dynamic>
    {
      descriptionColumn:      description,
      tpRequirementColumn:    tp_requirement,
      dtRegisterColumn:       dt_register,
      dtEndColumn:            dt_end,
      priorityColumn:         priority,
      levelComplexityColumn:  level_complexity,
      timeWorkEstemeedColumn: time_work_estemeed,
      refProjectColumn:       ref_project
    };
    if( id != null )
    {
      map[idColumn] = id;
    }

    return map;
  }

  Requirement.fromMap(Map<dynamic,dynamic> map)
  {
    id                 = map[idColumn];
    description        = map[descriptionColumn];
    tp_requirement     = map[tpRequirementColumn];
    dt_register        = map[dtRegisterColumn];
    dt_end             = map[dtEndColumn];
    priority           = map[priorityColumn];
    level_complexity   = map[levelComplexityColumn];
    time_work_estemeed = map[timeWorkEstemeedColumn];
    ref_project        = map[refProjectColumn];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Requisito: id $id - descrição $description";
  }
}  
     
     
     
  
