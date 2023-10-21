import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/categoryModel/category_model.dart';
import 'package:money_manager/models/transactionModel/transactions_model.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String price;
  final String purpose;
  final String subcategory;
  final DateTime date;
  final String image;
  final CategoryType category;
  final String id;

  const TransactionDetailsScreen(
      {super.key,
      required this.price,
      required this.purpose,
      required this.subcategory,
      required this.date,
      required this.image,
      required this.category,
      required this.id
      });

  @override
  Widget build(BuildContext context) {
    TransactionDb().findSpeciificTransaction(subcategory,id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
            )),
        backgroundColor: const Color.fromARGB(255, 232, 235, 235),
        elevation: 0,
        title: const Text('Transaction Details',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'texgyreadventor-regular',
                color: Colors.black,
                fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 232, 235, 235),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 4, 37, 112),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '₹$price',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: category == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                        fontFamily: 'texgyreadventor-regular',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      purpose,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Raleway-VariableFont_wght'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      subcategory,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Raleway-VariableFont_wght'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      date.toString().substring(0, 10),
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Raleway-VariableFont_wght'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    image != ''
                        ? ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return SimpleDialog(
                                      insetPadding: const EdgeInsets.all(0),
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon:
                                                    const FaIcon(FontAwesomeIcons.x))
                                          ],
                                        ),
                                        Image.file(File(image))
                                      ],
                                    );
                                  });
                            },
                            icon: const FaIcon(FontAwesomeIcons.image),
                            label: const Text(
                              'View Receipt',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'Raleway-VariableFont_wght'),
                            ))
                        : const Text(
                            'No Reciept',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 255, 0, 0),
                                fontFamily: 'Raleway-VariableFont_wght'),
                          )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: category == CategoryType.income
                  ? Text(
                      'Other Income In $subcategory',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 25,
                          fontFamily: 'texgyreadventor-regular',
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 2, 39, 71)),
                    )
                  : Text(
                      'Other Expenses In $subcategory',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 25,
                          fontFamily: 'texgyreadventor-regular',
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 2, 39, 71)),
                    ),
            ),
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: TransactionDb().specificTransactionsList,
              builder: (BuildContext context, List<TransactionModel> newList,
                  Widget? _) {
                return newList.isNotEmpty?ListView.builder(
                  itemCount: newList.length,
                  itemBuilder: (context, index) {
                    final data = newList[index];
                    return Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: PhysicalModel(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(40),
                            elevation: 6.0,
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){return TransactionDetailsScreen(price: data.amount, purpose: data.purpose, subcategory: data.categorySubType, date: data.date, image: data.recieptImage!, category: data.type, id: data.id);}));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 0, 0, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      PhysicalModel(
                                        color: Colors.black,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        elevation: 4.0,
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 232, 235, 235),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                parseDate(data.date),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontFamily:
                                                        'texgyreadventor-regular',
                                                    fontWeight:
                                                        FontWeight.w900,
                                                    color: Color.fromARGB(
                                                        255, 2, 39, 71)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data.purpose,
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontFamily:
                                                        'texgyreadventor-regular',
                                                    fontWeight:
                                                        FontWeight.w900,
                                                    color: Color.fromARGB(
                                                        255, 2, 39, 71))),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            data.type == CategoryType.income
                                                ? Text(data.categorySubType,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'texgyreadventor-regular',
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color:
                                                            Color.fromARGB(
                                                                255,
                                                                33,
                                                                165,
                                                                6)))
                                                : Text(data.categorySubType,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'texgyreadventor-regular',
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color:
                                                            Color.fromARGB(
                                                                255,
                                                                255,
                                                                0,
                                                                0))),
                                          ],
                                        ),
                                      ),
                                      Text('₹${data.amount}',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily:
                                                  'texgyreadventor-regular',
                                              fontWeight: FontWeight.w600,
                                              color: data.type ==
                                                      CategoryType.income
                                                  ? Colors.green
                                                  : Colors.red)),
                                      const SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ):Center(child: Text('No Data',style: TextStyle(fontFamily:
                                                'texgyreadventor-regular',),));
              },
            ))
          ],
        ),
      )),
    );
  }

  String parseDate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitDate = date0.split(' ');
    return '${splitDate[1]}\n${splitDate[0]}';
  }
}
