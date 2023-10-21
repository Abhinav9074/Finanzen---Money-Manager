import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/Screens/splashScreen/splash_screen.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  final Uri _url = Uri.parse('https://www.instagram.com/_abhin__av_/');
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 235, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 235, 235),
        elevation: 0,
        title: const Text(
          'App Settings',
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'texgyreadventor-regular',
              color: Colors.black,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'About',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'texgyreadventor-regular',
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
            child: TextButton(
                onPressed: () {
                  _launchUrl();
                },
                child: const Text(
                  'Contact Us',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'texgyreadventor-regular',
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
            child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  }, 
                                  icon: const FaIcon(FontAwesomeIcons.x,color: Colors.red,)),
                                IconButton(
                                  onPressed: ()async{
                                    await TransactionDb().DeleteAllDb();
                                    Navigator.of(context).pop();
                                    await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('App Reset Completed') ));
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){return SplashScreen();}), (route) => false);
                                  }, 
                                  icon: const FaIcon(FontAwesomeIcons.check,color: Colors.green,))
                              ],
                            )
                            ],
                          title: const Text(
                            'Are You Sure',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'texgyreadventor-regular',
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          content: const Text(
                            'The App Will Be Reset',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'texgyreadventor-regular',
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        );
                      });
                },
                child: const Text(
                  'Clear App Data',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'texgyreadventor-regular',
                      color: Color.fromARGB(255, 255, 0, 0),
                      fontWeight: FontWeight.w900),
                )),
          )
        ],
      )),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
