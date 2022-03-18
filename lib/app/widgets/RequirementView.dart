import 'package:cadastro_projeto_requerimento/app/models/Project.dart';
import 'package:cadastro_projeto_requerimento/app/models/Requirement.dart';
import 'package:cadastro_projeto_requerimento/app/util/VDate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class RequirementView extends StatelessWidget {
  const RequirementView(
      {Key? key,
      required this.requirement,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

  final Requirement requirement;
  final Function(Requirement) onDelete;
  final Function(Requirement) onEdit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.40,
          children: [
            SlidableAction(
              onPressed: (value) {
                onEdit(requirement);
              },
              backgroundColor: Color.fromARGB(255, 40, 173, 118),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Editar',
            ),
            SlidableAction(
              onPressed: (value) {
                onDelete(requirement);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
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
                      Icon(Icons.content_paste_rounded, color: Color(0xff00d7f3),),
                      SizedBox(width: 10,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '${requirement.description}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text('Prioridade: ${requirement.priority}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text('Tipo: ${requirement.tp_requirement}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text('Registrado em: ${VDate.ConvertDateUsInBr(VDate.ConvertStringInDatetime(requirement.dt_register!), false )}',
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
