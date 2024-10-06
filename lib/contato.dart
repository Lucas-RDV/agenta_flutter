
class Contato {
  final int? id;  
  final String nome;
  final String email;
  final String telefone;

  const Contato({this.id, this.nome = '', this.email = '', this.telefone = ''});

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
    };
  }

  @override
  String toString() {
    return 'Contato(id: $id, nome: $nome, email: $email, telefone: $telefone)';
  }
}