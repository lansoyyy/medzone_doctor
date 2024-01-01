import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medzone/screens/auth/login_screen.dart';
import 'package:medzone/screens/edit_profile_tab.dart';
import 'package:medzone/widgets/text_widget.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Doctors')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: userData,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              dynamic data = snapshot.data;
              return SafeArea(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Profile',
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
                            height: 10,
                          ),
                          TextWidget(
                            text:
                                '${data['fname']} ${data['mname'][0]}. ${data['lname']}',
                            fontSize: 18,
                            fontFamily: 'Bold',
                          ),
                          TextWidget(
                            text: data['email'],
                            fontSize: 14,
                            fontFamily: 'Bold',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 20),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileTab()));
                              },
                              leading: const Icon(Icons.person),
                              title: TextWidget(
                                text: 'Edit Profile',
                                fontSize: 18,
                                fontFamily: 'Medium',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 20),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Logout Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to Logout?',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                // await FirebaseAuth.instance
                                                //     .signOut();
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen()));
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              leading: const Icon(Icons.logout),
                              title: TextWidget(
                                text: 'Logout',
                                fontSize: 18,
                                fontFamily: 'Medium',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
            }),
      ),
    );
  }
}
