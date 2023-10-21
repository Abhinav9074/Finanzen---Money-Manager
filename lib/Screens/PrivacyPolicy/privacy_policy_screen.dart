import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'texgyreadventor-regular',
              color: Colors.black,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: ListView(children: const [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Privacy Policy',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'texgyreadventor-regular',
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Text(
            '''Billion Dots Devs built the Money Manager app as an Open Source app. This SERVICE is provided by Billion Dots Devs at no cost and is intended for use as is. This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Money Manager unless otherwise defined in this Privacy Policy.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            'Security',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'texgyreadventor-regular',
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Text(
            '''We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
      ]),
    );
  }
}
