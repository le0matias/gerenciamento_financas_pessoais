import 'package:flutter/material.dart';

import 'package:gerenciamento_financas_pessoais/models/conta.dart';
import 'package:gerenciamento_financas_pessoais/models/operacao.dart';
import 'package:gerenciamento_financas_pessoais/pages/shared_components/card_conta.dart';
import 'package:gerenciamento_financas_pessoais/pages/shared_components/card_operacao.dart';
import 'package:gerenciamento_financas_pessoais/services/conta_rest_service.dart';
import 'package:gerenciamento_financas_pessoais/services/conta_service.dart';
import 'package:gerenciamento_financas_pessoais/services/operacao_service.dart';

class Body extends StatefulWidget {

  late final int id;

  Body({required this.id});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  OperacaoService os = OperacaoService();
  ContaService cs = ContaService();
  ContaRestService crs = ContaRestService();

  late Future<List> _carregaOperacoes;
  late Future<Conta> _carregaConta;
  late Conta _conta;
  late List<Operacao> _operacoes;

  @override
  void initState() {
    _carregaOperacoes = _getOperacoes(widget.id);
    _carregaConta = _getConta(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _carregaConta,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData) {
            _conta = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: SizedBox(
                    height: 175,
                    width: double.infinity,
                    child: cardConta(context, _conta),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 15, right: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Todas as Operações',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _conta.operacoes!.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index){
                      return cardOperacao(context, index, _conta.operacoes![index]);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }

  Future<Conta> _getConta(int id) async {
    // return await cs.getConta(id); metodo SQLite
    return await crs.getContaId(id.toString());
  }

  Future<List> _getOperacoes(int id) async {
    return await os.getOperacoesConta(id);
  }
}
