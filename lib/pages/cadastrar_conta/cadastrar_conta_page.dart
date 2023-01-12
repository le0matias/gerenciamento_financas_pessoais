import 'package:flutter/material.dart';
import 'package:gerenciamento_financas_pessoais/pages/home/home_page.dart';
import 'package:gerenciamento_financas_pessoais/services/conta_service.dart';

import '../../models/conta.dart';

class CadastrarContaPage extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  ContaService cs = ContaService();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Valor'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Conta novaConta = Conta(
                          nome: _nomeController.text,
                          valor: double.parse(_valorController.text),
                        );
                        cs.adicionarConta(novaConta);
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => HomePage())
                        );
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
