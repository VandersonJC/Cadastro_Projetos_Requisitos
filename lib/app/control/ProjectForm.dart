import 'package:cadastro_projeto_requerimento/app/models/Project.dart';
import 'package:cadastro_projeto_requerimento/app/view/HomePage.dart';
import 'package:cadastro_projeto_requerimento/app/view/ProjectsList.dart';
import 'package:flutter/material.dart';

class ProjectForm extends StatelessWidget {
  const ProjectForm({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return ProjectFormDinamic();
  }
}

class ProjectFormDinamic extends StatefulWidget {
  const ProjectFormDinamic({Key? key}) : super(key: key);

  @override
  State<ProjectFormDinamic> createState() => _ProjectFormDinamic();
}

class _ProjectFormDinamic extends State<ProjectFormDinamic> {
  final TextEditingController _con_project_name = TextEditingController();
  final TextEditingController _con_project_dt_start = TextEditingController();
  final TextEditingController _con_project_dt_end = TextEditingController();
  final TextEditingController _con_project_dt_end_estemeed =
      TextEditingController();
  final TextEditingController _con_project_ref_creator =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrando projeto'),
          // bottom: Button
        ),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _con_project_name,
                          decoration: InputDecoration(
                            label: Text('Nome'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
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
                          controller: _con_project_dt_start,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            label: Text('Data Inicio'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
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
                          controller: _con_project_dt_end,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            label: Text('Data final'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
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
                          controller: _con_project_dt_end_estemeed,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            label: Text('Data final estimada'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
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
                          controller: _con_project_ref_creator,
                          decoration: InputDecoration(
                            label: const Text('Responsável'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[400]!),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: RaisedButton(
                    child: const Text('Cadastrar'),
                    onPressed: () {
                      String name = _con_project_name.text;
                      String dt_start = _con_project_dt_start.text;
                      String dt_end = _con_project_dt_end.text;
                      String dt_end_estimeed =
                          _con_project_dt_end_estemeed.text;
                      int ref_creator =
                          int.parse(_con_project_ref_creator.text);

                      if (dt_end == null) {
                        dt_end = '';
                      }

                      ProjectHelper projectHelper = ProjectHelper();

                      setState(() {
                        Project objProject = Project();
                        objProject.name    = name;
                        objProject.dt_end          = dt_end;
                        objProject.dt_end_esteemed = dt_end_estimeed;
                        objProject.dt_start = dt_start;
                        objProject.ref_creator = ref_creator;

                        projectHelper.saveProject(objProject);
                      });
                      _con_project_name.clear();
                      _con_project_dt_start.clear();
                      _con_project_dt_end.clear();
                      _con_project_dt_end_estemeed.clear();
                      _con_project_ref_creator.clear();

                      returnList();
                    },
                  )),
            ])));
  }

  void returnList()
  {
        Navigator.push(
        context,
          MaterialPageRoute(
            builder: (context) => const ProjectList(),
          ),
        );
  }
}