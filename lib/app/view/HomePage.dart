import 'package:cadastro_projeto_requerimento/app/control/ProjectForm.dart';
import 'package:cadastro_projeto_requerimento/app/control/UserForm.dart';
import 'package:cadastro_projeto_requerimento/app/view/ProjectsList.dart';
import 'package:cadastro_projeto_requerimento/app/view/UserList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePageDinamic();
  }
}

class HomePageDinamic extends StatefulWidget {
  const HomePageDinamic({Key? key}) : super(key: key);

  @override
  State<HomePageDinamic> createState() => _HomePageDinamic();
}

class _HomePageDinamic extends State<HomePageDinamic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de projetos'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Card(
                child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'Projetos',
                    style: TextStyle(fontSize: 20),
                  ),
                  leading: Icon(Icons.folder, color: Color(0xff00d7f3)),
                ),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProjectForm(),
                              ),
                            );
                          },
                          child: const Text('Cadastrar'),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProjectList(),
                              ),
                            );
                          },
                          child: const Text('Listar'),
                        )),
                  ],
                )
              ],
            )),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Card(
                child: Column(
              children: [
                const ListTile(
                  title: Text('Usuarios', style: TextStyle(fontSize: 20)),
                  leading: Icon(
                    Icons.account_circle_rounded,
                    color: Color(0xff00d7f3),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            UserForm();
                          },
                          child: const Text('Cadastrar'),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            const UserList();
                          },
                          child: const Text('Listar'),
                        )),
                  ],
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
