import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager/db/user/user_db.dart';
import 'package:money_manager/models/userModel/user_model.dart';
import 'package:recase/recase.dart';

class ProfileEditScreen extends StatefulWidget {
  final String image;
  final String name;

  const ProfileEditScreen({super.key, required this.image, required this.name});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController nameController = TextEditingController();
  String? imageData;
  @override
  Widget build(BuildContext context) {
    nameController.text = widget.name;
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
          'Edit Profile',
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'texgyreadventor-regular',
              color: Colors.black,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: ClipOval(
                child: imageData != null
                    ? Image.file(
                        File(imageData!),
                        fit: BoxFit.cover,
                      )
                    : widget.image == ''
                        ? Image.asset('assets/images/profile.png')
                        : Image.file(File(widget.image)),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                AddImage();
              },
              icon: const FaIcon(FontAwesomeIcons.penToSquare),
              label: const Text('Add Image')),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('User Name',
                      style: TextStyle(
                          fontFamily: 'Raleway-VariableFont_wght',
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async{
                String image;
                if(imageData==null){
                  image = widget.image;
                }else{
                  image = imageData!;
                }
                final userData = UserModel(profilePicture: image, userName: nameController.text.titleCase, id: '1');
                await addUser(userData);
                Navigator.of(context).pop();
              },
              icon: const FaIcon(FontAwesomeIcons.check),
              label: const Text('Update'))
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> AddImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      String imgData = img.path;
      setState(() {
        imageData = imgData;
      });
    }
  }
}
