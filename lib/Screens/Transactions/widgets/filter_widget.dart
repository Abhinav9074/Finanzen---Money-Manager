// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';

// ignore: must_be_immutable
class FilterWidget extends StatefulWidget {
  final int index;
  dynamic startNotifier;
  dynamic endNotifier;
  dynamic categoryNotifier;

  FilterWidget(
      {super.key,
      required this.index,
      required this.startNotifier,
      required this.endNotifier,
      required this.categoryNotifier});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  DateTime? startDate;
  String? selectedDropownValue;
  DateTime? EndDate;
  late final first_index;
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
                    widget.startNotifier.value = startDate.toString().substring(0,10);
                  });
                },
                icon: const FaIcon(FontAwesomeIcons.calendar),
                label: startDate == null
                    ? Text(
                        widget.startNotifier.value.toString().substring(0, 10))
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
                    widget.endNotifier.value = EndDate.toString().substring(0,10);
                  });
                },
                icon: const FaIcon(FontAwesomeIcons.calendar),
                label: EndDate == null
                    ? Text(
                        widget.startNotifier.value.toString().substring(0, 10))
                    : Text(EndDate.toString().substring(0, 10)))
          ],
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Filter By Category',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              fontFamily: 'texgyreadventor-regular',
            ),
          ),
        ),
        DropdownButton(
          hint:  Text(
            widget.categoryNotifier.value,
            style:
                const TextStyle(fontSize: 20, fontFamily: 'texgyreadventor-regular'),
          ),
          value: selectedDropownValue,
          items: (widget.index == 0
                  ? CategoryDb().allCategoriesList
                  : widget.index == 1
                      ? CategoryDb().incomeCategoryList
                      : CategoryDb().expenseCategoryList)
              .value
              .map((e) {
            return DropdownMenuItem(
                value: e.categoryName,
                child: e.isDeleted != true
                    ? Text(e.categoryName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'texgyreadventor-regular'))
                    : Text(
                        e.categoryName,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontFamily: 'texgyreadventor-regular'),
                      ));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedDropownValue = value!;
              widget.categoryNotifier.value=selectedDropownValue;
            });
          },
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
            ElevatedButton(
                onPressed: () {
                  TransactionDb().refreshUI();
                  Navigator.of(context).pop();
                  widget.startNotifier.value=DateTime.now().toString().substring(0,10);
                  widget.endNotifier.value=DateTime.now().toString().substring(0,10);
                  widget.categoryNotifier.value = 'Select a Category';
                },
                child: const Text('Clear')),
          ],
        )
      ],
    );
  }

  Future<void> FilterPress() async {
    if (startDate != null && EndDate != null && selectedDropownValue != null) {
      await TransactionDb().FilterByDate(startDate!, EndDate!);
      await TransactionDb().FilterByCategory(selectedDropownValue!);
    } else if (selectedDropownValue != null) {
      await TransactionDb().FilterByCategory(selectedDropownValue!);
    } else if (startDate != null && EndDate != null) {
      await TransactionDb().FilterByDate(startDate!, EndDate!);
    }
    // print(TransactionDb().allTransactionsList.value);
  }
}
