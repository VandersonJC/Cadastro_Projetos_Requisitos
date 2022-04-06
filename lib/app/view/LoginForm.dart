import 'dart:ffi';

import 'package:cadastro_projeto_requerimento/app/models/User.dart';
import 'package:cadastro_projeto_requerimento/app/view/HomePage.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginFormDinamic();
  }
}

class LoginFormDinamic extends StatefulWidget {
  const LoginFormDinamic({Key? key}) : super(key: key);

  @override
  State<LoginFormDinamic> createState() => _LoginFormDinamic();
}

class _LoginFormDinamic extends State<LoginFormDinamic> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _login = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  bool _obscureText = true;
  bool _isSelect = false;

  UserHelper userHelper = UserHelper();

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _login,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Digite o login',
                            labelText: 'Usuário'),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Login deve ser preenchida';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _pass,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.vpn_key),
                            hintText: 'Digite a senha',
                            labelText: 'Senha'),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Senha deve ser preenchida';
                          }
                          return null;
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Visualizar senha'),
                        value: _isSelect,
                        onChanged: (bool? value) {
                          _toggle();
                          _isSelect = !_isSelect;
                        },
                        secondary: const Icon(Icons.remove_red_eye),
                      ),
                      Center(
                        child: Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(130, 50),
                                    // padding: const EdgeInsets.all(20),
                                  ),
                                  child: const Text('Entrar'),
                                  onPressed: () {
                                    onLogin();
                                  },
                                ))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String login = _login.text;
    String password = _pass.text;

    userHelper.authLogin(login, password).then((value) => {
          if (value == true)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              )
            }
          else
            {showAlertDialog1(context, 'Usuário ou senha incorreto')}
        });
  }
}

showAlertDialog1(BuildContext context, String text) {
  // configura o button
  Widget okButton = ElevatedButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: const Text("Info"),
    content: Text(text),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
