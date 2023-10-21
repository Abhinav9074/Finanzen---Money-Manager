import 'package:flutter/material.dart';
import 'package:money_manager/db/budget/budget_db.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/budgetModel/budget_model.dart';

class BudgetEditorDialogue extends StatefulWidget {
  final BuildContext ctx;
  final String amount;
  final String category;
  final String id;

  const BudgetEditorDialogue({super.key, required this.ctx, required this.amount, required this.category, required this.id});

  @override
  State<BudgetEditorDialogue> createState() => _BudgetEditorDialogueState();
}

class _BudgetEditorDialogueState extends State<BudgetEditorDialogue> {
  TextEditingController _amount = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    _amount = TextEditingController(text: widget.amount);
    _selectedCategory = widget.category;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton(
            hint: Text('Select An Expense Category',
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'texgyreadventor-regular',
                    color: Colors.black,
                    fontWeight: FontWeight.w400)),
            value: _selectedCategory,
            items: CategoryDb().expenseCategoryList.value.map((e) {
              return DropdownMenuItem(
                child: Text(e.categoryName),
                value: e.categoryName,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            }),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: TextFormField(
            controller: _amount,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter The Budget Amount',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'texgyreadventor-regular',
                        color: Colors.black,
                        fontWeight: FontWeight.w400))),
          ),
        ),
        ElevatedButton.icon(
            onPressed: () async{
              if (_selectedCategory!=null && _amount.text!=null) {
                bool chk = await BudgetDb().CheckExisitingBudget2(_selectedCategory!,widget.category);
                if(chk){
                  showDialog(context: context, builder: (ctx){
                    return AlertDialog(
                      content: Text('Budget Already Exist On This Category',style: TextStyle(fontFamily: 'texgyreadventor-regular',color: Colors.red),),
                    );
                  });
                }else{
                  await onAdd();
                Navigator.of(widget.ctx).pop();
                ScaffoldMessenger.of(widget.ctx).showSnackBar(SnackBar(
                    content: Text('Budget Updated',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'texgyreadventor-regular',
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w900)),behavior: SnackBarBehavior.floating,));
                }
              }
            },
            icon: Icon(Icons.add),
            label: Text('Update Budget',
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'texgyreadventor-regular',
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600)))
      ],
    );
  }

  Future<void>onAdd()async{
    String currentTotal = await BudgetDb().getTotalCurrentAmount(_selectedCategory!);
    double progressLevel = await BudgetDb().getTotalProgress(_selectedCategory!, _amount.text);
    final budgetData = BudgetModel(CategoryName: _selectedCategory!, BudgetAmount: _amount.text, id: widget.id,currentAmount: currentTotal,progress: progressLevel);
    await BudgetDb().addBudget(budgetData);
  }
}
