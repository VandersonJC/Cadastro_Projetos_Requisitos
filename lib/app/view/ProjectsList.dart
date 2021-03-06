import 'package:cadastro_projeto_requerimento/app/control/ProjectControl.dart';
import 'package:cadastro_projeto_requerimento/app/control/ProjectForm.dart';
import 'package:cadastro_projeto_requerimento/app/models/Project.dart';
import 'package:cadastro_projeto_requerimento/app/widgets/ProjectView.dart';
import 'package:flutter/material.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return ProjectListDinamic();
  }
}

class ProjectListDinamic extends StatefulWidget {
  const ProjectListDinamic({Key? key}) : super(key: key);

  @override
  State<ProjectListDinamic> createState() => _ProjectListDinamic();
}

class _ProjectListDinamic extends State<ProjectListDinamic> {
  ProjectHelper projectHelper = ProjectHelper();

  List<Project> projectList = [];

  int? projectSelectPos;
  Project? projectSelect;

  @override
  void initState() {
    // Project projectNew = Project();
    // projectNew.name = 'teste';
    // projectNew.dt_end = '2022-01-01';
    // projectNew.dt_end_esteemed = '2021-12-28';
    // projectNew.dt_start = '2021-10-12';
    // projectNew.ref_creator = 1;
    // projectHelper.saveProject(projectNew);

    projectHelper.getAllProjects().then((list) => {
          for (Project project in list) {projectList.add(project)}
        });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Projetos'),
        ),
        body: SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.77,
              child: FutureBuilder<List<Project>>(
                  future: projectHelper.getAllProjects(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Project>> snapshot) {
                    if (snapshot.hasData) {
                      return Flexible(
                          // flexivel
                          child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (Project project in projectList)
                            ProjectView(
                              project: project,
                              onDelete: onDelete,
                              onEdit: onEdit,
                            ),
                        ],
                      ));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
                decoration: BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FutureBuilder<List<Project>>(
                        future: projectHelper.getAllProjects(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Project>> snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                                child: Text(
                                    '${projectList.length} Projetos cadastrados'));
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                    FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: Color(0xff00d7f3),
                      onPressed: routeNewProject,
                    ),
                    const SizedBox(
                      width: 28,
                    )
                  ],
                ))
          ],
        )));
  }

  void onDelete(Project project)
  {
    //Paralelo
    projectSelect    = project;
    projectSelectPos = projectList.indexOf(project);

    setState(() {
      // delete in db
      projectHelper.deleteProject(project.id!);

      // remove in list static
      projectList.remove(project);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'O projeto ${project.name} foi removido com suceeso!',
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Desfazer',
        textColor: const Color(0xff00d7f3),
        onPressed: () {
          setState(() {
            projectList.insert(projectSelectPos!, project);
            projectHelper.saveProject(project);
          });
        },
      ),
    ));
  }

  void routeNewProject()
  {
    Navigator.push(
        context,
          MaterialPageRoute(
            builder: (context) => const ProjectForm(),
          ),
        );
  }

  void onEdit(Project project)
  {
        Navigator.push(
        context,
          MaterialPageRoute(
            builder: (context) => ProjectControl(edit_project: project,),
          ),
        );
  }
}

// deleteAlertDialog(BuildContext context, Project project, onDelete) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text("Aten????o!"),
//         content: Text("Deseja realmente excluir o ${project.name}?"),
//         actions: [
//           ElevatedButton(
//             onPressed: onDelete,
//             child: const Text("Sim"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text("Voltar"),
//             style: ElevatedButton.styleFrom(primary: Colors.grey),
//           ),
//         ],
//       );
//     },
//   );
// }
