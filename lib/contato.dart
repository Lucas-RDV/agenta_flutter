class Contato {
  String nome;
  String email;
  String telefone;

  Contato({required this.nome, this.email = "", this.telefone = ""});
}

class ContatoList {
  List<Contato> contatos = [];

  addContato(Contato c) {
    contatos.add(c);
  }

  List<Contato> getContatos() {
    return contatos;
  }
}