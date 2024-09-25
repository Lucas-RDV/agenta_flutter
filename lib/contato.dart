class Contato {
  final String nome;
  final String email;
  final String telefone;

  const Contato({required this.nome, this.email = "", this.telefone = ""});
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