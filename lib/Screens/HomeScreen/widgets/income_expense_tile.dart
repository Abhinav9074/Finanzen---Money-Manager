import 'package:flutter/material.dart';
import 'package:money_manager/Screens/Stats/widgets/income_stats.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';

class IncomeExpenseTile extends StatelessWidget {
  const IncomeExpenseTile({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PhysicalModel(
          color: Colors.black,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          elevation: 8.0,
          child: InkWell(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return const IncomeStats();
                  });
            },
            child: Container(
              width: width / 2.2,
              height: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.height > 800
                  ? height * 0.120
                  : height * 0.140
                  : height * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 53, 198, 140)),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Income',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'texgyreadventor-regular'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
                    child: ValueListenableBuilder(
                      valueListenable: TransactionDb().income,
                      builder: (BuildContext context, double income, Widget? _) {
                        return Text(
                          '₹${income}',
                          style: TextStyle(
                            letterSpacing: 1,
                              color: Colors.white,
                              fontFamily: 'texgyreadventor-regular',
                              fontWeight: FontWeight.w700),
                        );
                      }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        PhysicalModel(
          color: Colors.black,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          elevation: 8.0,
          child: Container(
            width: width / 2.2,
            height: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.height > 800
                  ? height * 0.120
                  : height * 0.140
                  : height * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 178, 83, 83)),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    'Expense',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'texgyreadventor-regular'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
                  child: ValueListenableBuilder(
                    valueListenable: TransactionDb().expense,
                    builder: (BuildContext context, double expense, Widget? _) {
                      return Text(
                        '₹${expense}',
                        style: TextStyle(
                          letterSpacing: 1,
                            color: Colors.white,
                            fontFamily: 'texgyreadventor-regular',
                            fontWeight: FontWeight.w700),
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
