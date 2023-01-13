import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/services.dart';

import '../home/home_page.dart';
import '../../models/operacao.dart';
import '../../models/conta.dart';
import '../../services/operacao_rest_service.dart';
import '../../services/operacao_service.dart';
import '../../services/conta_rest_service.dart';
import '../../services/conta_service.dart';

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
  ContaRestService crs = ContaRestService();
  OperacaoService os = OperacaoService();
  OperacaoRestService ors = OperacaoRestService();
  DateTime selectDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Preencha o campo Nome';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: _resumoController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Resumo'),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Preencha o campo Resumo';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: _custoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(labelText: 'Custo'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo Custo';
                          } else {
                            return null;
                          }
                        }
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
                          validator: (value) {
                            if(value == null) {
                              return 'Selecione uma Conta';
                            } else {
                              return null;
                            }
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
                            if(_formKey.currentState!.validate()) {
                              Operacao novaOperacao = Operacao(
                                nome: _nomeController.text,
                                resumo: _resumoController.text,
                                data: formatDate(
                                    selectDate,
                                    [yyyy, '-', mm, '-', dd]
                                ).toString(),
                                tipo: widget.tipoOperacao,
                                conta: _contaSelecionada?.id,
                                custo: double.parse(_custoController.text),
                              );
                              // os.addOperacao(novaOperacao); metodo SQLite
                              ors.addOperacao(novaOperacao);
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => HomePage())
                              );
                            }
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
    // return await cs.listaTodasContas(); metodo SQLite
    return await crs.getContas();
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
