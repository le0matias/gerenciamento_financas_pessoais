import 'package:gerenciamento_financas_pessoais/models/operacao.dart';
import 'package:gerenciamento_financas_pessoais/utils/db_util.dart';

class OperacaoService {
  void addOperacao(Operacao operacao) {
    DbUtil.inserirDados('operacao', operacao.toMap());
  }
}