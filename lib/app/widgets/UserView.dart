import 'package:cadastro_projeto_requerimento/app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class UserView extends StatelessWidget {
  const UserView(
      {Key? key,
      required this.user,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

  final User user;
  final Function(User) onDelete;
  final Function(User) onEdit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.40,
          children: [
            SlidableAction(
              onPressed: (value) {
                onEdit(user);
              },
              backgroundColor: Color.fromARGB(255, 40, 173, 118),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Editar',
            ),
            SlidableAction(
              onPressed: (value) {
                onDelete(user);
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
                      const Icon(
                        Icons.folder,
                        color: Color(0xff00d7f3),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '${user.name}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Login: ${user.login}',
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
