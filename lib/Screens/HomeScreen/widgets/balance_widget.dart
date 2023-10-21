import 'package:flutter/material.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';

class TotalBalanace extends StatefulWidget {
  const TotalBalanace({super.key});

  @override
  State<TotalBalanace> createState() => _TotalBalanaceState();
}

class _TotalBalanaceState extends State<TotalBalanace> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: TransactionDb().total,
          builder: (BuildContext context, double total, Widget? _) {
            return Visibility(
              visible: TransactionDb().total.value<0?true:false,
              child: Text('Running Out Of Money !!!',style: TextStyle(
                      letterSpacing: 1,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color: Colors.red,
                      fontFamily: 'texgyreadventor-regular',
                    ),),
            );
          }
        ),
        ValueListenableBuilder(
          valueListenable: TransactionDb().total,
          builder: (BuildContext context, double total, Widget? _) {
            return total>0?Text(
              '₹ ${total}',
              style: TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
                fontSize: 30,
                fontFamily: 'texgyreadventor-regular',
              ),
            ):Text(
              '₹ ${total}',
              style: TextStyle(
                color: Colors.red,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
                fontSize: 30,
                fontFamily: 'texgyreadventor-regular',
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Total Balance',
          style: TextStyle(
              fontFamily: 'texgyreadventor-regular', color: Colors.grey),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
