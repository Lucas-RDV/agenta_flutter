import 'package:agenda_flutter/cadastro.dart';
import 'package:agenda_flutter/contato.dart';
import 'package:flutter/material.dart';

class Listagem extends StatefulWidget {
  final ContatoList contatos = ContatoList();
  final Contato teste =
      const Contato(nome: 'nome', telefone: 'telefone', email: 'email');

  Listagem({super.key});

  @override
  State<Listagem> createState() => ListagemState(contatos: contatos);
}

class ListagemState extends State<Listagem> {
  ContatoList contatos;

  ListagemState({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Agenda Irada'),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                style: BorderStyle.solid,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cadastro(contatos: contatos),
                  ),
                ).then((novoContato) {
                  if (novoContato != null) {
                    setState(() {
                      contatos.getContatos().add(novoContato);
                    });
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contatos.getContatos().length,
        itemBuilder: (context, index) {
          Contato c = contatos.getContatos()[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.nome),
                      Text(c.telefone),
                      Text(c.email),
                    ],
                  ),
                  ElevatedButton(onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cadastro(contato: contatos.getContatos()[index],contatos: contatos),
                  ),
                ).then((novoContato) {
                  if (novoContato != null) {
                    setState(() {
                      contatos.getContatos()[index] = novoContato;
                    });
                  }
                });
                  }, child: const Text("Editar")),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      contatos.getContatos().removeAt(index);
                    });
                  }, child: const Text("deletar")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
