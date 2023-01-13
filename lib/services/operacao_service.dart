import 'package:gerenciamento_financas_pessoais/models/operacao.dart';
import 'package:gerenciamento_financas_pessoais/utils/db_util.dart';

class OperacaoService {

  List<Operacao> _operacaoList = [];

  void addOperacao(Operacao operacao) {
    DbUtil.inserirDados('operacao', operacao.toMap());
  }

  Future<List> getAllOperacoes() async {
    final dataList = await DbUtil.pegaDados('operacao');
    _operacaoList = dataList.map((operacoes) => Operacao.fromMap(operacoes)).toList();
    return _operacaoList;
  }
  
  Future<List> getOperacoesConta(int id) async {
    String whereString = 'conta = ?';
    List<dynamic> whereArguments = [id];
    final dataList = await DbUtil.getDataWhere(
        'operacao',
        whereString,
        whereArguments,
    );
    return dataList.map((operacoes) => Operacao.fromMap(operacoes)).toList();
  }
}