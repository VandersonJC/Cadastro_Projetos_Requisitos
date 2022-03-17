import 'package:cadastro_projeto_requerimento/app/control/RequirementForm.dart';
import 'package:cadastro_projeto_requerimento/app/models/Project.dart';
import 'package:flutter/material.dart';

class ProjectControl extends StatelessWidget {
  const ProjectControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProjectControlDinamic();
  }
}

class ProjectControlDinamic extends StatefulWidget {
  const ProjectControlDinamic({Key? key}) : super(key: key);

  @override
  State<ProjectControlDinamic> createState() => _ProjectControlDinamic();
}

class _ProjectControlDinamic extends State<ProjectControlDinamic> {
  final TextEditingController _con_project_name = TextEditingController();
  final TextEditingController _con_project_dt_start = TextEditingController();
  final TextEditingController _con_project_dt_end = TextEditingController();
  final TextEditingController _con_project_dt_end_estemeed =
      TextEditingController();

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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                label: Text('Nome'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
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
                              decoration: InputDecoration(
                                label: Text('Data inicio'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
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
                              decoration: InputDecoration(
                                label: Text('Data final'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
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
                              decoration: InputDecoration(
                                label: Text('Data final estimada'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: RaisedButton(
                    child: Text('Cadastrar requisito'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RequirementForm(),
                        ),
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Text('Requisito $index'),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RequirementForm(),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.edit),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey,
                                      shadowColor: Colors.black),
                                ),
                                Text('  '),
                                ElevatedButton(
                                  onPressed: () {
                                    deleteAlertDialog(context, 'requisito $index');
                                  },
                                  child: Icon(Icons.delete),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      shadowColor: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: RaisedButton(
                    child: Text('Salvar'),
                    onPressed: () {
                      final String project_name = _con_project_name.text;
                      final String project_dt_start =
                          _con_project_dt_start.text;
                      final String project_dt_end = _con_project_dt_end.text;
                      final String project_dt_end_estemeed =
                          _con_project_dt_end_estemeed.text;
                    },
                  )),
            ],
          ),
        ));
  }
}

deleteAlertDialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Atenção!"),
          content: Text("Deseja realmente excluir o $text?"),
          actions: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Sim"),
            ),
            ElevatedButton(
              onPressed: () {Navigator.pop(context);},
              child: const Text("Voltar"),
              style: ElevatedButton.styleFrom(primary: Colors.grey),
            ),
          ],
        );
      },
    );
  }