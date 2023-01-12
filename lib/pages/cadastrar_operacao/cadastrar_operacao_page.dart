import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:gerenciamento_financas_pessoais/pages/home/home_page.dart';
import 'package:gerenciamento_financas_pessoais/services/operacao_service.dart';

import '../../models/operacao.dart';
import '../../services/conta_service.dart';
import '../../models/conta.dart';

class CadastrarOperacaoPage extends StatefulWidget {

  late final String tipoOperacao;

  CadastrarOperacaoPage({required this.tipoOperacao});

  @override
  State<CadastrarOperacaoPage> createState() => _CadastrarOperacaoPageState();
}

class _CadastrarOperacaoPageState extends State<CadastrarOperacaoPage> {
  final _nomeController = TextEditingController();
  final _resumoController = TextEditingController();
  final _custoController = TextEditingController();
  final _tipoController = TextEditingController();
  final _dataController = TextEditingController();
  ContaService cs = ContaService();
  OperacaoService os = OperacaoService();
  DateTime selectDate = DateTime.now();

  late Future<List> _carregaContas;
  late List<Conta> _contas;

  Conta? _contaSelecionada;

  @override
  void initState(){
    _carregaContas = _getContas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tipoOperacao == 'entrada' ? 'Cadastro de Entrada' : 'Cadastro de Saída'
        ),
        backgroundColor: widget.tipoOperacao == 'entrada' ? Colors.green : Colors.red,
      ),
      body: FutureBuilder(
        future: _carregaContas,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            _contas = snapshot.data;
            return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    TextFormField(
                      controller: _resumoController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Resumo'),
                    ),
                    TextFormField(
                      controller: _custoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Custo'),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _dataController,
                          decoration: InputDecoration(
                            labelText: formatDate(
                                selectDate,
                                [dd, '/', mm, '/', yyyy],
                            )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: DropdownButtonFormField(
                          hint: const Text('Conta'),
                          value: _contaSelecionada,
                          onChanged: (Conta? conta) {
                            setState(() {
                              _contaSelecionada = conta;
                            });
                          },
                          items: _contas.map((conta) {
                            return DropdownMenuItem(
                                value: conta,
                                child: Text(conta.nome)
                            );
                          }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Operacao novaOperacao = Operacao(
                                nome: _nomeController.text,
                                resumo: _resumoController.text,
                                data: selectDate.toString(),
                                tipo: widget.tipoOperacao,
                                conta: _contaSelecionada?.id,
                                custo: double.parse(_custoController.text),
                            );
                            os.addOperacao(novaOperacao);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => HomePage())
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.tipoOperacao == 'entrada' ? Colors.green : Colors.red
                          ),
                          child: const Text('Cadastrar'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List> _getContas() async {
    return await cs.listaTodasContas();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        locale: const Locale('pt', 'BR'),
        context: context,
        initialDate: selectDate,
        firstDate: DateTime(2022, 01),
        lastDate: DateTime(2030, 01),
    );
    if(pickedDate != null && pickedDate != selectDate) {
      setState(() {
        selectDate = pickedDate;
      });
    }
  }
}
