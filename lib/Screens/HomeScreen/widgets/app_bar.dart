import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/Screens/budget/screens/budget_screen.dart';
import 'package:money_manager/db/user/user_db.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  children: [
                    PhysicalModel(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      elevation: 8.0,
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: ValueListenableBuilder(
                            valueListenable: userProfileNotifier,
                            builder: (BuildContext context, String picture,
                                Widget? _) {
                              return ClipOval(
                                child: picture == ''
                                    ? Image.asset(
                                        'assets/images/profile.png',
                                        width: 50,
                                      )
                                    : Image.file(
                                        File(picture),
                                        width: 30,
                                        height: 30,
                                      ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ValueListenableBuilder(
                        valueListenable: userNameNotifier,
                        builder:
                            (BuildContext context, String name, Widget? _) {
                          return name == ''
                              ? Text(
                                  'Hi',
                                  style: TextStyle(
                                      fontFamily: 'Raleway-VariableFont_wght',
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  'Hi ${name}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Raleway-VariableFont_wght',
                                      fontWeight: FontWeight.w600),
                                );
                        })
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return BudgetScreen();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: PhysicalModel(
                      elevation: 3,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 232, 235, 235),
                            
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.1)),
                        child: Image.asset(
                          'assets/images/budget.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 100);
}
