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
}