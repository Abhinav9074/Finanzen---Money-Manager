import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/Screens/categories/widgets/edit_category.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/categoryModel/category_model.dart';

class ExpenseCategoryScreen extends StatelessWidget {
  ExpenseCategoryScreen({super.key});

  TextEditingController _captchaCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expenseCategoryList,
        builder:
            (BuildContext ctx, List<CategoryModel> expenseList, Widget? _) {
          return SlidableAutoCloseBehavior(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final data = expenseList[index];
                  return Column(
                    children: [
                      if (!data.isDeleted)
                        Slidable(
                          key: Key('$index'),
                          startActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (ctx) async {
                                    if (TransactionDb()
                                        .allTransactionsList
                                        .value
                                        .isNotEmpty) {
                                      int count = await TransactionDb()
                                          .CheckCategoryBeforeDelete(
                                              data.categoryName);
                                      if (count == 0) {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                content: const Text(
                                                    'The Data Will Be Deleted'),
                                                title:
                                                    const Text('Are You Sure'),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          icon: const Icon(
                                                              Icons.close)),
                                                      IconButton(
                                                        onPressed: () async {
                                                          CategoryDb()
                                                              .deleteCategory(
                                                                  data.id);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                              'Deleted Successfully',
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20),
                                                          ));
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: const Icon(
                                                            Icons.check),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      } else {
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
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '''Category Contains Transactions''',
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const SizedBox(
                                                        height: 150,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                'Deleting This Category\nWill Result In Deletion Of\nTransactions Related to\nThis Category',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      'texgyreadventor-regular',
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          TextButton.icon(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            icon: const Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                            label: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ),
                                                          TextButton.icon(
                                                            onPressed: () {
                                                              Random number =
                                                                  Random();
                                                              final randomNumber =
                                                                  number.nextInt(
                                                                      100000);
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (cxtx) {
                                                                    return SimpleDialog(
                                                                      title:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                              '$randomNumber',
                                                                              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontFamily: 'texgyreadventor-regular', fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: 5)),
                                                                        ],
                                                                      ),
                                                                      children: [
                                                                        Form(
                                                                          key: formKey,
                                                                          child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: TextFormField(
                                                                                  validator: (value){
                                                                                    if(value!=randomNumber.toString()){
                                                                                      return 'Please Enter The Number Correctly';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                  keyboardType: TextInputType.number,
                                                                                  controller: _captchaCont,
                                                                                  obscureText: true,
                                                                                  decoration: InputDecoration(labelText: 'Enter The Number', labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontFamily: 'texgyreadventor-regular', fontSize: 20)),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  TextButton.icon(
                                                                                    onPressed: () {
                                                                                      _captchaCont.clear();
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    icon: const Icon(
                                                                                      Icons.close,
                                                                                      color: Color.fromARGB(255, 255, 0, 0),
                                                                                    ),
                                                                                    label: const Text(
                                                                                      'Cancel',
                                                                                      style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                                                                                    ),
                                                                                  ),
                                                                                  TextButton.icon(
                                                                                    onPressed: () async {
                                                                                      if (formKey.currentState!.validate()) {
                                                                                        await TransactionDb().DeleteAllRelatedTransactions(data.categoryName);
                                                                                        await CategoryDb().deleteCategory(data.id);
                                                                                        Navigator.of(context).pop();
                                                                                        Navigator.of(context).pop();
                                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                          content: Text(
                                                                                            'Deleted Successfully',
                                                                                            style: TextStyle(fontSize: 15),
                                                                                          ),
                                                                                          behavior: SnackBarBehavior.floating,
                                                                                          padding: EdgeInsets.all(20),
                                                                                        ));
                                                                                      }
                                                                                    },
                                                                                    icon: const Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.green,
                                                                                    ),
                                                                                    label: const Text(
                                                                                      'Confirm',
                                                                                      style: TextStyle(color: Colors.green),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                            },
                                                            icon: const Icon(
                                                              Icons.check,
                                                              color: Colors.red,
                                                            ),
                                                            label: const Text(
                                                              'Yes Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      }
                                      ;
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              content: const Text(
                                                  'The Data Will Be Deleted'),
                                              title: const Text('Are You Sure'),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: const Icon(
                                                            Icons.close)),
                                                    IconButton(
                                                      onPressed: () async {
                                                        CategoryDb()
                                                            .deleteCategory(
                                                                data.id);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                            'Deleted Successfully',
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                        ));
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: const Icon(
                                                          Icons.check),
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  icon: FontAwesomeIcons.trash,
                                  autoClose: true,
                                  backgroundColor: Colors.red,
                                  label: 'Delete',
                                  borderRadius: BorderRadius.circular(10),
                                )
                              ]),
                          endActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (ctx) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return CategoryEditScreen(
                                          categoryName: data.categoryName,
                                          categoryType: data.type,
                                          CategoryId: data.id);
                                    }));
                                  },
                                  icon: FontAwesomeIcons.penToSquare,
                                  autoClose: true,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  borderRadius: BorderRadius.circular(10),
                                  backgroundColor: Colors.blue,
                                  label: 'Edit',
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: PhysicalModel(
                              color: Colors.black,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              elevation: 6.0,
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
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
                                            Text(data.categoryName,
                                                style: const TextStyle(
                                                    fontSize: 19,
                                                    fontFamily:
                                                        'texgyreadventor-regular',
                                                    fontWeight: FontWeight.w900,
                                                    color: Color.fromARGB(
                                                        255, 255, 0, 0))),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
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
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                itemCount: expenseList.length),
          );
        });
  }
}
