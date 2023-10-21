import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/Screens/HomeScreen/widgets/app_bar.dart';
import 'package:money_manager/Screens/HomeScreen/widgets/balance_widget.dart';
import 'package:money_manager/Screens/HomeScreen/widgets/drawer_items.dart';
import 'package:money_manager/Screens/HomeScreen/widgets/income_expense_tile.dart';
import 'package:money_manager/Screens/HomeScreen/widgets/recent_transactions.dart';
import 'package:money_manager/db/budget/budget_db.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/deleted/deleted_db_functions.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/db/user/user_db.dart';


// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var size, height, width;
  String? notify;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BudgetDb().AutoDeleteBudget();
    getUser();
    DeletedTransactionDb().refreshUI();
      TransactionDb().refreshUI();
      CategoryDb().refreshUI();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DeletedTransactionDb().AutoDeleting(context);
    TransactionDb().refreshUI();
      notify = 'Recent Transactions';
    
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 235, 235),
      appBar: const HomeAppBar(),
      drawer: const SafeArea(
        child: Drawer(
          child: DrawerItems(),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
              child: ListView(
            controller: _scrollController,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Column(
                    children:[
                      const TotalBalanace(),
                      const IncomeExpenseTile(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 25, 0, 10),
                            child: Text(
                              notify!=null?notify!:'no',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'texgyreadventor-regular',
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 2, 39, 71)),
                            ),
                          ),
                        
                        ],
                      ),
                      RecentTransactions(scrollController: _scrollController),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
          Positioned(
              bottom: 20,
              right: 20,
              child: CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      _scrollController.animateTo(0.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    icon: const FaIcon(FontAwesomeIcons.arrowUp)),
              ))
        ],
      ),
    );
  }
}
