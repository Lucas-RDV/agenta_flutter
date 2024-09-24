import 'package:agenda_flutter/cadastro.dart';
import 'package:agenda_flutter/contato.dart';
import 'package:flutter/material.dart';

class Editar extends StatefulWidget {
  final ContatoList contatos;
  final Contato contato;
  Editar({required this.contatos, required this.contato});
  @override
  State createState() => EditarState(contatos: contatos, contato: contato);
}

class EditarState extends CadastroState {
  final Contato contato;
  EditarState({required this.contato, required super.contatos}) {
    nomeController.text = contato.nome;
    emailController.text = contato.email;
    telefoneController.text = contato.telefone;
  }
}