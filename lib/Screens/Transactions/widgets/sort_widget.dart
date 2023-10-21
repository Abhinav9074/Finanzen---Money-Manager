import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';

class SortWidget extends StatefulWidget {

  final dynamic indexCount;

  const SortWidget({super.key, required this.indexCount});

  

  @override
  State<SortWidget> createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Price (Low To High)',
      'Price (High To Low)',
      'Date (Ascending)',
      'Date (Descending)'
    ];
    String dropdownValue = items[widget.indexCount.value];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Sort By',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'texgyreadventor-regular',
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
        ),
        DropdownButton(
          hint: Text('Select'),
          value: dropdownValue,
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) async{
            dropdownValue = value!;
            if(dropdownValue=='Price (Low To High)'){
              widget.indexCount.value=0;
              await TransactionDb().Sorting(0);
            }else if(dropdownValue=='Price (High To Low)'){
              widget.indexCount.value=1;
              await TransactionDb().Sorting(1);
            }else if(dropdownValue=='Date (Ascending)'){
              widget.indexCount.value=2;
              await TransactionDb().Sorting(2);
            }else{
              widget.indexCount.value=3;
              await TransactionDb().Sorting(3);
            }
            Navigator.of(context).pop();
          },
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     ElevatedButton.icon(
        //         onPressed: () {
        //           print(dropdownValue);
        //         },
        //         icon: const FaIcon(FontAwesomeIcons.sort),
        //         label: const Text('Sort')),
        //   ],
        // )
      ],
    );
  }
}
