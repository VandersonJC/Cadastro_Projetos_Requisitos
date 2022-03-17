import 'package:cadastro_projeto_requerimento/app/models/Project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ProjectView extends StatelessWidget {
  const ProjectView(
      {Key? key,
      required this.project,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

  final Project project;
  final Function(Project) onDelete;
  final Function(Project) onEdit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.40,
          children: [
            SlidableAction(
              onPressed: (value) {
                onEdit(project);
              },
              backgroundColor: Color.fromARGB(255, 40, 173, 118),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Editar',
            ),
            SlidableAction(
              onPressed: (value) {
                onDelete(project);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 104, 102, 102),
                    offset: Offset(1, 1),
                    blurRadius: 12,
                    spreadRadius: 1,
                  )
                ],
                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.folder, color: Color(0xff00d7f3),),
                      SizedBox(width: 10,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '${project.name}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text('Data final estimada: ${DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(project.dt_end_esteemed!))}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )),
                    ],
                  )),
            )));
  }
}
