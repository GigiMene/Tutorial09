class Client {
  final String id;
  final String nome;
  final String telefone;
  final String email;
  bool favorito;

  Client({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.email,
    this.favorito = false,
  });


  factory Client.fromJson(Map<String, String> json) {
      return Client(
        id: json['id'] ?? '',
        nome: json['nome'] ?? '',
        telefone: json['telefone'] ?? '',
        email: json['email'] ?? '',
      );
  }
   @override
  String toString() =>
      'ServiceOrder(id: $id, nome: $nome, telefone: $telefone, email: $email )';

  }
      

