import '../models/conta.dart';
import '../utils/db_util.dart';

class ContaService {
  
  List<Conta> _contaList = [];
  
  void adicionarConta(Conta conta){
    DbUtil.inserirDados('conta', conta.toMap());
  }
  
  Future<List> listaTodasContas() async {
    final dataList = await DbUtil.pegaDados('conta');
    _contaList = dataList.map((contas) => Conta.fromMap(contas)).toList();
    return _contaList;
  }

  Future<Conta> getConta(int id) async {
    String whereString = 'id = ?';
    List<dynamic> whereArguments = [id];
    final dataList = await DbUtil.getDataWhere(
        'conta',
        whereString,
        whereArguments,
    );
    return Conta.fromMap(dataList.first);
  }

  void atualizaValorConta(int? id, double custo, String tipoOperacao){
    String sql;
    if(tipoOperacao == 'entrada'){
      sql = 'UPDATE conta SET valor = valor + ? WHERE id = ?';
    } else {
      sql = 'UPDATE conta SET valor = valor - ? WHERE id = ?';
    }
    List<dynamic> arguments = [custo, id];
    DbUtil.executaSQL(sql, arguments);
  }
}