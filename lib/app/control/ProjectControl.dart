import 'package:cadastro_projeto_requerimento/app/control/RequirementForm.dart';
import 'package:cadastro_projeto_requerimento/app/models/Project.dart';
import 'package:cadastro_projeto_requerimento/app/models/Requirement.dart';
import 'package:cadastro_projeto_requerimento/app/widgets/RequirementView.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectControl extends StatelessWidget {
  ProjectControl({required this.edit_project});

  Project edit_project;

  @override
  Widget build(BuildContext context) {
    return ProjectControlDinamic(
      edit_project: edit_project,
    );
  }
}

class ProjectControlDinamic extends StatefulWidget {
  ProjectControlDinamic({required this.edit_project});

  Project edit_project;

  @override
  State<ProjectControlDinamic> createState() => _ProjectControlDinamic(
        edit_project: edit_project,
      );
}

class _ProjectControlDinamic extends State<ProjectControlDinamic> {
  _ProjectControlDinamic({required this.edit_project});

  Project edit_project;

  final TextEditingController con_project_name = TextEditingController();
  final TextEditingController con_project_dt_start = TextEditingController();
  final TextEditingController con_project_dt_end = TextEditingController();
  final TextEditingController con_project_dt_end_estemeed =
      TextEditingController();
  final TextEditingController con_project_ref_creator = TextEditingController();
  final TextEditingController con_project_obs = TextEditingController();

  List<Requirement> requirementList = [];

  int? requirementSelectPos;
  Requirement? requirementSelect;

  ProjectHelper projectHelper = ProjectHelper();
  RequirementHelper requirementHelper = RequirementHelper();

  @override
  void initState() {
    onLoad(edit_project);

    requirementHelper.getAllRequirements(edit_project.id!).then((list) {
      for (Requirement requirement in list) {
        requirementList.add(requirement);
      }
    });

    super.initState();
  }

  void onEditProject() {}

  void onLoad(Project project) {
    setState(() {
      con_project_name.text = project.name!;
      con_project_dt_start.text = project.dt_start!;
      con_project_dt_end.text = project.dt_end!;
      con_project_dt_end_estemeed.text = project.dt_end_esteemed!;
      con_project_ref_creator.text = '${project.ref_creator}';
      con_project_obs.text = project.obs!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editando projeto'),
          // bottom: Button
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: FutureBuilder<List<Project>>(
                        future: projectHelper.getAllProjects(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Project>> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: con_project_name,
                                      decoration: InputDecoration(
                                        label: Text('Nome'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      controller: con_project_dt_start,
                                      decoration: InputDecoration(
                                        label: Text('Data inicio'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      controller: con_project_dt_end,
                                      decoration: InputDecoration(
                                        label: Text('Data final'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      controller: con_project_dt_end_estemeed,
                                      decoration: InputDecoration(
                                        label: Text('Data final estimada'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: con_project_ref_creator,
                                      decoration: InputDecoration(
                                        label: const Text('Responsável'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      width: 275,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: con_project_obs,
                                          decoration: InputDecoration(
                                            label: const Text(
                                                'Link material complementar'),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400]!),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400]!),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400]!),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 55,
                                      width: 55,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (con_project_obs.text != null) {
                                            openURL(con_project_obs.text);
                                          }
                                        },
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  )),
              const Divider(height: 20, color: Colors.grey),
              Container(
                  margin: const EdgeInsets.all(4),
                  height: 50,
                  width: 200,
                  child: Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 36, 223, 135),
                              padding: const EdgeInsets.all(15),
                            ),
                            child: const Text('Cadastrar Requisito'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RequirementForm(
                                    ref_project: edit_project.id!,
                                  ),
                                ),
                              );
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: FutureBuilder<List<Requirement>>(
                      future: requirementHelper
                          .getAllRequirements(edit_project.id!),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Requirement>> snapshot) {
                        if (snapshot.hasData) {
                          return Flexible(
                              child: Container(
                                  height: 300,
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.white,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      for (Requirement requirement
                                          in requirementList)
                                        RequirementView(
                                          requirement: requirement,
                                          onDelete: onDelete,
                                          onEdit: onEdit,
                                        ),
                                    ],
                                  )));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })),
              const Divider(height: 20, color: Colors.grey),
              Container(
                  margin: const EdgeInsets.all(8),
                  height: 50,
                  width: 140,
                  child: Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff00d7f3),
                              padding: const EdgeInsets.all(15),
                            ),
                            child: const Text('Salvar'),
                            onPressed: () {
                              onSave();
                            },
                          )))),
            ],
          ),
        ));
  }

  void onDelete(Requirement requirement) {
    //Paralelo
    requirementSelect = requirement;
    requirementSelectPos = requirementList.indexOf(requirement);

    setState(() {
      // delete in db
      requirementHelper.deleteRequirement(requirement.id!);

      // remove in list static
      requirementList.remove(requirement);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'O requisito ${requirement.id} foi removido com suceeso!',
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Desfazer',
        textColor: const Color(0xff00d7f3),
        onPressed: () {
          setState(() {
            requirementList.insert(requirementSelectPos!, requirement);
            requirementHelper.saveRequirement(requirement);
          });
        },
      ),
    ));
  }

  void onEdit(Requirement requirement) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RequirementForm(
          ref_project: edit_project.id!,
          requirement: requirement,
        ),
      ),
    );
  }

  void openURL(String url) async {
    final newUrl = 'https:$url';
    if (await canLaunch(newUrl)) {
      await launch(newUrl,
          forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Não foi possivel acessar o link $url',
          style: const TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
      ));
    }
  }

  void onSave() {
    String name = (con_project_name.text != null) ? con_project_name.text : '';
    String dt_start =
        (con_project_dt_start.text != null) ? con_project_dt_start.text : '';
    String dt_end =
        (con_project_dt_end.text != null) ? con_project_dt_end.text : '';

    String dt_end_estemeed = (con_project_dt_end_estemeed.text != null)
        ? con_project_dt_end_estemeed.text
        : '';

    String obs = (con_project_obs.text != null) ? con_project_obs.text : '';

    int? ref_creator = (int.parse(con_project_ref_creator.text) != null)
        ? int.parse(con_project_ref_creator.text)
        : null;

    edit_project.name = name;
    edit_project.dt_start = dt_start;
    edit_project.dt_end = dt_end;
    edit_project.dt_end_esteemed = dt_end_estemeed;
    edit_project.obs = obs;
    edit_project.ref_creator = ref_creator;

    projectHelper.updateProject(edit_project);

    onLoad(edit_project);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Projeto salvo com suceeso!',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    ));
  }
}
