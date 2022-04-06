import 'package:cadastro_projeto_requerimento/app/view/HomePage.dart';
import 'package:cadastro_projeto_requerimento/app/view/LoginForm.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginForm(),
    ),
  );
}
