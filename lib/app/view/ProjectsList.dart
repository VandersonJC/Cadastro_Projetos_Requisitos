import 'package:flutter/material.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return ProjectListDinamic();
  }
}

class ProjectListDinamic extends StatefulWidget 
{
  const ProjectListDinamic({Key? key}) : super(key: key);

  @override
  State<ProjectListDinamic> createState() => _ProjectListDinamic();
}

class _ProjectListDinamic extends State<ProjectListDinamic>
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
       title: const Text('Projetos'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context,int index)
        {
          return ListTile(
            trailing: Icon(Icons.library_books),
            title:Text("List item $index"),
            subtitle: Text("Data final estimada:"+DateTime.now().toString()),
            );
        }
        ),
    );
  }
}