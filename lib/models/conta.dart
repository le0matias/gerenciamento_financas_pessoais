class Conta {
  late int? id;
  late String nome;
  late double valor;

  Conta({this.id, required this.nome, required this.valor});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
    };
  }

  Map<String, dynamic> toJson(){
    return {
      'nome': nome,
      'valor': valor,
    };
  }

  Conta.fromMap(Map map){
    id = map['id'];
    nome = map['nome'];
    valor = map['valor'];
  }
}