import 'dart:convert';

import 'package:http/http.dart';

import 'package:gerenciamento_financas_pessoais/utils/rest_util.dart';
import 'package:gerenciamento_financas_pessoais/models/operacao.dart';

class OperacaoRestService {
  Future<void> addOperacao(Operacao operacao) async {
    final Response response = await RestUtil.addData(
    '/operacoes',
    operacao.toJson(),
    );
  }

  Future<List<Operacao>> getOperacoes() async {
    final Response response = await RestUtil.getData('/operacoes');
    if(response.statusCode == 201) {
      List<dynamic> conteudo = jsonDecode(response.body);
      List<Operacao> operacoes = conteudo.map((dynamic operacao) =>
        Operacao.fromJson(operacao)).toList();
      return operacoes;
    } else {
      throw Exception('Erro ao listar Operações');
    }
  }

  Future<Operacao> getOperacaoId(String id) async {
    final Response response = await RestUtil.getDataId(
        '/operacoes',
        id);
    if(response.statusCode == 201){
      return Operacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao buscar Operação');
    }
  }

  Future<Operacao?> editOperacao(Operacao operacao, String id) async {
    final novaOperacao = {
      'nome': operacao.nome,
      'resumo': operacao.resumo,
      'custo': operacao.custo,
      'data': operacao.data,
      'conta_id': operacao.conta,
      'tipo': operacao.tipo
    };
    final response = await RestUtil.editData(
        '/operacoes',
        novaOperacao,
        id,
    );
    if(response.statusCode == 201){
      print('Operação atualizada');
    } else {
      throw Exception('Erro ao atualizar Operação');
    }
  }
}