import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

import '../../../models/operacao.dart';

Widget cardOperacao(BuildContext context, int index, Operacao operacao){

  final currencyFormatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  
  return Container(
    margin: EdgeInsets.only(bottom: 8, left: 10, right: 10),
    height: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Color(0x00400000),
          blurRadius: 10,
          spreadRadius: 10,
          offset: Offset(0.0, 0.8)
        ),
      ],
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  operacao.nome,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: operacao.tipo == 'entrada' ? Colors.green : Colors.red,
                  ),
                ),
                Text(
                  operacao.resumo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currencyFormatter.format(operacao.custo),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    formatDate(
                    DateTime.parse(operacao.data),
                    [dd, '/', mm, '/', yyyy]).toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}