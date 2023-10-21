import 'dart:io';
import 'package:flutter/material.dart';
import 'package:money_manager/Screens/deletedTransactions/screens/deleted_transactions.dart';
import 'package:money_manager/Screens/faq/screens/faq_screen.dart';
import 'package:money_manager/Screens/PrivacyPolicy/privacy_policy_screen.dart';
import 'package:money_manager/Screens/ProfileEditScreen/screens/profile_edit_screen.dart';
import 'package:money_manager/Screens/TermsAndCondition/terms_and_conditions.dart';
import 'package:money_manager/db/user/user_db.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            PhysicalModel(
              color: Colors.black,
              shape: BoxShape.circle,
              elevation: 8.0,
              child: ValueListenableBuilder(
                  valueListenable: userProfileNotifier,
                  builder: (BuildContext context, String picture, Widget? _) {
                    return picture == ''
                        ? ClipOval(
                            child: Image.asset(
                              'assets/images/profile.png',
                              height: 100,
                              width: 100,
                            ),
                          )
                        : ClipOval(
                            child: Image.file(File(picture),
                                height: 100, width: 100),
                          );
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            ValueListenableBuilder(
                valueListenable: userNameNotifier,
                builder: (BuildContext context, String name, Widget? _) {
                  return name == ''
                      ? Text('User Name',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Raleway-VariableFont_wght',
                              fontWeight: FontWeight.w600))
                      : Text('${name}',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Raleway-VariableFont_wght',
                              fontWeight: FontWeight.w600));
                }),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return ProfileEditScreen(
                        image: userProfileNotifier.value,
                        name: userNameNotifier.value);
                  }));
                },
                icon: Icon(Icons.edit),
                label: Text('Edit'))
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const DeletedTransactions();
                          }));
                        },
                        child: const Text(
                          'Deleted Transactions',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'texgyreadventor-regular',
                              color: Color.fromARGB(255, 130, 129, 129)),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const FaqScreen();
                          }));
                        },
                        child: const Text('Faq',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'texgyreadventor-regular',
                                color: Color.fromARGB(255, 130, 129, 129)))),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const PrivacyPolicyScreen();
                          }));
                        },
                        child: const Text('Privacy Policy',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'texgyreadventor-regular',
                                color: Color.fromARGB(255, 130, 129, 129)))),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const TermsAndConditionsScreen();
                          }));
                        },
                        child: const Text('Terms and Conditions',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'texgyreadventor-regular',
                                color: Color.fromARGB(255, 130, 129, 129))))
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
