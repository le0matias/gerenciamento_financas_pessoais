import 'dart:convert';

import 'package:http/http.dart';

import '../utils/rest_util.dart';
import '../models/conta.dart';

class ContaRestService {
  Future<void> addConta(Conta conta) async {
    final Response response = await RestUtil.addData(
        '/contas',
        conta.toJson(),
    );
  }

  Future<List<Conta>> getContas() async {
    final Response response = await RestUtil.getData('/contas');
    List<dynamic> conteudo = jsonDecode(response.body);
    List<Conta> contas = conteudo.map((dynamic conta) => Conta.fromJson(conta)).toList();
    return contas;
  }
}