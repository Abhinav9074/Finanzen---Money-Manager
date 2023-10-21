import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/Screens/stats/models/stat_models.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';

class StatFilterWidget extends StatefulWidget {
  const StatFilterWidget({
    super.key,
  });

  @override
  State<StatFilterWidget> createState() => _StatFilterWidgetState();
}

class _StatFilterWidgetState extends State<StatFilterWidget> {
  DateTime? startDate;
  // ignore: non_constant_identifier_names
  DateTime? EndDate;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  late final first_index;
  // ignore: prefer_typing_uninitialized_variables
  late final indexValue;

  @override
  void initState() {
    if (TransactionDb().allTransactionsList.value.isNotEmpty) {
      first_index = TransactionDb().allTransactionsList.value.length - 1;
      indexValue = TransactionDb().allTransactionsList.value[first_index];
    } else {
      indexValue = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Filter By Date',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            fontFamily: 'texgyreadventor-regular',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () async {
                  startDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: TransactionDb().indexValue == null
                          ? DateTime.now()
                          : TransactionDb().indexValue.date,
                      lastDate: DateTime.now());
                  setState(() {
                    
                  });
                },
                icon: const FaIcon(FontAwesomeIcons.calendar),
                label: startDate == null
                    ? const Text(
                        'Pick Date')
                    : Text(startDate.toString().substring(0, 10))),
                    const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                'To',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  fontFamily: 'texgyreadventor-regular',
                ),
              ),
            ),
                     TextButton.icon(
                onPressed: () async {
                  EndDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          startDate == null ? DateTime.now() : startDate!,
                      lastDate: DateTime.now());
                  setState(() {
                   
                  });
                },
                icon: const FaIcon(FontAwesomeIcons.calendar),
                label: EndDate == null
                    ? const Text(
                        'Date')
                    : Text(EndDate.toString().substring(0, 10)))
          ],
        ),
        
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await FilterPress();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: const Text('Filter')),
                
            const SizedBox(
              width: 10,
            ),
          ],
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> FilterPress() async {
    if (startDate != null && EndDate !=null) {
      await TransactionDb().FilterByDate(startDate!, EndDate!);
      getIncomeChartData();
      getExpenseChartData();
      getAllChartData();
    } 
  }
}
