import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_manager/Screens/HomeScreen/widgets/custom_navigation_bar.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();
    Timer(const Duration(seconds: 5), () async{
      TransactionDb().CalculateTotal();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return const CustomNavigationBar();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/loading.gif'),
            const Text(
              'Finanzen - Money Manager',
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'texgyreadventor-regular',
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}
