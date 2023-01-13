import 'package:flutter/material.dart';

import '../../shared_components/card_operacao.dart';
import 'package:gerenciamento_financas_pessoais/services/operacao_service.dart';

class Body extends StatefulWidget {

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  OperacaoService os = OperacaoService();
  late Future<List> _carregaOperacoes;
  late List _operacoes;

  @override
  void initState(){
    _carregaOperacoes = _getOperacoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60, top: 45, bottom: 16, right: 25),
          child: Row(
            children: const [
              Text(
                'Todas as Operações',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black,
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
                    itemCount: _operacoes.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return cardOperacao(context, index, _operacoes[index]);
                    },
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
    );
  }

  Future<List> _getOperacoes() async {
    return await os.getAllOperacoes();
  }
}
