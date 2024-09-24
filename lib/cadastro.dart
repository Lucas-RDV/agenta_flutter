import 'package:agenda_flutter/contato.dart';
import 'package:agenda_flutter/phoneFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cadastro extends StatefulWidget {
  final ContatoList contatos;
  Cadastro({required this.contatos});
  @override
  State createState() => CadastroState(contatos: contatos);
}

class CadastroState extends State {
  ContatoList contatos;
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final formKeyCadastro = GlobalKey<FormState>();
  CadastroState({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Cadastro de contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKeyCadastro,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'campo obrigatorio';
                  }
                  return null;
                },
              ), // nome field
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  const pattern =
                      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                  final regex = RegExp(pattern);
                  if (value == null || value.isEmpty) {
                    return 'campo obrigatorio';
                  } else if (!regex.hasMatch(value)) {
                    return 'informe um E-mail valido';
                  }
                  return null;
                },
              ), // email field
              SizedBox(height: 10),
              TextFormField(
                inputFormatters: <TextInputFormatter>[
                  PhoneFormatter(),
                ],
                controller: telefoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'telefone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  const pattern = r'\d\d\d\d\d-\d\d\d\d';
                  final regex = RegExp(pattern);
                  if (value == null || value.isEmpty) {
                    return 'campo obrigatorio';
                  } else if (!regex.hasMatch(value)) {
                    return 'informe um telefone valido';
                  }
                  return null;
                },
              ), // telefone

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Salvar(),
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Salvar() {
    if (formKeyCadastro.currentState!.validate()) {
      Contato novoContato = Contato(
          nome: nomeController.text,
          email: emailController.text,
          telefone: telefoneController.text);
      Navigator.pop(context, novoContato);
    }
  }
}
