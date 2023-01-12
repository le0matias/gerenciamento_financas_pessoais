import 'package:flutter/material.dart';
import 'package:gerenciamento_financas_pessoais/pages/home/components/body.dart';
import 'package:gerenciamento_financas_pessoais/pages/home/components/speed_dial.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      floatingActionButton: buildSpeedDial(context),
    );
  }
}
