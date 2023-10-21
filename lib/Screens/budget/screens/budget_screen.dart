import 'package:flutter/material.dart';
import 'package:money_manager/Screens/budget/widgets/balance_days.dart';
import 'package:money_manager/Screens/budget/widgets/budget_creator.dart';
import 'package:money_manager/Screens/budget/widgets/budget_list.dart';
import 'package:money_manager/db/budget/budget_db.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BudgetDb().AutoDeleteBudget();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 235, 235),
      appBar: AppBar(
        title: const Text(
          'Budget Management',
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'texgyreadventor-regular',
              color: Colors.black,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 232, 235, 235),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) {
                return SimpleDialog(
                  title: Text('Add a Budget For This Month',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'texgyreadventor-regular',
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                          children: [BudgetCreatorDialogue(ctx: context,)],
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BalanceDays(), 
            Expanded(child: BudgetList(ctx: context))
          ],
        )
        ),
    );
  }
}
