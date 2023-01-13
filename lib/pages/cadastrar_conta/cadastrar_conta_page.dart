import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciamento_financas_pessoais/pages/home/home_page.dart';
import 'package:gerenciamento_financas_pessoais/services/conta_rest_service.dart';
import 'package:gerenciamento_financas_pessoais/services/conta_service.dart';

import '../../models/conta.dart';

class CadastrarContaPage extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  ContaService cs = ContaService();
  ContaRestService crs = ContaRestService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Conta'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
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
                    if(value == null || value.isEmpty) {
                      return 'Preencha o campo Nome';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: 'Valor'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo Valor';
                    } else {
                      return null;
                    }
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          Conta novaConta = Conta(
                            nome: _nomeController.text,
                            valor: double.parse(_valorController.text),
                          );
                          // cs.adicionarConta(novaConta); sqlite method
                          crs.addConta(novaConta);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => HomePage())
                          );
                        }
                      },
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
