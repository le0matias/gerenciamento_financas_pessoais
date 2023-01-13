import 'package:flutter/material.dart';
import 'package:gerenciamento_financas_pessoais/pages/operacao/components/body.dart';

class OperacaoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Body(),
    );
  }
}
