import 'package:flutter/material.dart';
import 'package:money_manager/db/budget/budget_db.dart';

class BalanceDays extends StatefulWidget {
  const BalanceDays({super.key});

  @override
  State<BalanceDays> createState() => _BalanceDaysState();
}

class _BalanceDaysState extends State<BalanceDays> {
  int remaning = 0;
  @override
  void initState() {
     remaning = BudgetDb().CalucuateRemaningDays();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BudgetDb().BudgetListNotifier.value.isNotEmpty?Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${remaning}',style: TextStyle(fontSize: 100,fontFamily:'texgyreadventor-regular',),),
        Text('Days Remaining',style: TextStyle(fontFamily:'texgyreadventor-regular',fontSize: 35),),
        Text('All Budgets Will Be Deleted After This Month',style: TextStyle(fontFamily:'texgyreadventor-regular',fontSize: 15),),
      ],
    ):SizedBox();
  }
}