import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String requirementTable = 'requirement';
const String idColumn = 'id';
const String descriptionColumn = 'description';
const String tpRequirementColumn = 'tp_requirement';
const String dtRegisterColumn = 'dt_register';
const String dtEndColumn = 'dt_end';
const String priorityColumn = 'priority';
const String levelComplexityColumn = 'level_complexity';
const String timeWorkEstemeedColumn = 'time_work_estemeed';
const String refProjectColumn = 'ref_project';
const String posGeoColumn = 'pos_geo';
const String img1Column = 'img1';
const String img2Column = 'img2';

class RequirementHelper {
  static final RequirementHelper _instance = RequirementHelper.interal();

  factory RequirementHelper() => _instance;

  RequirementHelper.interal();

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
    final path = join(databasesPath, '$requirementTable.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $requirementTable( $idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $descriptionColumn TEXT, $tpRequirementColumn TEXT, $dtRegisterColumn TEXT, $dtEndColumn TEXT, $priorityColumn TEXT, $levelComplexityColumn TEXT, $timeWorkEstemeedColumn TEXT, $refProjectColumn INTEGER, $posGeoColumn TEXT, $img1Column TEXT, $img2Column TEXT);");
    });
  }

  Future<Requirement> saveRequirement(Requirement requirement) async {
    Database dbProject = await db;
    requirement.id =
        await dbProject.insert(requirementTable, requirement.toMap());
    return requirement;
  }

  Future<Requirement> getRequirement(int id) async {
    Database dbProject = await db;
    List<Map> maps = await dbProject.query(requirementTable,
        columns: [
          idColumn,
          descriptionColumn,
          tpRequirementColumn,
          dtRegisterColumn,
          dtEndColumn,
          priorityColumn,
          levelComplexityColumn,
          timeWorkEstemeedColumn,
          refProjectColumn,
          posGeoColumn,
          img1Column,
          img2Column
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Requirement.fromMap(maps.first);
    } else {
      Requirement? requirement;
      return requirement!;
    }
  }

  Future<int> deleteRequirement(int id) async {
    Database dbProject = await db;
    return await dbProject
        .delete(requirementTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateRequirement(Requirement requirement) async {
    Database dbProject = await db;
    return await dbProject.update(requirementTable, requirement.toMap(),
        where: "$idColumn = ?", whereArgs: [requirement.id]);
  }

  Future<List<Requirement>> getAllRequirements(int? ref_project) async {
    Database dbProject = await db;

    List listMap = await dbProject.rawQuery("SELECT * FROM $requirementTable");

    if (ref_project != null || ref_project != '' || ref_project != 0) {
      listMap = await dbProject.rawQuery(
          "SELECT * FROM $requirementTable WHERE ref_project = $ref_project");
    }

    List<Requirement> listProjects = [];
    for (Map m in listMap) {
      listProjects.add(Requirement.fromMap(m));
    }
    return listProjects;
  }

  Future<int> getNumber() async {
    Database dbProject = await db;
    return Sqflite.firstIntValue(
        await dbProject.rawQuery("SELECT COUNT(*) FROM $requirementTable"))!;
  }

  Future close() async {
    Database dbProject = await db;
    dbProject.close();
  }
}

class Requirement {
  Requirement();

  int? id;
  String? description;
  String? tp_requirement;
  String? dt_register;
  String? dt_end;
  String? priority;
  String? level_complexity;
  String? time_work_estemeed;
  int? ref_project;
  String? pos_geo;
  String? img1;
  String? img2;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      descriptionColumn: description,
      tpRequirementColumn: tp_requirement,
      dtRegisterColumn: dt_register,
      dtEndColumn: dt_end,
      priorityColumn: priority,
      levelComplexityColumn: level_complexity,
      timeWorkEstemeedColumn: time_work_estemeed,
      refProjectColumn: ref_project,
      posGeoColumn: pos_geo,
      img1Column: img1,
      img2Column: img2,
    };
    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  Requirement.fromMap(Map<dynamic, dynamic> map) {
    id = map[idColumn];
    description = map[descriptionColumn];
    tp_requirement = map[tpRequirementColumn];
    dt_register = map[dtRegisterColumn];
    dt_end = map[dtEndColumn];
    priority = map[priorityColumn];
    level_complexity = map[levelComplexityColumn];
    time_work_estemeed = map[timeWorkEstemeedColumn];
    ref_project = map[refProjectColumn];
    pos_geo = map[posGeoColumn];
    img1 = map[img1Column];
    img2 = map[img2Column];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Requisito: id $id - descrição $description";
  }
}
