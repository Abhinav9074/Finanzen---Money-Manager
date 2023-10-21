import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager/db/budget/budget_db.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/categoryModel/category_model.dart';
import 'package:money_manager/models/transactionModel/transactions_model.dart';
import 'package:recase/recase.dart';

class AddTransactionsSample extends StatefulWidget {
  const AddTransactionsSample({super.key});

  @override
  State<AddTransactionsSample> createState() => _AddTransactionsSampleState();
}

class _AddTransactionsSampleState extends State<AddTransactionsSample> {
  bool isDateVisible = false;
  bool isCategoryVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  late var _selectedImage;
  late final DateTime _finalDate;
  String? _finalImage;
  DateTime? _selectedDate;
  String? finalDate;
  CategoryType? _selectedCategory;
  String? selectedDropownValue;
  @override
  void initState() {
    _selectedCategory = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 235, 235),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const FaIcon(
                FontAwesomeIcons.angleLeft,
                color: Colors.black,
              )),
        ),
        title: const Text(
          'Add Transactions',
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'texgyreadventor-regular',
              color: Colors.black,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 232, 235, 235),
        elevation: 0,
      ),
      body: ListView(
        children: [
          //Income Expense Selector
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategory,
                        onChanged: (val) {
                          setState(() {
                            _selectedCategory = CategoryType.income;
                            selectedDropownValue = null;
                          });
                        }),
                    const Text('Income',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'texgyreadventor-regular'))
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategory,
                        onChanged: (val) {
                          setState(() {
                            _selectedCategory = CategoryType.expense;
                            selectedDropownValue = null;
                          });
                        }),
                    const Text('Expense',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'texgyreadventor-regular'))
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: PhysicalModel(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              shadowColor: Colors.black,
              elevation: 5,
              child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.28
                        : MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/card_front.png",
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //Select Category

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(canvasColor: Colors.black),
                              child: DropdownButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.angleDown,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  hint: Text(
                                    'Select Category ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'texgyreadventor-regular',
                                        color: Colors.white),
                                  ),
                                  value: selectedDropownValue,
                                  items: (_selectedCategory ==
                                              CategoryType.income
                                          ? CategoryDb().incomeCategoryList
                                          : CategoryDb().expenseCategoryList)
                                      .value
                                      .map((e) {
                                    return DropdownMenuItem(
                                        value: e.categoryName,
                                        child: e.isDeleted != true
                                            ? Text(e.categoryName,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        'texgyreadventor-regular',
                                                    color: Colors.white))
                                            : Text(
                                                e.categoryName,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 10,
                                                  fontFamily:
                                                      'texgyreadventor-regular',
                                                ),
                                              ));
                                  }).toList(),
                                  onChanged: (selectedValue) {
                                    setState(() {
                                      selectedDropownValue = selectedValue;
                                    });
                                  }),
                            ),
                            Visibility(
                                visible: isCategoryVisible,
                                child: const Text(
                                  'Please Pick a Category',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'texgyreadventor-regular',
                                      color: Colors.red),
                                )),
                          ],
                        ),

                        //Purpose field

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 120, 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: TextFormField(
                              maxLength: 20,
                              enableInteractiveSelection: false,
                              controller: _purposeController,
                              decoration: const InputDecoration(
                                hintText: 'Purpose',
                                hintStyle: TextStyle(
                                    fontFamily: 'Raleway-VariableFont_wght',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (!RegExp(r'^\S+(?!\d+$)')
                                    .hasMatch(value ?? '')) {
                                  return 'Please enter a valid purpose.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        //Amount Field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 120, 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: TextFormField(
                                maxLength: 10,
                                controller: _amountController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration: const InputDecoration(
                                  label: Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontFamily: 'Raleway-VariableFont_wght',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (!RegExp(r'^[0-9]+$')
                                      .hasMatch(value ?? '')) {
                                    return 'Please enter a valid amount.';
                                  }
                                  return null;
                                }),
                          ),
                        ),

                        //Date Picker

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('DATE : ',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'texgyreadventor-regular',
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255))),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                              child: SizedBox(
                                height: 30,
                                child: ElevatedButton.icon(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color(0xFF4A8166))),
                                    onPressed: () async {
                                      final tempDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now());
                                      setState(() {
                                        _selectedDate = tempDate;
                                        finalDate = _selectedDate.toString();
                                      });
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.calendar,
                                      size: 15,
                                    ),
                                    label: _selectedDate == null
                                        ? const Text('Select Date',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily:
                                                    'texgyreadventor-regular',
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255)))
                                        : Text(finalDate!.substring(0, 10),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily:
                                                    'texgyreadventor-regular',
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255)))),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                    visible: isDateVisible,
                                    child: const Text(
                                      'Please Pick a Date',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'texgyreadventor-regular',
                                          color: Colors.red),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          //Second Card

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: PhysicalModel(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              shadowColor: Colors.black,
              elevation: 5,
              child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.28
                        : MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? DecorationImage(
                            image: AssetImage(
                              "assets/images/card_back.png",
                            ),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: AssetImage(
                              "assets/images/card_front.png",
                            ),
                            fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Color.fromARGB(255, 0, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Reciept (Optional)',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 191, 186, 186),
                                  fontFamily: 'texgyreadventor-regular',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),

                      //Image Picker

                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 90,
                              height: 30,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                        255, 255, 255, 255), //background color
                                    foregroundColor: const Color.fromARGB(
                                        255, 255, 255, 255), //ripple color
                                  ),
                                  onPressed: () {
                                    PickImageFromCamera();
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.camera,
                                    size: 10,
                                    color: Colors.black,
                                  ),
                                  label: const Text(
                                    'Camera',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontFamily: 'texgyreadventor-regular'),
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 90,
                              height: 30,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                        255, 255, 255, 255), //background color
                                    foregroundColor: const Color.fromARGB(
                                        255, 255, 255, 255), //ripple color
                                  ),
                                  onPressed: () {
                                    PickImageFromGallery();
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.photoFilm,
                                    size: 10,
                                    color: Colors.black,
                                  ),
                                  label: const Text('Gallery',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily:
                                              'texgyreadventor-regular'))),
                            ),
                          ],
                        ),
                      ),

                      _finalImage == null
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Image.file(
                                  File(_finalImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),

          //Add button

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 280),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (selectedDropownValue == null) {
                          setState(() {
                            isCategoryVisible = true;
                          });
                        }
                        if (_selectedDate == null) {
                          setState(() {
                            isDateVisible = true;
                          });
                        }
                        if (_formKey.currentState!.validate() &&
                            _selectedDate != null &&
                            selectedDropownValue != null) {
                          bool chk = await BudgetDb().CheckBudgetOverFlow(
                              selectedDropownValue!, _amountController.text);

                          if (chk == true) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return SimpleDialog(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/warning.gif',
                                          height: 20,
                                          width: 20,
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '''Budget Limit Will Exceed''',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily:
                                                    'texgyreadventor-regular',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  'By Adding This Transaction\nYour Budget Will Exceed',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'texgyreadventor-regular',
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton.icon(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.close,
                                                    color: Colors.red,
                                                  ),
                                                  label: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                              TextButton.icon(
                                                  onPressed: () async{
                                                    await onAdd();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                        'Data Added Successfully',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      padding:
                                                          EdgeInsets.all(20),
                                                    ));
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.check,
                                                    color: Colors.green,
                                                  ),
                                                  label: Text(
                                                    'Yes Proceed',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  )),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                });
                          } else {
                            await onAdd();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Data Added Successfully',
                                style: TextStyle(fontSize: 15),
                              ),
                              behavior: SnackBarBehavior.floating,
                              padding: EdgeInsets.all(20),
                            ));
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: const Text('Add Transaction',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'texgyreadventor-regular'))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> PickImageFromGallery() async {
    _selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_selectedImage != null) {
      String imageFile = _selectedImage.path;
      setState(() {
        _finalImage = imageFile;
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> PickImageFromCamera() async {
    _selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (_selectedImage != null) {
      String imageFile = _selectedImage.path;
      setState(() {
        _finalImage = imageFile;
      });
    }
  }

  Future<void> onAdd() async {
    int year = int.parse(finalDate!.substring(0, 4));
    int month = int.parse(finalDate!.substring(5, 7));
    int day = int.parse(finalDate!.substring(8, 10));
    int dateSum = year + month + day;
    if (_selectedDate != null) {
      _finalDate = _selectedDate!;
    }
    // ignore: prefer_conditional_assignment
    if (_finalImage == null) {
      _finalImage = '';
    }
    final transactionData = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        purpose: _purposeController.text.titleCase,
        amount: _amountController.text,
        date: _finalDate,
        dateSum: dateSum,
        recieptImage: _finalImage!,
        type: _selectedCategory!,
        categorySubType: selectedDropownValue!);
    TransactionDb().addTransactions(transactionData);
  }
}
