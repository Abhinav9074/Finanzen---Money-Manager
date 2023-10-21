import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 235, 235),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
            )),
        backgroundColor: const Color.fromARGB(255, 232, 235, 235),
        elevation: 0,
        title: const Text(
          'FAQ',
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'texgyreadventor-regular',
              color: Colors.black,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        const ExpansionTile(
          title: Text(
            'How Can I add Transactions ?',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'texgyreadventor-regular',
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w900),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Users can add transactions by navigating to the transaction tab from the home screen and clicking on the + button',textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'texgyreadventor-regular',
                    color: Color.fromARGB(255, 150, 144, 144),
                    fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
        const SizedBox(height: 15,),
        const ExpansionTile(
          title: Text(
            'Is This App Safe To Use ?',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'texgyreadventor-regular',
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w900),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Yes , Money Manager is a well organised and user friendly app that is trusted and used by millions of people worldwide',textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'texgyreadventor-regular',
                    color: Color.fromARGB(255, 150, 144, 144),
                    fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
        const SizedBox(height: 15,),
        const ExpansionTile(
          title: Text(
            'How Can I Restore the deleted transactions ?',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'texgyreadventor-regular',
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w900),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Users can restore the deleted transactions withing 30 days from the deletion date , the deleted transactions page can be found as the second option in the drawer in home screen',textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'texgyreadventor-regular',
                    color: Color.fromARGB(255, 150, 144, 144),
                    fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
        const SizedBox(height: 15,),
        const ExpansionTile(
          title: Text(
            'How to view the statistics of my monthly transactions ?',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'texgyreadventor-regular',
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w900),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Navigate to the stats tab from the home screen to view the graph reppresentation of the monthly transactions',textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'texgyreadventor-regular',
                    color: Color.fromARGB(255, 150, 144, 144),
                    fontWeight: FontWeight.w900),
              ),
            )
          ],
        )
      ]),
    );
  }
}
