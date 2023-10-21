import 'package:flutter/material.dart';
import 'package:money_manager/Screens/splashScreen/splash_screen.dart';
import 'package:money_manager/db/main_db_functions/main_db_functions.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await InitDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var textHeightPortrait = MediaQuery.of(context).size.width*0.047;
    var textHeightLandscape = MediaQuery.of(context).size.height*0.05;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey,
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: MediaQuery.of(context).orientation==Orientation.portrait?textHeightPortrait:textHeightLandscape,
        ),
      )
      ),
      home: const SplashScreen()
    );
  }
}