import 'package:cadastro_projeto_requerimento/app/control/ProjectControl.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projetos'),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Text('Projeto $index'),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProjectControl(),
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
                                deleteAlertDialog(context, 'projeto $index');
                              },
                              child: Icon(Icons.delete),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shadowColor: Colors.red),
                            ),
                          ],
                        ))));
            // return ListTile(
            //   trailing: Icon(Icons.library_books),
            //   title:Text("List item $index"),
            //   subtitle: Text("Data final estimada:"+DateTime.now().toString()),
            //   );
          }),
    );
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
