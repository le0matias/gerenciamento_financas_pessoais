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
}