import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/Screens/Transactions/widgets/add_transaction_sample.dart';
import 'package:money_manager/Screens/categories/widgets/add_category.dart';
import 'package:money_manager/Screens/transactions/widgets/all_transaction.dart';
import 'package:money_manager/Screens/transactions/widgets/expense_transactions.dart';
import 'package:money_manager/Screens/transactions/widgets/filter_sheet.dart';
import 'package:money_manager/Screens/transactions/widgets/income_transactions.dart';
import 'package:money_manager/Screens/transactions/widgets/sort_sheet.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with TickerProviderStateMixin {
  // ignore: prefer_typing_uninitialized_variables
  var size, height;
  TextEditingController searchText = TextEditingController();
  late TabController _tabController;
  ValueNotifier<int> sortIndex = ValueNotifier(2);
  ValueNotifier<String> startDateNotifier =
      ValueNotifier(DateTime.now().toString().substring(0, 10));
  ValueNotifier<String> endDateNotifier =
      ValueNotifier(DateTime.now().toString().substring(0, 10));
  ValueNotifier<String> categoryNotifier = ValueNotifier('Select a category');

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    CategoryDb().refreshUI();
    TransactionDb().refreshUI();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the TabController to prevent memory leaks
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   onPressed: () {},
      //   child: FaIcon(FontAwesomeIcons.plus),
      // ),
      backgroundColor: const Color.fromARGB(255, 232, 235, 235),
      appBar: AppBar(
        title: const Text(
          'Transactions',
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
      body: Stack(
        children: [
          Column(
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                  width: double.infinity,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: TextFormField(
                      controller: searchText,
                      onChanged: (val) {
                        if (val.isEmpty) {
                          TransactionDb().refreshUI();
                        } else {
                          TransactionDb().searchTransactions(val.trim());
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              searchText.clear();
                              TransactionDb().refreshUI();
                            },
                          ),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: const Text(
                            'Search Transactions',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'texgyreadventor-regular'),
                          )),
                    ),
                  )),
              TabBar(
                  onTap: (value) async {
                    await TransactionDb().refreshUI();
                    startDateNotifier.value = 
                        DateTime.now().toString().substring(0, 10);
                    endDateNotifier.value = 
                        DateTime.now().toString().substring(0, 10);
                    categoryNotifier.value = 'Select a category';
                    sortIndex.value = 2;
                  },
                  isScrollable: false,
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(
                      fontSize: 16, fontFamily: 'texgyreadventor-regular'),
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Income',
                    ),
                    Tab(
                      text: 'Expense',
                    ),
                  ]),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: const [
                      AllTransactions(),
                      IncomeTransactions(),
                      ExpenseTransaction(),
                    ]),
              )
            ],
          ),
          Positioned(
            bottom: 15,
            right: 20,
            child: CircleAvatar(
              minRadius: 15,
              maxRadius: 20,
              backgroundColor: Colors.black,
              child: IconButton(
                  onPressed: () {
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
                  icon: const FaIcon(FontAwesomeIcons.plus)),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(40, 25),
                    maximumSize: const Size(400, 50),
                  ),
                    onPressed: () {
                      ShowSortSheet(context, sortIndex);
                    },
                    icon: const FaIcon(FontAwesomeIcons.sort,size: 10,),
                    label: const Text('Sort',style: TextStyle(fontSize: 15,fontFamily: 'texgyreadventor-regular'),)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(40, 25),
                    maximumSize: const Size(400, 50),
                  ),
                    onPressed: () {
                      ShowFilterSheet(context, _tabController.index, height,
                          startDateNotifier, endDateNotifier, categoryNotifier);
                    },
                    icon: const FaIcon(FontAwesomeIcons.filter,size: 10,),
                    label: const Text('Filter',style: TextStyle(fontSize: 15,fontFamily: 'texgyreadventor-regular'))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
