import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../models/conta.dart';

Widget cardConta(BuildContext context, Conta conta) {

  final currencyFormatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  return InkWell(
    onTap: (){},
    child: Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueAccent,
        boxShadow: const [
          BoxShadow(
            color: Color(0x00100000),
            blurRadius: 8,
            spreadRadius: 4,
            offset: Offset(0.0, 0.7)
          )
        ]
      ),
      child: Stack(
        children: [
          Positioned(
            top: 14,
            right: 12,
            child: Text(
              conta.nome,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            top: 63,
            left: 16,
            child: Text(
              'Saldo em Conta',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 81,
            left: 16,
            child: Text(
              currencyFormatter.format(conta.valor),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            ),
        ],
      ),
    ),
  );
}