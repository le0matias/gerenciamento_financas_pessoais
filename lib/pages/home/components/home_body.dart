import 'package:flutter/material.dart';
import 'package:gerenciamento_financas_pessoais/services/operacao_rest_service.dart';

import '../../operacao/operacao_page.dart';
import '../../shared_components/card_conta.dart';
import '../../shared_components/card_operacao.dart';
import '../../../services/conta_service.dart';
import '../../../services/operacao_service.dart';
import '../../../services/conta_rest_service.dart';

class Body extends StatefulWidget {

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ContaService cs = ContaService();
  OperacaoService os = OperacaoService();
  ContaRestService crs = ContaRestService();
  OperacaoRestService ors = OperacaoRestService();

  late Future<List> _carregaContas;
  late List _contas;
  late Future<List> _carregaOperacoes;
  late List _operacoes;

  @override
  void initState(){
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 175,
              child: FutureBuilder(
                future: _carregaContas,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                   _contas = snapshot.data;
                   return ListView.builder(
                     scrollDirection: Axis.horizontal,
                     shrinkWrap: true,
                     itemCount: _contas.length,
                     padding: const EdgeInsets.only(left: 16, right: 8, top: 12),
                     itemBuilder: (context, index) {
                       return cardConta(context, _contas[index]);
                     }
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 30, bottom: 15, right: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '??ltimas Opera????es',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => OperacaoPage())
                      );
                    },
                    child: const Text(
                      'Ver todos',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _carregaOperacoes,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  _operacoes = snapshot.data;
                  return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _operacoes.length > 4 ? 4 : _operacoes.length,
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                          return cardOperacao(
                            context,
                            index,
                            _operacoes[index],
                          );
                          }
                      ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    setState(() {
      _carregaContas = _getContas();
      _carregaOperacoes = _getOperacoes();
    });
  }

  Future<List> _getContas() async {
    //return await cs.listaTodasContas(); metodo SQLite
    return await crs.getContas();
  }

  Future<List> _getOperacoes() async {
    // return await os.getAllOperacoes(); metodo SQLite
    return await ors.getOperacoes();
  }
}
