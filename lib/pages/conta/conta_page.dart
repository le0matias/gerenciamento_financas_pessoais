import 'package:flutter/material.dart';

import 'package:gerenciamento_financas_pessoais/pages/conta/components/body.dart';

class ContaPage extends StatelessWidget {

  late final int? id;

  ContaPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id!),
    );
  }
}
