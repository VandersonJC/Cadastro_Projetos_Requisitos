import 'package:cadastro_projeto_requerimento/app/control/UserForm.dart';
import 'package:cadastro_projeto_requerimento/app/models/User.dart';
import 'package:cadastro_projeto_requerimento/app/widgets/UserView.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserListDinamic();
  }
}

class UserListDinamic extends StatefulWidget {
  const UserListDinamic({Key? key}) : super(key: key);

  @override
  State<UserListDinamic> createState() => _UserListDinamic();
}

class _UserListDinamic extends State<UserListDinamic> {
  UserHelper userHelper = UserHelper();

  List<User> userList = [];

  int? userSelectPos;
  User? userSelect;

  @override
  void initState() {
    userHelper.getAllUser().then((list) => {
          for (User user in list) {userList.add(user)}
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Usuários'),
        ),
        body: SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.77,
              child: FutureBuilder<List<User>>(
                  future: userHelper.getAllUser(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<User>> snapshot) {
                    if (snapshot.hasData) {
                      return Flexible(
                          // flexivel
                          child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (User user in userList)
                            UserView(
                              user: user,
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
                    FutureBuilder<List<User>>(
                        future: userHelper.getAllUser(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<User>> snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                                child: Text(
                                    '${userList.length} Usuários cadastrados'));
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                    FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: Color(0xff00d7f3),
                      onPressed: () {
                        UserForm();
                      },
                    ),
                    const SizedBox(
                      width: 28,
                    )
                  ],
                ))
          ],
        )));
  }

  void onDelete(User user) {
    //Paralelo
    userSelect = user;
    userSelectPos = userList.indexOf(user);

    setState(() {
      // delete in db
      userHelper.deleteUser(user.id!);

      // remove in list static
      userList.remove(user);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'O usuaŕio ${user.name} foi removido com suceeso!',
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Desfazer',
        textColor: const Color(0xff00d7f3),
        onPressed: () {
          setState(() {
            userList.insert(userSelectPos!, user);
            userHelper.saveUser(user);
          });
        },
      ),
    ));
  }

  void onEdit(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserForm(
          user: user,
        ),
      ),
    );
  }
}
