import 'operacao.dart';

class Conta {

  late int? id;
  late String nome;
  late double valor;
  late List<Operacao>? operacoes;

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

  Conta.fromJson(Map json){
    var lista = json['operacoes'] as List;
    List<Operacao> operacaoList = lista.map((operacao) =>
      Operacao.fromJsonNested(operacao)).toList();
    id = json['id'];
    nome = json['nome'];
    valor = json['valor'];
    operacoes = operacaoList;
  }
}