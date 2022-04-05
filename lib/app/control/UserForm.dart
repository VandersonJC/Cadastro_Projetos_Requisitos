import 'dart:io';
import 'dart:typed_data';

import 'package:cadastro_projeto_requerimento/app/models/User.dart';
import 'package:cadastro_projeto_requerimento/app/view/UserList.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class UserForm extends StatelessWidget {
  UserForm({this.user});

  User? user;

  @override
  Widget build(BuildContext context) {
    return UserFormDinamic(user: user);
  }
}

class UserFormDinamic extends StatefulWidget {
  UserFormDinamic({this.user});

  User? user;

  @override
  State<UserFormDinamic> createState() => _UserFormDinamic(userEdit: user);
}

class _UserFormDinamic extends State<UserFormDinamic> {
  // This widget is the root of your application.
  _UserFormDinamic({this.userEdit});

  final TextEditingController con_name = TextEditingController();
  final TextEditingController con_login = TextEditingController();
  final TextEditingController con_password = TextEditingController();

  User? userEdit;

  UserHelper userHelper = UserHelper();

  @override
  void initState() {
    if (userEdit?.id != null) {
      onLoad(userEdit!);
    }

    super.initState();
  }

  void onLoad(User user) {
    setState(() {
      con_name.text = user.name!;
      con_login.text = user.login!;
      con_password.text = user.password!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Usuários'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 158, 156, 156),
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: con_name,
                              decoration: InputDecoration(
                                label: const Text('Nome'),
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
                              controller: con_login,
                              decoration: InputDecoration(
                                label: const Text('Login'),
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
                              controller: con_password,
                              decoration: InputDecoration(
                                label: const Text('Senha'),
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
                  ),
                  Container(
                      margin: const EdgeInsets.all(16),
                      height: 50,
                      width: 150,
                      child: Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff00d7f3),
                                    padding: const EdgeInsets.all(15),
                                  ),
                                  child: const Text('Salvar'),
                                  onPressed: () {
                                    onSave();
                                  })))),
                ]))));
  }

  void onSave() {
    try {
      String name = (con_name.text != null) ? con_name.text : '';
      String login = (con_login.text != null) ? con_login.text : '';
      String password = (con_password.text != null) ? con_password.text : '';

      User objUser = User();

      objUser.name = name;
      objUser.login = login;
      objUser.password = password;

      if (userEdit?.id != null) {
        objUser.id = userEdit!.id;
        userHelper.updateUser(objUser);
      } else {
        userHelper.saveUser(objUser);
      }

      routeList();
    } catch (error) {
      throw Exception(error);
    }
  }

  void routeList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserList(),
      ),
    );
  }
}
