import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String projectTable = 'project';
const String idColumn = 'id';
const String nameColumn = 'name';
const String dtStartColumn = 'dt_start';
const String dtEndColumn = 'dt_end';
const String dtEndEsteemedColumn = 'dt_end_esteemed';
const String refCreatorColumn = 'ref_creator';
const String obsColumn = 'obs';

class ProjectHelper {
  static final ProjectHelper _instance = ProjectHelper.interal();

  factory ProjectHelper() => _instance;

  ProjectHelper.interal();

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
    final path = join(databasesPath, '$projectTable.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $projectTable( $idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT,$dtStartColumn TEXT, $dtEndColumn TEXT, $dtEndEsteemedColumn TEXT, $refCreatorColumn INTEGER, $obsColumn TEXT);");
    });
  }

  Future<Project> saveProject(Project project) async {
    Database dbProject = await db;
    project.id = await dbProject.insert(projectTable, project.toMap());
    return project;
  }

  Future<Project> getProject(int id) async {
    Database dbProject = await db;
    List<Map> maps = await dbProject.query(projectTable,
        columns: [
          idColumn,
          nameColumn,
          dtStartColumn,
          dtEndColumn,
          dtEndEsteemedColumn,
          refCreatorColumn,
          obsColumn
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Project.fromMap(maps.first);
    } else {
      Project? project;
      return project!;
    }
  }

  Future<int> deleteProject(int id) async {
    Database dbProject = await db;
    return await dbProject
        .delete(projectTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateProject(Project project) async {
    Database dbProject = await db;
    return await dbProject.update(projectTable, project.toMap(),
        where: "$idColumn = ?", whereArgs: [project.id]);
  }

  Future<List<Project>> getAllProjects() async {
    Database dbProject = await db;
    List listMap = await dbProject.rawQuery("SELECT * FROM $projectTable");
    List<Project> listProjects = [];
    for (Map m in listMap) {
      listProjects.add(Project.fromMap(m));
    }
    return listProjects;
  }

  Future<int> getNumber() async {
    Database dbProject = await db;
    return Sqflite.firstIntValue(
        await dbProject.rawQuery("SELECT COUNT(*) FROM $projectTable"))!;
  }

  Future close() async {
    Database dbProject = await db;
    dbProject.close();
  }
}

class Project {
  Project();

  int? id;
  String? name;
  String? dt_start;
  String? dt_end;
  String? dt_end_esteemed;
  String? obs;
  int? ref_creator;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      nameColumn: name,
      dtStartColumn: dt_start,
      dtEndColumn: dt_end,
      dtEndEsteemedColumn: dt_end_esteemed,
      refCreatorColumn: ref_creator,
      obsColumn: obs
    };
    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  Project.fromMap(Map<dynamic, dynamic> map) {
    id = map[idColumn];
    name = map[nameColumn];
    dt_start = map[dtStartColumn];
    dt_end = map[dtEndColumn];
    dt_end_esteemed = map[dtEndEsteemedColumn];
    ref_creator = map[refCreatorColumn];
    obs = map[obsColumn];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Project: id $id - nome $name - data inicio $dt_start - data final $dt_end - data final estimada $dt_end_esteemed - criador $ref_creator";
  }
}
