import 'package:agenda_flutter/cadastro.dart';
import 'package:agenda_flutter/contato.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class Listagem extends StatefulWidget {
  Listagem({super.key});

  @override
  State<Listagem> createState() => ListagemState();
}

class ListagemState extends State<Listagem> {
  final dbHelper = DatabaseHelper();
  List<Contato> contatos = [];

  ListagemState();

  @override
  void initState() {
    super.initState();
    loadContatos();
  }

  void loadContatos() async {
    List<Contato> loadedContatos = await dbHelper.getContatos();
    setState(() {
      contatos = loadedContatos;
    });
  }

    void addContato(Contato novoContato) async {
    await dbHelper.newContato(novoContato);
    loadContatos();
  }

  void updateContato(Contato contatoAtualizado, int index) async {
    await dbHelper.atualizarContato(contatoAtualizado);
    setState(() {
      contatos[index] = contatoAtualizado;
    });
  }

  void deleteContato(int id, int index) async {
    await dbHelper.deletarContato(id);
    setState(() {
      contatos.removeAt(index);
    });
  }

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
                    builder: (context) => Cadastro(),
                  ),
                ).then((novoContato) {
                  if (novoContato != null) {
                    addContato(novoContato);
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          Contato c = contatos[index];
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
                        builder: (context) => Cadastro(contato: c),
                      ),
                    ).then((novoContato) {
                      if (novoContato != null) {
                        updateContato(novoContato, index);
                      }
                    });
                  }, child: const Text("Editar")),
                  ElevatedButton(onPressed: () {
                    deleteContato(c.id!, index);  // Deleta o contato pelo ID
                  }, child: const Text("Deletar")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}
