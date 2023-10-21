import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/Screens/categories/screens/categories_screen.dart';
import 'package:money_manager/Screens/HomeScreen/screens/home_screen.dart';
import 'package:money_manager/Screens/Settings/screens/settings_screen.dart';
import 'package:money_manager/Screens/Stats/screens/stats_screen.dart';
import 'package:money_manager/Screens/Transactions/screens/transaction_screnn.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int? currentTab;
  final List<Widget> screens = [
    const TransactionsScreen(),
    const StatsScreen(),
    const HomeScreen(),
    const CategoryScreen(),
    SettingsScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 40,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                currentScreen = const HomeScreen();
                currentTab = null;
              });
            },
            child: const FaIcon(FontAwesomeIcons.house),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                minWidth: 20,
                onPressed: () {
                  setState(() {
                    currentScreen = const TransactionsScreen();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.indianRupeeSign,
                      color: currentTab == 0 ? Colors.blue : Colors.black,
                      size: 15,
                    ),
                    Text(
                      'Transactions',
                      style: TextStyle(
                        color: currentTab == 0 ? Colors.blue : Colors.black,
                        fontSize: 15
                        
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 20,
                onPressed: () {
                  setState(() {
                    currentScreen = const StatsScreen();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.chartPie,
                      size: 15,
                      color: currentTab == 1 ? Colors.blue : Colors.black,
                    ),
                    Text(
                      'Stats',
                      style: TextStyle(
                        color: currentTab == 1 ? Colors.blue : Colors.black,
                        fontSize: 15
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 20,
                onPressed: () {
                  setState(() {
                    currentScreen = const CategoryScreen();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.boxesStacked,
                      size: 15,
                      color: currentTab == 2 ? Colors.blue : Colors.black,
                    ),
                    Text(
                      'Categories',
                      style: TextStyle(
                        color: currentTab == 2 ? Colors.blue : Colors.black,
                        fontSize: 15
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 20,
                onPressed: () {
                  setState(() {
                    currentScreen = SettingsScreen();
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.gear,
                      size: 15,
                      color: currentTab == 3 ? Colors.blue : Colors.black,
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: currentTab == 3 ? Colors.blue : Colors.black,
                        fontSize: 15
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }  
}