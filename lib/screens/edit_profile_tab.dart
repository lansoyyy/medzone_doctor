import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medzone/screens/home_screen.dart';
import 'package:medzone/widgets/button_widget.dart';
import 'package:medzone/widgets/text_widget.dart';
import 'package:medzone/widgets/textfield_widget.dart';
import 'package:medzone/widgets/toast_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class EditProfileTab extends StatefulWidget {
  const EditProfileTab({super.key});

  @override
  State<EditProfileTab> createState() => _EditProfileTabState();
}

class _EditProfileTabState extends State<EditProfileTab> {
  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Doctors/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Doctors/$fileName')
            .getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Doctors')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profilePicture': imageURL});

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  final firstnameController = TextEditingController();
  final middlenameController = TextEditingController();
  final lastnameController = TextEditingController();
  final dateController = TextEditingController();

  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextWidget(
                      text: 'Edit Profile',
                      fontSize: 24,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/profile.png',
                      height: 125,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextFieldWidget(
                        label: 'First Name',
                        hintColor: Colors.black,
                        controller: firstnameController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextFieldWidget(
                        label: 'Middle Name',
                        hintColor: Colors.black,
                        controller: middlenameController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextFieldWidget(
                        label: 'Last Name',
                        hintColor: Colors.black,
                        controller: lastnameController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextFieldWidget(
                        inputType: TextInputType.number,
                        label: 'Contact Number',
                        hintColor: Colors.black,
                        controller: numberController,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                      label: 'Update',
                      onPressed: () async {
                        showToast('Profile updated!');
                        await FirebaseFirestore.instance
                            .collection('Doctors')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'number': numberController.text,
                          'fname': firstnameController.text,
                          'mname': middlenameController.text,
                          'lname': lastnameController.text
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
