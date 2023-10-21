import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
          'Terms And Conditions',
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
            'Last Updated: September 23, 2023',
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
            '''Please read these Terms and Conditions carefully before using the Money Manager provided by Billion Dots . By downloading, accessing, or using the App, you agree to comply with and be bound by these Terms. If you do not agree with any part of these Terms, please do not use the App.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            '1. Use of the App',
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
            '''1.1. Eligibility : You must be at least 18 years of age or the legal age of majority in your jurisdiction to use the App. By using the App, you represent and warrant that you meet this eligibility requirement.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            '2. User Responsibilities',
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
            '''2.1. Accuracy of Information: You are responsible for the accuracy of the financial and personal information you input into the App. We do not verify the accuracy of the information you provide, and you acknowledge that any financial decisions you make based on the App's information are your sole responsibility.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            '3. Intellectual Property',
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
            '''3.1. Ownership: The App, including all content, features, and functionality, is owned by us or our licensors and is protected by copyright, trademark, and other intellectual property laws. You may not reproduce, distribute, modify, or create derivative works of the App without our prior written consent.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            '4. Disclaimer of Warranties',
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
            '''4.1. No Warranty: The App is provided "as is" and "as available" without any warranties of any kind, whether express or implied. We do not warrant that the App will be error-free, secure, or uninterrupted. Your use of the App is at your own risk.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            '5. Limitation of Liability',
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
            '''5.1. Indirect Damages: In no event shall we be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, arising out of your access to or use of the App.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            '6. Termination',
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
            '''6.1. Termination: We reserve the right to terminate or suspend your access to the App at any time, with or without cause, and with or without notice. Upon termination, your right to use the App will cease immediately.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            '7. Changes to Terms',
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
            '''7.1. Modifications: We reserve the right to update or modify these Terms at any time, and such changes will be effective immediately upon posting on the App. You are responsible for reviewing these Terms periodically to stay informed of any changes. Your continued use of the App after the posting of changes constitutes your acceptance of those changes.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            '8. Governing Law',
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
            '''8.1. Jurisdiction: These Terms are governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law principles.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Text(
            '9. Contact Information',
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
            '''9.1. Contact Us: If you have any questions about these Terms or the App, please contact us at''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Text(
            '''By using the Money Manager App, you acknowledge that you have read, understood, and agree to these Terms and Conditions.''',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(height: 30,),
      ]),
    );
  }
}
