import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/Screens/Transactions/widgets/add_transaction_sample.dart';
import 'package:money_manager/Screens/categories/widgets/add_category.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/categoryModel/category_model.dart';
import 'package:money_manager/models/transactionModel/transactions_model.dart';

class RecentTransactions extends StatelessWidget {
  ScrollController scrollController = ScrollController();
  RecentTransactions({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    var tileHeightPortrait = MediaQuery.of(context).size.height > 800
        ? MediaQuery.of(context).size.height * 0.08
        : MediaQuery.of(context).size.height * 0.1;
    var tileHeightLandscape = MediaQuery.of(context).size.height * 0.2;
    var textHeightPortrait = MediaQuery.of(context).size.width * 0.047;
    var textHeightLandscape = MediaQuery.of(context).size.height * 0.05;
    var dateBoxSizePortrait = MediaQuery.of(context).size.height > 800
        ? MediaQuery.of(context).size.height * 0.050
        : MediaQuery.of(context).size.height * 0.057;
    var dateBoxSizeLandscape = MediaQuery.of(context).size.height * 0.12;
    return SizedBox(
      height: 700,
      child: ValueListenableBuilder(
        valueListenable: TransactionDb().recentTransactionsList,
        builder:
            (BuildContext context, List<TransactionModel> newList, Widget? _) {
          return TransactionDb().allTransactionsList.value.isNotEmpty
              ? ListView.separated(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = newList[newList.length - index - 1];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(9, 5, 9, 5),
                      child: PhysicalModel(
                        color: Colors.black,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 6.0,
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? tileHeightPortrait
                              : tileHeightLandscape,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PhysicalModel(
                                  color: Colors.black,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 4.0,
                                  child: Container(
                                    width: MediaQuery.of(context).orientation ==
                                            Orientation.portrait
                                        ? dateBoxSizePortrait
                                        : dateBoxSizeLandscape,
                                    height:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? dateBoxSizePortrait
                                            : dateBoxSizeLandscape,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 232, 235, 235),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          parseDate(data.date),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? textHeightPortrait - 5
                                                  : textHeightLandscape - 5,
                                              fontFamily:
                                                  'texgyreadventor-regular',
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromARGB(
                                                  255, 2, 39, 71)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data.purpose,
                                          style: const TextStyle(
                                              fontFamily:
                                                  'texgyreadventor-regular',
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromARGB(
                                                  255, 2, 39, 71))),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      data.type == CategoryType.income
                                          ? Text(data.categorySubType,
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? textHeightPortrait - 5
                                                      : textHeightLandscape -
                                                          10,
                                                  fontFamily:
                                                      'texgyreadventor-regular',
                                                  fontWeight: FontWeight.w900,
                                                  color: Color.fromARGB(
                                                      255, 33, 165, 6)))
                                          : Text(data.categorySubType,
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context)
                                                              .orientation ==
                                                          Orientation.portrait
                                                      ? textHeightPortrait - 5
                                                      : textHeightLandscape -
                                                          10,
                                                  fontFamily:
                                                      'texgyreadventor-regular',
                                                  fontWeight: FontWeight.w900,
                                                  color: Color.fromARGB(255, 255, 0, 0))),
                                    ],
                                  ),
                                ),
                                Text('₹${data.amount}',
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? textHeightPortrait + 5
                                            : textHeightLandscape + 5,
                                        fontFamily: 'texgyreadventor-regular',
                                        fontWeight: FontWeight.w600,
                                        color: data.type == CategoryType.income
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
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 1,
                    );
                  },
                  itemCount: newList.length>5?5:newList.length)
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No Data Added'),
                    TextButton.icon(
                        onPressed: () async {
                          CategoryDb().allCategoriesList.value.isNotEmpty
                              ? Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                  return AddTransactionsSample();
                                }))
                              : ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: Text(
                                    'Please Add Some Categories Before Adding Transactions',
                                    style: TextStyle(
                                        fontFamily: 'texgyreadventor-regular'),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  padding: EdgeInsets.all(20),
                                  action: SnackBarAction(
                                      label: 'Add Category',
                                      textColor: Colors.blue,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (ctx) {
                                          return CategoryAddScreen();
                                        }));
                                      }),
                                ));
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        label: Text(
                          'Start Adding Transactions',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontFamily: 'texgyreadventor-regular',
                          ),
                        ))
                  ],
                ));
        },
      ),
    );
  }

  String parseDate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitDate = date0.split(' ');
    return '${splitDate[1]}\n${splitDate[0]}';
  }
}
