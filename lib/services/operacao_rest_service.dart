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
}