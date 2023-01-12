import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gerenciamento_financas_pessoais/pages/cadastrar_conta/cadastrar_conta_page.dart';

import 'pages/cadastrar_operacao/cadastrar_operacao_page.dart';

void main()=>runApp(Main());

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR'),],
      debugShowCheckedModeBanner: true,
      // home: CadastrarContaPage(),
      home: CadastrarOperacaoPage(tipoOperacao: 'saida',),
    );
  }
}
